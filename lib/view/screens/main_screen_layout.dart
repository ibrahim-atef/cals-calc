import 'package:cals_calc/cubit/main_app_cubit/app_cubit.dart';
import 'package:cals_calc/cubit/main_app_cubit/app_states.dart';
import 'package:cals_calc/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class MainScreenLayout extends StatelessWidget {





  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            backgroundColor: Colors.grey[200],
              bottomNavigationBar: BottomNavigationBar(
              onTap: (i) {
               AppCubit.get(context).changeBottomNav(i);
              },
              currentIndex: AppCubit.get(context).currentIndex,
              fixedColor: mainColor2,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: "الرئيسيه"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.dining), label: "وصفات"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "الحساب"),
              ],
            ),
            body:AppCubit.get(context).widgets[AppCubit.get(context).currentIndex],
          ),
        );
      },
    );
  }
}
