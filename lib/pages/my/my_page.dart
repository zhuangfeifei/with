import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:with_me/services/screenAdaper.dart';
import '../../services/storage.dart';
import '../../services/convertNum.dart';
import '../../config/service_method.dart';
import '../../model/coupon_model.dart';
import '../widget/toast.dart';
import '../../services/userinfo.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {

  var userinfo;
  
  List pointexchangelist = [];

  @override
  void initState() {
    super.initState();
    getUserinfo();

    apiMethod('mycouponlist', 'post', {'Status': 1, 'PageSize': 100, 'PageIndex': 1}).then((res){
      print(res.data);
      var list = CouponModel.fromJson(res.data);
      if(res.data['IsSuccess']){
        setState(() {
          pointexchangelist = list.data;
        });
      }else{
        toast(res.data['Message']);
      }  
    });
  }

  void getUserinfo() async {
    await getUserinfoMethod();
    var data = await Storage.getString('userinfo');
    setState(() {
      userinfo = json.decode(data);
    });
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        color: Color(0xffFFFFFF),
        child: userinfo !=null ? ListView(
          padding: EdgeInsets.only(top: 0),
          children: <Widget>[
            Container(
              width: double.infinity, height: ScreenAdaper.height(684),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity, height: ScreenAdaper.height(414),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/home_image89.png'), fit: BoxFit.fill,
                      )
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: ScreenAdaper.height(55),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, '/consulting');
                              },
                              child: Column(
                                children: <Widget>[
                                  Image.asset('images/home_image79.png', width: ScreenAdaper.width(40),),
                                  Text('咨询', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(18)),)
                                ],
                              ),
                            ),
                            // SizedBox(width: ScreenAdaper.width(41),),
                            // Column(
                            //   children: <Widget>[
                            //     Image.asset('images/home_image78.png', width: ScreenAdaper.width(39),),
                            //     Text('消息', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(18)),)
                            //   ],
                            // ),
                            SizedBox(width: ScreenAdaper.width(39),),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(width: ScreenAdaper.width(54),),
                            ClipOval(
                              child: SizedBox(
                                width: ScreenAdaper.width(128),
                                child: Image.network('${userinfo['LogoUrl']}', fit: BoxFit.fill,),
                              ),
                            ),
                            SizedBox(width: ScreenAdaper.width(20),),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('${userinfo['UserName']}', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(32), fontWeight: FontWeight.bold),),
                                Text('2019-09-09日学习「跟我跨境」', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(24)),)
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ),
                  Positioned(
                    bottom: 0, left: ScreenAdaper.width(20),
                    child: Container(
                      width: ScreenAdaper.width(710), height: ScreenAdaper.height(350),
                      decoration: BoxDecoration(
                        color: Color(0xffFFFFFF), borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 0), blurRadius: 5),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: ScreenAdaper.width(310), height: ScreenAdaper.height(138),
                                padding: EdgeInsets.only(top: ScreenAdaper.height(26)),
                                decoration: BoxDecoration(
                                  color: Color(0xffF8F8F8), borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Image.asset('images/home_image81.png', width: ScreenAdaper.width(70),),
                                    SizedBox(width: ScreenAdaper.width(20),),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('赠送好友体验', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.bold, height: 1.3)),
                                        SizedBox(height: ScreenAdaper.height(10),),
                                        Text('+50牛币', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(24)),)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: ScreenAdaper.width(22),),
                              Container(
                                width: ScreenAdaper.width(310), height: ScreenAdaper.height(138),
                                padding: EdgeInsets.only(top: ScreenAdaper.height(26)),
                                decoration: BoxDecoration(
                                  color: Color(0xffF8F8F8), borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Image.asset('images/home_image82.png', width: ScreenAdaper.width(70),),
                                    SizedBox(width: ScreenAdaper.width(20),),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('邀请好友学习', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.bold, height: 1.3)),
                                        SizedBox(height: ScreenAdaper.height(10),),
                                        Text('+99牛币', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(24)),)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: ScreenAdaper.height(40),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, '/myCow', arguments:{'index': 0});
                                },
                                child: Column(
                                  children: <Widget>[
                                    Text('${convertNum(userinfo['Balance'])}', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(32), fontWeight: FontWeight.bold, height: 1.3)),
                                    SizedBox(height: ScreenAdaper.height(5),),
                                    Text('牛币', style: TextStyle(color: Color(0xff7F7F7F), fontSize: ScreenAdaper.size(22)),)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, '/myCow', arguments:{'index': 1});
                                },
                                child: Column(
                                  children: <Widget>[
                                    Text('${userinfo['Point']}', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(32), fontWeight: FontWeight.bold, height: 1.3)),
                                    SizedBox(height: ScreenAdaper.height(5),),
                                    Text('积分', style: TextStyle(color: Color(0xff7F7F7F), fontSize: ScreenAdaper.size(22)),)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, '/mycoupon');
                                },
                                child: Column(
                                  children: <Widget>[
                                    Text('${pointexchangelist.length}', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(32), fontWeight: FontWeight.bold, height: 1.3)),
                                    SizedBox(height: ScreenAdaper.height(5),),
                                    Text('优惠券', style: TextStyle(color: Color(0xff7F7F7F), fontSize: ScreenAdaper.size(22)),)
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ),
            SizedBox(height: ScreenAdaper.height(59),),
            Container(
              padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(54)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('我的学习', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(30), fontWeight: FontWeight.bold, height: 1.3)),
                  SizedBox(height: ScreenAdaper.height(40),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      getInk('images/home_image83.png', '优惠券', '/mycoupon'),
                      getInk('images/home_image84.png', '离线缓存', ''),
                      getInk('images/home_image85.png', '我的收藏', '/myCollection'),
                    ],
                  ),
                  SizedBox(height: ScreenAdaper.height(80),),
                  Text('其他', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(30), fontWeight: FontWeight.bold, height: 1.3)),
                  SizedBox(height: ScreenAdaper.height(40),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      getInk('images/home_image86.png', '我的勋章', ''),
                      getInk('images/home_image87.png', '帮助与反馈', ''),
                      getInk('images/home_image88.png', '设置', ''),
                    ],
                  ),
                ],
              ),
            )
          ],
        ) : Container()
      ),
    );
  }

  Widget getInk(img, text, url){
    return InkWell(
      onTap: (){
        if(url!='') Navigator.pushNamed(context, url);
      },
      child: Column(
        children: <Widget>[
          Image.asset(img, width: ScreenAdaper.width(50),),
          Text(text, style: TextStyle(color: Color(0xff7F7F7F), fontSize: ScreenAdaper.size(26)),)
        ],
      )
    );
  }
}