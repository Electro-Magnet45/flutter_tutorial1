import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'colors.dart' as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  _VideoInfoState createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List videoInfo = [];
  bool _playArea = false;
  bool _isPlaying = false;
  int _isPlayingIndex = -1;
  VideoPlayerController? _controller;

  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString('json/videoinfo.json')
        .then((value) {
      setState(() {
        videoInfo = jsonDecode(value);
      });
    });
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, // optional
    ));
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: !_playArea
          ? BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                  color.AppColor.gradientFirst.withOpacity(0.9),
                  color.AppColor.gradientSecond
                ],
                  begin: const FractionalOffset(0.0, 0.2),
                  end: Alignment.topRight))
          : BoxDecoration(color: color.AppColor.gradientSecond),
      child: Column(
        children: [
          !_playArea
              ? Container(
                  padding: EdgeInsets.only(top: 70, left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(Icons.arrow_back_ios,
                                  size: 20,
                                  color: color.AppColor.secondPageIconColor),
                            ),
                            Spacer(),
                            Icon(Icons.info_outline,
                                size: 20,
                                color: color.AppColor.secondPageIconColor),
                          ],
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Legs Toning",
                          style: TextStyle(
                              fontSize: 25,
                              color: color.AppColor.secondPageTitleColor),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "and Glues Workout",
                          style: TextStyle(
                              fontSize: 25,
                              color: color.AppColor.secondPageTitleColor),
                        ),
                        SizedBox(height: 50),
                        Row(
                          children: [
                            Container(
                              width: 90,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: [
                                        color.AppColor
                                            .secondPageContainerGradient1stColor,
                                        color.AppColor
                                            .secondPageContainerGradient2ndColor
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timer,
                                    size: 20,
                                    color: color.AppColor.secondPageIconColor,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "60 min",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            color.AppColor.secondPageIconColor),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              width: 250,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      colors: [
                                        color.AppColor
                                            .secondPageContainerGradient1stColor,
                                        color.AppColor
                                            .secondPageContainerGradient2ndColor
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.handyman_outlined,
                                    size: 20,
                                    color: color.AppColor.secondPageIconColor,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Resistent band, kettebell",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            color.AppColor.secondPageIconColor),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ]),
                )
              : Container(
                  child: Column(children: [
                  Container(
                    height: 100,
                    padding:
                        const EdgeInsets.only(top: 50, left: 30, right: 30),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            debugPrint("tapped");
                          },
                          child: Icon(Icons.arrow_back_ios,
                              size: 20,
                              color: color.AppColor.secondPageTopIconColor),
                        ),
                        Spacer(),
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: color.AppColor.secondPageTopIconColor,
                        )
                      ],
                    ),
                  ),
                  _playView(context),
                  _controlView(context)
                ])),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(70))),
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(width: 30),
                    Text(
                      "Circuit 1: Legs Toning",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color.AppColor.circuitsColor),
                    ),
                    Spacer(),
                    Icon(Icons.loop, size: 30, color: color.AppColor.loopColor),
                    SizedBox(width: 10),
                    Text(
                      "3 sets",
                      style: TextStyle(
                          fontSize: 15, color: color.AppColor.setsColor),
                    ),
                    SizedBox(width: 20)
                  ],
                ),
                SizedBox(height: 20),
                Expanded(child: _listView())
              ],
            ),
          ))
        ],
      ),
    ));
  }

  void _onControllerUpdate() async {
    final controller = _controller;
    if (controller == null) return;
    if (!controller.value.isInitialized) return;

    final playing = controller.value.isPlaying;
    _isPlaying = playing;
  }

  _initializeVideo(int index) async {
    final controller =
        VideoPlayerController.network(videoInfo[index]['videoUrl']);
    _controller = controller;

    setState(() {});
    controller
      ..initialize().then((_) {
        _isPlayingIndex = index;
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
  }

  _listView() {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        itemCount: videoInfo.length,
        itemBuilder: (_, int index) {
          return GestureDetector(
              onTap: () {
                _initializeVideo(index);
                setState(() {
                  if (_playArea == false) _playArea = true;
                });
              },
              child: _buildCard(index));
        });
  }

  _buildCard(int index) {
    return Container(
      height: 135,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(videoInfo[index]['thumbnail']),
                        fit: BoxFit.cover)),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoInfo[index]['title'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      videoInfo[index]['time'],
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFFeaeefc),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '15s rest',
                    style: TextStyle(color: Color(0xFF839fed)),
                  ),
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < 70; i++)
                    Container(
                      width: 3,
                      height: 1,
                      decoration: BoxDecoration(
                          color: i.isEven ? Color(0xFF839fed) : Colors.white,
                          borderRadius:
                              i.isEven ? null : BorderRadius.circular(2)),
                    )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized)
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
            child: Text("Preparing...",
                style: TextStyle(fontSize: 20, color: Colors.white60))));
  }

  Widget _controlView(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      color: color.AppColor.gradientSecond,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () async {
                final index = _isPlayingIndex - 1;
                if (index >= 0 && videoInfo.length >= 0)
                  return _initializeVideo(index);
                Get.snackbar("Video List", "",
                    snackPosition: SnackPosition.BOTTOM,
                    icon: Icon(Icons.face, size: 30, color: Colors.white),
                    backgroundColor: color.AppColor.gradientSecond,
                    colorText: Colors.white,
                    messageText: Text(
                      "No videos ahead!",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ));
              },
              child: Icon(
                Icons.fast_rewind,
                size: 36,
                color: Colors.white,
              )),
          TextButton(
              onPressed: () async {
                if (_isPlaying) {
                  setState(() {
                    _isPlaying = false;
                  });
                  return _controller?.pause();
                }
                setState(() {
                  _isPlaying = true;
                });
                _controller?.play();
              },
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                size: 36,
                color: Colors.white,
              )),
          TextButton(
              onPressed: () async {
                final index = _isPlayingIndex + 1;
                if (index <= videoInfo.length - 1)
                  return _initializeVideo(index);
                Get.snackbar("Video List", "",
                    snackPosition: SnackPosition.BOTTOM,
                    icon: Icon(Icons.face, size: 30, color: Colors.white),
                    backgroundColor: color.AppColor.gradientSecond,
                    colorText: Colors.white,
                    messageText: Text(
                      "No more videos in the list",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ));
              },
              child: Icon(
                Icons.fast_forward,
                size: 36,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
