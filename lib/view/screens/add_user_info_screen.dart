import 'package:cals_calc/cubit/main_app_cubit/app_cubit.dart';
import 'package:cals_calc/cubit/main_app_cubit/app_states.dart';
import 'package:cals_calc/utils/colors.dart';
import 'package:cals_calc/utils/size_config.dart';
import 'package:cals_calc/view/widgets/add_info_widgets/activity_widget.dart';
import 'package:cals_calc/view/widgets/height_size_box.dart';
import 'package:cals_calc/view/widgets/add_info_widgets/reusable_form_field_widget.dart';
import 'package:cals_calc/view/widgets/text_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/user_data_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddInfoScreen extends StatelessWidget {
  AddInfoScreen({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return AppCubit();
      },
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Add Info"),
              centerTitle: true,
              backgroundColor: mainColor2,
            ),
            backgroundColor: mainColor4,
            body: Padding(
              padding: EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// choosing gender
                      HeightSizeBox(SizeConfig.defaultSize! * .5),
                      KTextUtils(
                          text: "Gender",
                          size: 20,
                          color: black,
                          fontWeight: FontWeight.w900,
                          textDecoration: TextDecoration.none),
                      HeightSizeBox(20),
                      SizedBox(
                          height: SizeConfig.defaultSize! * 6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  AppCubit.get(context).changeGender(0);

                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: 1.5,
                                          color: AppCubit.get(context).male
                                              ? mainColor2
                                              : Colors.grey.shade400)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/male.png",
                                        height: 22,
                                        width: 22,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "ذكر",
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  AppCubit.get(context).changeGender(1);

                                 },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: 1.5,
                                          color: AppCubit.get(context).female
                                              ? mainColor2
                                              : Colors.grey.shade400)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/female.png",
                                        height: 22,
                                        width: 22,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "أنثى",
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),

                      /// Adding Name

                      KTextUtils(
                          text: "Name",
                          size: 20,
                          color: black,
                          fontWeight: FontWeight.w900,
                          textDecoration: TextDecoration.none),
                      HeightSizeBox(SizeConfig.defaultSize! * .5),
                      ReusableFromField(
                          controller: nameController,
                          label: "الاسم",
                          obscureText: false,
                          validator: (d) {
                            if (nameController.text.isEmpty) {
                              return "ادخل اسمك من فضلك";
                            }
                          },
                          hintText: "ادخل اسمك",
                          textInputType: TextInputType.name),
                      HeightSizeBox(SizeConfig.defaultSize!),

                      /// Adding height

                      KTextUtils(
                          text: "Height",
                          size: 20,
                          color: black,
                          fontWeight: FontWeight.w900,
                          textDecoration: TextDecoration.none),
                      HeightSizeBox(SizeConfig.defaultSize! * .5),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                //width: SizeConfig.width! * .6,
                                child: ReusableFromField(
                                    controller: heightController,
                                    label: "الطول",
                                    obscureText: false,
                                    validator: (d) {
                                      if (nameController.text.isEmpty) {
                                        return "ادخل طولك من فضلك";
                                      }
                                    },
                                    hintText: "ادخل طولك",
                                    textInputType: TextInputType.phone),
                              ),
                            ),
                            SizedBox(width: SizeConfig.defaultSize!),
                            Text("CM"),
                            SizedBox(width: SizeConfig.defaultSize!),
                          ],
                        ),
                      ),
                      HeightSizeBox(SizeConfig.defaultSize!),

                      /// Adding age

                      KTextUtils(
                          text: "Age",
                          size: 20,
                          color: black,
                          fontWeight: FontWeight.w900,
                          textDecoration: TextDecoration.none),
                      HeightSizeBox(SizeConfig.defaultSize! * .5),
                      Row(
                        children: [
                          Expanded(
                            child: ReusableFromField(
                                controller: ageController,
                                label: "العمر",
                                obscureText: false,
                                validator: (d) {
                                  if (nameController.text.isEmpty) {
                                    return "ادخل عمرك من فضلك";
                                  }
                                },
                                hintText: "ادخل عمرك",
                                textInputType: TextInputType.phone),
                          ),
                          SizedBox(width: SizeConfig.defaultSize!),
                          Text("year"),
                          SizedBox(width: SizeConfig.defaultSize!),
                        ],
                      ),
                      HeightSizeBox(SizeConfig.defaultSize!),

                      /// Adding Weight

                      KTextUtils(
                          text: "Weight",
                          size: 20,
                          color: black,
                          fontWeight: FontWeight.w900,
                          textDecoration: TextDecoration.none),
                      HeightSizeBox(SizeConfig.defaultSize! * .5),
                      Row(
                        children: [
                          Expanded(
                            child: ReusableFromField(
                                controller: weightController,
                                label: "الوزن",
                                obscureText: false,
                                validator: (d) {
                                  if (nameController.text.isEmpty) {
                                    return "ادخل وزنك من فضلك";
                                  }
                                },
                                hintText: "ادخل وزنك",
                                textInputType: TextInputType.phone),
                          ),
                          SizedBox(width: SizeConfig.defaultSize!),
                          Text("kgm"),
                          SizedBox(width: SizeConfig.defaultSize!),
                        ],
                      ),
                      HeightSizeBox(SizeConfig.defaultSize!),

                      ///activities
                      ActivityWidget(),
                      HeightSizeBox(SizeConfig.defaultSize! * 2),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: RawMaterialButton(
                            onPressed: () {
                              if (!AppCubit.get(context).activity1 &&
                                      !AppCubit.get(context).activity2 &&
                                      !AppCubit.get(context).activity3 &&
                                      !AppCubit.get(context).activity4 ||
                                  !AppCubit.get(context).male &&
                                      !AppCubit.get(context).female &&
                                      nameController.text.isEmpty ||
                                  heightController.text.isEmpty ||
                                  ageController.text.isEmpty ||
                                  weightController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "رجاء اكمل البيانات",
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: mainColor,
                                    textColor: white,
                                    gravity: ToastGravity.TOP);
                              } else {
                                AppCubit.get(context).storeValue(
                                    context: context,
                                    gender: AppCubit().male ? 0 : 1,
                                    activity: AppCubit.get(context).activity1
                                        ? 0
                                        : AppCubit.get(context).activity2
                                            ? 1
                                            : AppCubit.get(context).activity3
                                                ? 2
                                                : 3,
                                    weight: weightController.text,
                                    age: ageController.text,
                                    height: heightController.text,
                                    name: nameController.text);
                              }

                            },
                            fillColor: mainColor2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "التالي",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      HeightSizeBox(SizeConfig.defaultSize! * 2),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
