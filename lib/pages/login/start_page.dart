import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import '../widget/toast.dart';
import '../../config/service_method.dart';
import '../../services/storage.dart';
import '../bottom_tab/bottom.dart';

import 'package:fluwx/fluwx.dart' as fluwx;

import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  String state = '';

  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  @override
  void initState() {
    super.initState();

    getUser();

    // 初始化
    initWx();

    // 监听授权结果
    fluwx.responseFromAuth.listen((data) {
      // 这里返回结果，errCode=0为微信用户授权成功的标志，其他看微信官方开发文档
      var resultStr = "initState ======   ${data.errCode}  --- ${data.code}";
      print(resultStr);
      // 微信登录后台返回用户信息
      apiMethod('wxlogin', 'post', {'Code': data.code, 'State': state}).then((res){
        if(res.data['IsSuccess']){
          Storage.setString('userinfo',  json.encode(res.data['Data']));
          if(res.data['Mobile']==''){
            Navigator.pushNamed(context, '/login');
          }else{
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BottomPage()), (route) => route == null);
          }
        }else{
          toast(res.data['Message']);
        }
      });
    });

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
  void getUser() async{
    var userinfo = await Storage.getString('userinfo');
    var phone = userinfo!=null ? json.decode(userinfo)['Mobile'] : '';
    // 如果登录过直接跳首页
    if(phone!='') Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BottomPage()), (route) => route == null);
  }

  // 初始化
  Future initWx() async{
    await fluwx.register(appId:"wx25b441928f07f1a9",doOnAndroid:true,doOnIOS:true);
    var isWeChatInstalled = await fluwx.isWeChatInstalled();
    print(isWeChatInstalled.toString());
    // toast('初始化:${isWeChatInstalled.toString()}');
  }

  void getState(){
    apiMethod('getstate', 'post', '').then((res){
      if(res.data['IsSuccess']){
        setState(() {
          state = res.data['Data'];
        });
        // 发起微信授权
        fluwx.sendAuth( scope: "snsapi_userinfo", state: res.data['Data']).then((data) {
          // 触发监听授权结果
        }).catchError((e) {
          toast('点击登录异常：$e');
        });
      }else{
        toast(res.data['Message']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // ScreenAdaper.init(context);

    return Scaffold(
        body: Container(
          width: double.infinity,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('images/StartBackground.png'), 
          //     // image: NetworkImage('https://zcxy.oss-cn-beijing.aliyuncs.com/App/StartBackground.png'), 
          //     fit: BoxFit.fill,
          //   )
          // ),
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity, height: ScreenAdaper.getScreenHeight(), color: Colors.black,
                  child: Chewie(
                    controller: ChewieController(
                      videoPlayerController: videoPlayerController,
                      aspectRatio: ScreenAdaper.width(750) / ScreenAdaper.height(1334), //宽高比
                      autoPlay: true, //自动播放
                      looping: true, //循环播放
                      showControls: false
                    ),
                  ),
              ),
              Positioned(
                bottom: ScreenAdaper.height(103),
                child: Container(
                  width: ScreenAdaper.width(750),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/registered');
                        },
                        child: Container(
                          width: ScreenAdaper.width(570), height: ScreenAdaper.height(98), color: Colors.white,
                          child: Center(
                            child: Text('注册领取礼包', style: TextStyle(
                              color: Color(0xff000000), fontSize: ScreenAdaper.size(32), fontWeight: FontWeight.bold
                            ),),
                          )
                        ),
                      ),
                      Container(
                        width: ScreenAdaper.width(570), margin: EdgeInsets.only(top: ScreenAdaper.height(29)),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: Container(
                                  width: ScreenAdaper.width(275), height: ScreenAdaper.height(98),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: ScreenAdaper.width(2))
                                  ),
                                  child: Center(child: Text('手机登录', style: TextStyle(
                                    fontSize: ScreenAdaper.size(32), color: Colors.white, fontWeight: FontWeight.bold
                                  ),),),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: (){
                                  getState();
                                },
                                child: Container(
                                  width: ScreenAdaper.width(275), height: ScreenAdaper.height(98),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: ScreenAdaper.width(2))
                                  ),
                                  child: Center(child: Text('微信授权登录', style: TextStyle(
                                    fontSize: ScreenAdaper.size(32), color: Colors.white, fontWeight: FontWeight.bold
                                  ),),),
                                ),
                              ),
                            ),
                          ],
                        )
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
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