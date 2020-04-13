import 'dart:convert';

import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import '../../config/service_method.dart';
import '../widget/toast.dart';
import '../widget/dialog.dart';
import '../widget/coupon_list.dart';
import '../../services/storage.dart';

class SetupPage extends StatefulWidget {
  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {

  var userinfo;

  @override
  void initState() {
    super.initState();
    getUserinfo();
  }

  void getUserinfo() async {
    var data = await Storage.getString('userinfo');
    setState(() {
      userinfo = json.decode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffF8F8F8),
        child: Stack(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.only(top: ScreenAdaper.height(148)),
              children: <Widget>[
                userinfo !=null ? InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/personal');
                  },
                  child: Container(
                    width: double.infinity, color: Color(0xffFFFFFF), height: ScreenAdaper.height(160),
                    padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(40), vertical: ScreenAdaper.height(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ClipOval(
                              child: SizedBox(
                                width: ScreenAdaper.width(100), height: ScreenAdaper.width(100),
                                child: Image.network("${userinfo['LogoUrl']}", fit: BoxFit.fill,),
                              ),
                            ),
                            SizedBox(width: ScreenAdaper.width(26),),
                            Text('个人资料', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(30), fontFamily: 'PingFang SC'),),
                          ],
                        ),
                        Image.asset('images/link.png', width: ScreenAdaper.width(12),)
                      ],
                    ),
                  ),
                ) : Container(),
                SizedBox(height: ScreenAdaper.height(20),),
                Container(
                  width: double.infinity, color: Color(0xffFFFFFF),
                  padding: EdgeInsets.only(left: ScreenAdaper.width(40)),
                  child: Container(
                    width: double.infinity, height: ScreenAdaper.height(110), padding: EdgeInsets.only(right: ScreenAdaper.width(40)),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: ScreenAdaper.height(1), color: Color(0xffEFEFEF))
                      ), 
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('账号设置', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC'),),
                        Image.asset('images/link.png', width: ScreenAdaper.width(12),)
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity, color: Color(0xffFFFFFF),
                  padding: EdgeInsets.only(left: ScreenAdaper.width(40)),
                  child: Container(
                    width: double.infinity, height: ScreenAdaper.height(110), padding: EdgeInsets.only(right: ScreenAdaper.width(40)),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: ScreenAdaper.height(1), color: Color(0xffEFEFEF))
                      ), 
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('清理缓存', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC'),),
                        Image.asset('images/link.png', width: ScreenAdaper.width(12),)
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity, color: Color(0xffFFFFFF),
                  padding: EdgeInsets.only(left: ScreenAdaper.width(40)),
                  child: Container(
                    width: double.infinity, height: ScreenAdaper.height(110), padding: EdgeInsets.only(right: ScreenAdaper.width(40)),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: ScreenAdaper.height(1), color: Color(0xffEFEFEF))
                      ), 
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('关于我们', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC'),),
                        Image.asset('images/link.png', width: ScreenAdaper.width(12),)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
                    width: double.infinity, padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(40)), margin: EdgeInsets.only(top: ScreenAdaper.height(88)),
                    child: Container(
                      width: double.infinity, height: ScreenAdaper.height(82),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffFFAE30), Color(0xffFF5F2E)]
                        ),
                        borderRadius: BorderRadius.circular(ScreenAdaper.width(60))
                      ),
                      child: Center(
                        child: Text('退出登录', style: TextStyle(fontSize: ScreenAdaper.size(34), color: Colors.white, fontWeight: FontWeight.normal)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              child: Container(
                color: Color(0xffFFFFFF), height: ScreenAdaper.height(128),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity, height: ScreenAdaper.height(127),
                      padding: EdgeInsets.only(top: ScreenAdaper.height(30)),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft, 
                            child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: ScreenAdaper.width(30)),
                                child: Container(
                                  width: ScreenAdaper.width(50), height: ScreenAdaper.height(30), alignment: Alignment.bottomLeft,
                                  child: Image.asset('images/home_image29.png', width: ScreenAdaper.width(16),)
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text('设置', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(34), fontWeight: FontWeight.bold, fontFamily: 'PingFang SC'),),
                          )
                        ],
                      ),
                    ),
                    Divider(height: ScreenAdaper.height(1), color: Color(0xffEFEFEF),),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}