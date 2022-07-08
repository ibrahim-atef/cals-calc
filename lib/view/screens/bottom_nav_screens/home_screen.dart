
import 'package:cals_calc/utils/size_config.dart';
import 'package:cals_calc/view/components/height_size_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../utils/colors.dart';
import '../../../view_model/cubit/home_cubit/home_cubit.dart';
import '../../../view_model/cubit/home_cubit/home_states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return HomeCubit()..getHomeData();
      },
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (BuildContext context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,

              leading: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.4, color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 1),
                              color: Colors.grey.shade200,
                              blurRadius: 2)
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Text(
                      "اليوم",
                      style: TextStyle(fontSize: 16, color: black),
                    ),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: PopupMenuButton(
                      onSelected: (result) {
                        if (result == 2) {
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (context) => AboutAppInfo()));
                        }
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                              onTap: () {
                                // Share.share(
                                //     "Download the Smart Food Diet Planner app from the link below and maintain a good health by using this app.\nLink - https://play.google.com/store/apps/details?id=com.techvinay.diet_planner");
                              },
                              child: Text(
                                "شارك التطبيق",
                              )),
                          PopupMenuItem(
                              onTap: () async {
                                await canLaunch(
                                        "https://www.facebook.com/profile.php?id=100008374263814")
                                    ? await launch(
                                        "https://www.facebook.com/profile.php?id=100008374263814")
                                    : debugPrint("Cant launch");
                              },
                              child: Text(
                                "تابعنا",
                              )),
                        ];
                      }),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: mainColor2,
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const AddFoodScreen())).then((value) {
                //   getData();
                // });
              },
              child: const Icon(Icons.add),
            ),
            body: HomeCubit.get(context).isLoaded
                ? CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 8),
                          child: Container(
                              padding: const EdgeInsets.only(top: 14),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: mainColor2,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  )),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, bottom: 5, right: 16),
                                    child: Text(
                                      "أهلا بك، " + HomeCubit.get(context).name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Center(
                                    child: CircularPercentIndicator(
                                      backgroundColor:
                                          Colors.white54.withOpacity(0.4),
                                      radius: SizeConfig.defaultSize! * 5,
                                      animation: true,
                                      progressColor: Colors.white,
                                      percent: HomeCubit.get(context)
                                                  .consumedCals >=
                                              HomeCubit.get(context).calories
                                          ? 1.0
                                          : HomeCubit.get(context)
                                                  .consumedCals /
                                              HomeCubit.get(context).calories,
                                      lineWidth: 9,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      center: HomeCubit.get(context)
                                                  .consumedCals <
                                              HomeCubit.get(context).calories
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  (HomeCubit.get(context)
                                                              .calories -
                                                          HomeCubit.get(context)
                                                              .consumedCals)
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "السعرات الحرارية المتبقية",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.done,
                                                  size: 26,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "0 سعرة حرارية متبقية",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  "تم تحقيق الهدف",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "مستهلك",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons
                                                    .local_fire_department_rounded,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                  HomeCubit.get(context)
                                                          .consumedCals
                                                          .toString() +
                                                      " سعر حراري",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            "المجموع",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons
                                                    .local_fire_department_rounded,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                  HomeCubit.get(context)
                                                          .calories
                                                          .toString() +
                                                      " سعر حراري",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              )),
                        ),
                      ),
                      SliverToBoxAdapter(child: HeightSizeBox(8)),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            /// widget للاستهلاك اليومي
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, 1),
                                          color: Colors.grey.shade400,
                                          blurRadius: 2)
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          bottom: 10,
                                          right: 16),
                                      child: Text(
                                        "استهلاك اليوم",
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        buildNutritionWidget(context,"البروتينات", HomeCubit.get(context)
                                            .proteinsGrams
                                            .toString() +
                                            "/" +
                                            HomeCubit.get(context)
                                                .proteinsGramsTotal
                                                .toString() +
                                            " g",HomeCubit.get(context)
                                            .proteinsGrams >
                                            HomeCubit.get(context)
                                                .proteinsGramsTotal
                                            ? 1.0
                                            : HomeCubit.get(context)
                                            .proteinsGrams /
                                            HomeCubit.get(context)
                                                .proteinsGramsTotal),
                                        buildNutritionWidget(context, "الكربوهيدرات", HomeCubit.get(context)
                                            .carbsGrams
                                            .toString() +
                                            "/" +
                                            HomeCubit.get(context)
                                                .carbsGramsTotal
                                                .toString() +
                                            " g",  HomeCubit.get(context)
                                            .carbsGrams >
                                            HomeCubit.get(context)
                                                .carbsGramsTotal
                                            ? 1.0
                                            : HomeCubit.get(context)
                                            .carbsGrams /
                                            HomeCubit.get(context)
                                                .carbsGramsTotal),
                                  buildNutritionWidget(context, "الدهون",  HomeCubit.get(context)
                                      .fatsGrams
                                      .toString() +
                                      "/" +
                                      HomeCubit.get(context)
                                          .fatsGramsTotal
                                          .toString() +
                                      " g", HomeCubit.get(context)
                                      .fatsGrams >
                                      HomeCubit.get(context)
                                          .fatsGramsTotal
                                      ? 1.0
                                      : HomeCubit.get(context)
                                      .fatsGrams /
                                      HomeCubit.get(context)
                                          .fatsGramsTotal)
                                        ,
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),

                            /// باقي وجبات اليوم
                            buildPadding(
                                context,
                                "water",
                                "ماء",
                                "خذ كوبًا من الماء",
                                "اشرب " +
                                    HomeCubit.get(context).water.toString() +
                                    " كوب ",
                                () {}),
                            buildPadding(
                                context,
                                "breakfast",
                                "إفطار",
                                "يوصى بالسعرات الحرارية 300 - 400",
                                "مستهلك " +
                                    HomeCubit.get(context)
                                        .breakfastCals
                                        .toString() +
                                    " سعرات الحرارية",
                                () => null),
                            buildPadding(
                                context,
                                "lunch",
                                "غداء",
                                "يوصى بالسعرات الحرارية 500 - 600",
                                "مستهلك " +
                                    HomeCubit.get(context)
                                        .lunchCals
                                        .toString() +
                                    " سعرات الحرارية",
                                () => null),
                            buildPadding(
                                context,
                                "snacks",
                                "وجبات خفيفة",
                                "يوصى بالسعرات الحرارية 100 - 200",
                                "مستهلك " +
                                    HomeCubit.get(context)
                                        .snacksCals
                                        .toString() +
                                    " سعرات الحرارية",
                                () => null),
                            buildPadding(
                                context,
                                "dinner",
                                "عشاء",
                                "يوصى بالسعرات الحرارية 500 - 600",
                                "مستهلك " +
                                    HomeCubit.get(context)
                                        .dinnerCals
                                        .toString() +
                                    " سعرات الحرارية",
                                () => null),
                          ],
                        ),
                      )
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: mainColor2,
                    ),
                  ),
          );
        },
      ),
    );
  }

  Padding buildNutritionWidget(BuildContext context,String nutritionCategory,String grams,double percent) {
    return Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Text(nutritionCategory,
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              grams ,
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            LinearPercentIndicator(
                                              width: 65,
                                              lineHeight: 10,
                                              progressColor: mainColor2,
                                              linearStrokeCap: LinearStrokeCap.roundAll,
                                              percent: percent,
                                            )
                                          ],
                                        ),
                                      );
  }

  Padding buildPadding(BuildContext context, String img, String foodType,
      String description, String foodInstruction, Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: InkWell(
        onTap: onPressed
        //{
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //         const WaterScreen())).then((value) {
        //   getData();
        // });
        //},
        ,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: const Offset(0, 1),
                color: Colors.grey.shade400,
                blurRadius: 2)
          ], borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, bottom: 10, right: 16),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/$img.png",
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      foodType,
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: onPressed,
                      // onTap: () {
                      //   // Navigator.push(
                      //   //     context,
                      //   //     MaterialPageRoute(
                      //   //         builder: (context) =>
                      //   //         const WaterScreen()))
                      //   //     .then((value) {
                      //   //   getData();
                      //   // });
                      // },
                      child: Text(
                        "أضف",
                        style: TextStyle(
                            color: mainColor2, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 4, right: 16),
                child: Text(
                  description,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5, right: 16),
                child: Text(
                  foodInstruction,
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
