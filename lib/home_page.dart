import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'video_info.dart';
import 'dart:convert';
import 'colors.dart' as color;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List info = [];

  _initData() {
    DefaultAssetBundle.of(context).loadString("json/info.json").then((value) {
      setState(() {
        info = jsonDecode(value);
      });
    });
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // optional
    ));
  }

  Future _onrefresh() async {
    await Future.delayed(Duration(seconds: 1));
    return Future.delayed(Duration(seconds: 0));
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      body: Container(
        padding: EdgeInsets.only(top: 40, left: 30, right: 30),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Training",
                  style: TextStyle(
                      fontSize: 30,
                      color: color.AppColor.homePageTitle,
                      fontWeight: FontWeight.w700),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: color.AppColor.homePageIcons,
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.calendar_today_outlined,
                  size: 20,
                  color: color.AppColor.homePageIcons,
                ),
                SizedBox(width: 15),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: color.AppColor.homePageIcons,
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  "Training",
                  style: TextStyle(
                      fontSize: 20,
                      color: color.AppColor.homePageSubtitle,
                      fontWeight: FontWeight.w700),
                ),
                Spacer(),
                Text(
                  "Details",
                  style: TextStyle(
                      fontSize: 20, color: color.AppColor.homePageDetail),
                ),
                SizedBox(width: 5),
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    Get.to(() => VideoInfo());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.5),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: color.AppColor.homePageIcons,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    color.AppColor.gradientFirst.withOpacity(0.8),
                    color.AppColor.gradientSecond.withOpacity(0.9)
                  ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(80)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(5, 10),
                        blurRadius: 20,
                        color: color.AppColor.gradientSecond.withOpacity(0.3))
                  ]),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, top: 25, right: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Next Workout",
                      style: TextStyle(
                          fontSize: 16,
                          color: color.AppColor.homePageContainerTextSmall),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Legs Toning",
                      style: TextStyle(
                          fontSize: 25,
                          color: color.AppColor.homePageContainerTextSmall),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "and Glues Workout",
                      style: TextStyle(
                          fontSize: 25,
                          color: color.AppColor.homePageContainerTextSmall),
                    ),
                    SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              size: 20,
                              color: color.AppColor.homePageContainerTextSmall,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "60 min",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: color
                                      .AppColor.homePageContainerTextSmall),
                            )
                          ],
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              boxShadow: [
                                BoxShadow(
                                    color: color.AppColor.gradientFirst,
                                    blurRadius: 10,
                                    offset: Offset(4, 8))
                              ]),
                          child: Icon(Icons.play_circle_fill,
                              size: 60, color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    height: 120,
                    margin: const EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage("assets/card.jpg"),
                            fit: BoxFit.fill),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 40,
                              offset: Offset(8, 10),
                              color: color.AppColor.gradientSecond
                                  .withOpacity(0.3)),
                          BoxShadow(
                              blurRadius: 10,
                              offset: Offset(-1, -5),
                              color: color.AppColor.gradientSecond
                                  .withOpacity(0.3)),
                        ]),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width - 200),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage("assets/figure.png"))),
                  ),
                  Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(left: 150, top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You are doing great",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: color.AppColor.homePageDetail),
                        ),
                        SizedBox(height: 10),
                        RichText(
                            text: TextSpan(
                          text: "keep it up\nstick to your plan",
                          style: TextStyle(
                              color: color.AppColor.homePagePlanColor,
                              fontSize: 16),
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  Text(
                    "Area of Focus",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: color.AppColor.homePageTitle),
                  )
                ],
              ),
            ),
            Expanded(
                child: OverflowBox(
              maxWidth: MediaQuery.of(context).size.width,
              child: RefreshIndicator(
                displacement: 20,
                backgroundColor: color.AppColor.homePageDetail,
                color: Colors.white,
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                onRefresh: _onrefresh,
                child: ListView.builder(
                  itemCount: info.length.toDouble() ~/ 2.toInt(),
                  itemBuilder: (_, i) {
                    int a = 2 * i;
                    int b = 2 * i + 1;
                    return Row(
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width - 90) / 2,
                          height: 170,
                          margin: const EdgeInsets.only(left: 30, bottom: 30),
                          padding: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: AssetImage(info[a]['img'])),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: Offset(5, 5),
                                    color: color.AppColor.gradientSecond
                                        .withOpacity(0.1)),
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: Offset(-5, -5),
                                    color: color.AppColor.gradientSecond
                                        .withOpacity(0.1)),
                              ]),
                          child: Center(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                info[a]['title'],
                                style: TextStyle(
                                    fontSize: 20,
                                    color: color.AppColor.homePageDetail),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: (MediaQuery.of(context).size.width - 90) / 2,
                          margin: const EdgeInsets.only(left: 30, bottom: 30),
                          padding: const EdgeInsets.only(bottom: 5),
                          height: 170,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: AssetImage(info[b]['img'])),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: Offset(5, 5),
                                    color: color.AppColor.gradientSecond
                                        .withOpacity(0.1)),
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: Offset(-5, -5),
                                    color: color.AppColor.gradientSecond
                                        .withOpacity(0.1)),
                              ]),
                          child: Center(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                info[b]['title'],
                                style: TextStyle(
                                    fontSize: 20,
                                    color: color.AppColor.homePageDetail),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
