import 'package:bloc/bloc.dart';
import 'package:cals_calc/view_model/cubit/main_app_cubit/app_states.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../../view/screens/bottom_nav_screens/home_screen.dart';
import '../../../view/screens/main_screen_layout.dart';
import 'package:cals_calc/view/screens/bottom_nav_screens/profile_screen.dart';
import 'package:cals_calc/view/screens/bottom_nav_screens/recipes_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool male = false;

  bool female = false;
  bool activity1 = false;
  bool activity2 = false;
  bool activity3 = false;
  bool activity4 = false;
  int currentIndex = 0;
  List<Widget> widgets = [HomeScreen(), RecipesScreen(), ProfileScreen()];

//test
  ///--------------------------------------------------app layout

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  ///--------------------------------------------------user details
  changeGender(int gender) {
    if (gender == 0) {
      male = true;
      female = false;
    } else {
      male = false;
      female = true;
    }
    emit(ChangeGenderState());
  }

  changeActivity(int activity, context) {
    FocusScope.of(context).unfocus();
    if (activity == 0) {
      activity1 = true;
      activity2 = false;
      activity3 = false;
      activity4 = false;
    } else if (activity == 1) {
      activity1 = false;
      activity2 = true;
      activity3 = false;
      activity4 = false;
    } else if (activity == 2) {
      activity1 = false;
      activity2 = false;
      activity3 = true;
      activity4 = false;
    } else if (activity == 3) {
      activity1 = false;
      activity2 = false;
      activity3 = false;
      activity4 = true;
    }
    emit(ChangeActivityState());
  }

  storeValue({
    required context,
    required int gender,
    required int activity,
    required String weight,
    required String age,
    required String height,
    required String name,
  }) async {
    double calories = 0;
    double extraCals = 0;
    double proteins = 0;
    double carbs = 0;
    double fats = 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    switch (activity) {
      case 0:
        extraCals = 1.2;
        break;
      case 1:
        extraCals = 1.375;
        break;
      case 2:
        extraCals = 1.55;
        break;
      case 3:
        extraCals = 1.725;
        break;
    }
    if (gender == 0) {
      calories = (10 * int.parse(weight)) +
          (6.25 * int.parse(height)) -
          (5 * int.parse(age)) +
          5;
      calories = calories * extraCals;
    } else {
      calories = (10 * int.parse(weight)) +
          (6.25 * int.parse(height)) -
          (5 * int.parse(age)) +
          161;
      calories = calories * extraCals;
    }
    proteins = int.parse((weight)) * 1.4;
    carbs = calories / 5;
    fats = (calories / 100) * 30 / 9;

    await preferences.setInt("c2", calories.round());
    await preferences.setInt("proteins", proteins.round());
    await preferences.setInt("carbs", carbs.round());
    await preferences.setInt("fats", fats.round());
    await preferences.setInt("gender", gender);
    await preferences.setInt("activity", activity);
    await preferences.setString("height", height);
    await preferences.setString("weight", weight);
    await preferences.setString("age", age);
    await preferences.setString("name", toBeginningOfSentenceCase(name)!);
    await preferences.setBool("isNew", false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainScreenLayout()));
    emit(StoreUserDataState());
  }

  calculateDate(DateTime myBornDate) {
    DateTime now = DateTime.now();
    int age = now.year - myBornDate.year;
    if (now.month < myBornDate.month ||
        (now.month == myBornDate.month && now.day < myBornDate.day)) {
      age--;
    }
    return age;
  }

  String toBeginningOfSentenceCase(String text) {
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }
}
//TEST again
