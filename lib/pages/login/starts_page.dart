import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import '../../services/storage.dart';
import '../bottom_tab/bottom.dart';

import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class StartsPage extends StatefulWidget {
  @override
  _StartsPageState createState() => _StartsPageState();
}

class _StartsPageState extends State<StartsPage> {

  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    print('object');
    getUser();

    //配置视频地址
    setVideo();
  }

  void setVideo(){
    //配置视频地址
    setState(() {
      videoPlayerController = VideoPlayerController.network('https://zcxy.oss-cn-beijing.aliyuncs.com/App/loginVideo.mp4');
    });
  }


  // 判断用户有没有登录过
  Timer time;
  void getUser() async{
    var userinfo = await Storage.getString('userinfo');
    var phone = userinfo!=null ? json.decode(userinfo)['Mobile'] : '';
    // 如果登录过直接跳首页
    if(phone!='') {
      time = Timer(Duration(milliseconds:3000), (){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BottomPage()), (route) => route == null);
      });
    }else{
      Navigator.pushNamed(context, '/starts');
    }
  }

  @override
  Widget build(BuildContext context) {

    ScreenAdaper.init(context);

    return Scaffold(
        body: Container(
          width: double.infinity, height: ScreenAdaper.getScreenHeight(), 
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     // image: AssetImage('images/start.png'), 
          //     // image: NetworkImage('https://zcxy.oss-cn-beijing.aliyuncs.com/App/StartBackground.png'), 
          //     fit: BoxFit.fill,
          //   ),
          // ),
          child: videoPlayerController !=null ? Container(
            width: double.infinity, height: ScreenAdaper.getScreenHeight(),
              child: Chewie(
                controller: ChewieController(
                  videoPlayerController: videoPlayerController,
                  aspectRatio: ScreenAdaper.width(750) / ScreenAdaper.height(1334), //宽高比
                  autoPlay: true, //自动播放
                  looping: true, //循环播放
                  showControls: false
                ),
              ),
          ) : Container(),
        ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    // chewieController.dispose();
    super.dispose();
  }
}