import 'package:bloc/bloc.dart';
import 'package:cals_calc/cubit/main_app_cubit/app_cubit.dart';
import 'package:cals_calc/cubit/main_app_cubit/app_states.dart';
import 'package:cals_calc/services/local/database_helper.dart';
import 'package:cals_calc/utils/bloc_observer.dart';
import 'package:cals_calc/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'cubit/home_cubit/home_cubit.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void callbackDispatcher() {
  var androidPlatformSpecifics = const AndroidNotificationDetails(
    "notif",
    "notif",
  );
  var platformSpecifics =
      NotificationDetails(android: androidPlatformSpecifics);

  Workmanager().executeTask((task, inputData) async {
    DateTime now = DateTime.now();

    if (now.hour >= 8 && now.hour <= 22) {
      DatabaseHelper databaseHelper = DatabaseHelper();
      await databaseHelper.openDB();
      await databaseHelper.newDate();
      List<Map<String, dynamic>> data = await databaseHelper.getData();

      int breakFast = data[0]["breakFastDone"];
      int lunch = data[0]["lunchDone"];
      int dinner = data[0]["dinnerDone"];
      int water = data[0]["water"];
      SharedPreferences preferences = await SharedPreferences.getInstance();

      if (task == "waterRemainder") {
        if (preferences.getBool("waterOn") ?? true) {
          debugPrint("Water remainder fired");
          if (water <= 10) {
            await notificationsPlugin.show(
                1,
                "حان وقت شرب الماء!",
                "اشرب كوبًا من الماء وقم بالتحديث في التطبيق",
                platformSpecifics,
                payload: 'water');
          }
        }
      } else if (task == "foodRemainder") {
        debugPrint("Food remainder fired");
        if (now.hour >= 8 && now.hour <= 10) {
          if (breakFast == 0) {
            await notificationsPlugin.show(
                1,
                "انه وقت الافطار !",
                "يرجى تناول وجبة الإفطار أو التحديث إذا تم تناولها بالفعل",
                platformSpecifics,
                payload: 'breakFast');
          }
        } else if (now.hour >= 12 && now.hour <= 14) {
          if (lunch == 0) {
            await notificationsPlugin.show(
                1,
                "وقت الغداء!",
                "يرجى أخذ غدائك أو التحديث إذا تم تناوله بالفعل",
                platformSpecifics,
                payload: 'lunch');
          }
        } else if (now.hour >= 20 && now.hour <= 22) {
          if (dinner == 0) {
            await notificationsPlugin.show(
                1,
                "حان وقت العشاء !",
                "يرجى أخذ العشاء أو التحديث إذا تم تناوله بالفعل",
                platformSpecifics,
                payload: 'dinner');
          }
        }
      }
    }
    debugPrint("*****Called******");
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(create: (BuildContext context) => HomeCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'cals calc',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: SplashScreen(),
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
