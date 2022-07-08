import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../database/local/database_helper.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int consumedCals = 0;
  int proteinsGrams = 0;
  int carbsGrams = 0;
  int fatsGrams = 0;
  int proteinsGramsTotal = 500;
  int carbsGramsTotal = 500;
  int fatsGramsTotal = 500;
  int calories = 10000;
  int breakfastCals = 0;
  int lunchCals = 0;
  int snacksCals = 0;
  int dinnerCals = 0;
  String name = "";
  int water = 0;
  bool isLoaded = false;
  getHomeData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

      calories = preferences.getInt("c2") ?? 0;
      proteinsGramsTotal = preferences.getInt("proteins") ?? 0;
      carbsGramsTotal = preferences.getInt("carbs") ?? 0;
      fatsGramsTotal = preferences.getInt("fats") ?? 0;
      name = preferences.getString("name") ?? "";

    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.openDB();
    await databaseHelper.newDate();

    List<Map<String, dynamic>> data = await databaseHelper.getData();

    if (data.isNotEmpty) {
print(data[0]["calories"]);
        consumedCals = data[0]["calories"];
        proteinsGrams = data[0]["proteins"];
        carbsGrams = data[0]["carbs"];
        fatsGrams = data[0]["fats"];
        breakfastCals = data[0]["breakfast_cals"];
        lunchCals = data[0]["lunch_cals"];
        snacksCals = data[0]["snacks_cals"];
        dinnerCals = data[0]["dinner_cals"];
        water = data[0]["water"];
        isLoaded = true;

    }emit(GetHomeDataStates());
  }
}
