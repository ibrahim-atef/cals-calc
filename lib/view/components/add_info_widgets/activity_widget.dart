import 'package:cals_calc/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view_model/cubit/main_app_cubit/app_cubit.dart';
import '../../../view_model/cubit/main_app_cubit/app_states.dart';


class ActivityWidget extends StatelessWidget {
  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;
  bool selected4 = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "What is your daily activity type?",
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            const SizedBox(
              height: 13,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () {
                  AppCubit.get(context).changeActivity(0,context);
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          width: 1.5,
                          color: AppCubit.get(context).activity1
                              ? mainColor2
                              : Colors.grey.shade400)),
                  child: Center(
                    child: Text(
                      "بدون تمرين",
                      style: TextStyle(color: Colors.grey[800], fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () {
                  AppCubit.get(context).changeActivity(1,context);
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          width: 1.5,
                          color: AppCubit.get(context).activity2
                              ? mainColor2
                              : Colors.grey.shade400)),
                  child: Center(
                    child: Text(
                      "القليل من التمرين",
                      style: TextStyle(color: Colors.grey[800], fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () {
                  AppCubit.get(context).changeActivity(2,context);
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          width: 1.5,
                          color: AppCubit.get(context).activity3
                              ? mainColor2
                              : Colors.grey.shade400)),
                  child: Center(
                    child: Text(
                      "تمرين متوسط",
                      style: TextStyle(color: Colors.grey[800], fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () {
                  AppCubit.get(context).changeActivity(3,context);
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          width: 1.5,
                          color: AppCubit.get(context).activity4
                              ? mainColor2
                              : Colors.grey.shade400)),
                  child: Center(
                    child: Text(
                      "تمرين كثير",
                      style: TextStyle(color: Colors.grey[800], fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
