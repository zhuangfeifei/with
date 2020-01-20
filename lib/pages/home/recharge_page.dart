import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:with_me/config/service_method.dart';
import '../../services/screenAdaper.dart';
import '../../services/storage.dart';
import '../widget/toast.dart';
import '../../services/userinfo.dart';

import 'package:fluwx/fluwx.dart' as fluwx;

class RechargePage extends StatefulWidget {
  @override
  _RechargePageState createState() => _RechargePageState();
}

class _RechargePageState extends State<RechargePage> {

  List _countList = [8, 68, 118, 288, 388, 588];

  int _tabIndex = -1;

  bool _isWx = true;

  var phones = '';

  @override
  void initState() {
    super.initState();
    getPhone();

    fluwx.responseFromPayment.listen((response){
      print(response);
      if(response.errCode == 0){
        toast('充值成功！');
        getUserinfoMethod();
      }else{
        toast('充值失败！');
      }
    });
  }

  void getPhone() async{
    var userinfo = await Storage.getString('userinfo');
    var phone = json.decode(userinfo)['Mobile'];
    setState(() {
      phones = phone;
    });
  }

  void recharge(){
    // 获取微信支付配置
    apiMethod('wxcreateorder', 'post', {'GoodsId': _countList[_tabIndex]*100, 'PayType': 7, 'GoodsType': 3}).then((res){
      // print(res.data);
      if(res.data['IsSuccess']){
        var result = res.data['Data']['PayExtend'].split(',');
        fluwx.pay( 
          appId: result[0], 
          partnerId: result[1],
          prepayId: result[2],
          packageValue: 'Sign=WXPay',
          nonceStr: result[3],
          timeStamp: int.parse(result[5]),
          sign: result[4],
          signType: 'MD5',
          extData: ''
        );
      }else{
        toast(res.data['Message']);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffFFFFFF),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity, height: ScreenAdaper.height(240),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/kuajinggonglve_image27.png'), fit: BoxFit.fill,
                )
              ),
            ),
            ListView(
              padding: EdgeInsets.only(top: ScreenAdaper.height(50), left: ScreenAdaper.width(30), right: ScreenAdaper.width(30)),
              children: <Widget>[
                Container(
                  width: double.infinity, height: ScreenAdaper.height(45), 
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomLeft, 
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: ScreenAdaper.width(50), height: ScreenAdaper.height(30), alignment: Alignment.bottomLeft,
                            child: Image.asset('images/home_image28.png', width: ScreenAdaper.width(16)),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text('充值牛币', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(34), fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ),
                SizedBox(height: ScreenAdaper.height(42),),
                Container(
                  width: double.infinity, height: ScreenAdaper.height(94), padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(35)),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF), borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 0), blurRadius: 3),
                    ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('充值账号', style: TextStyle(color: Color(0xff090909), fontSize: ScreenAdaper.size(30), fontWeight: FontWeight.bold),),
                      Text('$phones', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(30), fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                SizedBox(height: ScreenAdaper.height(30),),
                // 充值列表
                Container(
                  width: double.infinity, height: ScreenAdaper.height(500),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //每行三列
                      crossAxisSpacing: ScreenAdaper.width(20), mainAxisSpacing: ScreenAdaper.height(40),
                      childAspectRatio: 21/15, //显示区域宽高相等
                    ),
                    itemCount: _countList.length,
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          setState(() {
                            _tabIndex = index;
                          });
                        },
                        child: Container(
                          width: ScreenAdaper.width(210), height: ScreenAdaper.height(150),
                          decoration: BoxDecoration(
                            border: Border.all(width: ScreenAdaper.width(1), color: Color(_tabIndex==index?0xffFD7F3E:0xff909090)), borderRadius: BorderRadius.circular(5),
                            color: Color(_tabIndex==index?0xffFFEEE5:0xffFFFFFF)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('${_countList[index]}枚', style: TextStyle(color: Color(0xff090909), fontSize: ScreenAdaper.size(30), fontWeight: FontWeight.bold),),
                              SizedBox(height: ScreenAdaper.height(20),),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text:'￥', style: TextStyle(color: Color(0xffFD7F3E), fontSize: ScreenAdaper.size(28)),),
                                    TextSpan(text:'${_countList[index]}', style: TextStyle(color: Color(0xffFD7F3E), fontSize: ScreenAdaper.size(40)),),
                                  ]
                                )
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: ScreenAdaper.width(15),),
                      Text('支付方式：', style: TextStyle(color: Color(0xff090909), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),),
                      SizedBox(width: ScreenAdaper.width(25),),
                      // InkWell(
                      //   onTap: (){
                      //     setState(() {
                      //       _isWx = false;
                      //     });
                      //   },
                      //   child: Container(
                      //     width: ScreenAdaper.width(85),
                      //     child: Stack(
                      //       children: <Widget>[
                      //         Opacity(
                      //           opacity: _isWx?0.5:1,
                      //           child: Image.asset('images/home_image60.png', width: ScreenAdaper.width(75),)
                      //         ),
                      //         Positioned(
                      //           bottom: 0, right: 0,
                      //           child: Image.asset('images/home_image5${_isWx?4:5}.png', width: ScreenAdaper.width(25),)
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(width: ScreenAdaper.width(48),),
                      InkWell(
                        onTap: (){
                          setState(() {
                            _isWx = true;
                          });
                        },
                        child: Container(
                          width: ScreenAdaper.width(85),
                          child: Stack(
                            children: <Widget>[
                              Opacity(
                                opacity: _isWx?1:0.5,
                                child: Image.asset('images/home_image62.png', width: ScreenAdaper.width(75),)
                              ),
                              Positioned(
                                bottom: 0, right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFFFFF), borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: Image.asset('images/home_image5${_isWx?5:4}.png', width: ScreenAdaper.width(25), )
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ScreenAdaper.height(60),),
                Container(
                  padding: EdgeInsets.only(left: ScreenAdaper.width(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('充值须知：', style: TextStyle(color: Color(0xff090909), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),),
                      SizedBox(height: ScreenAdaper.height(30),),
                      Text('1、牛币可用于购买App内的所有课程；', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(24))),
                      Text('2、牛币为虚拟货币，充值后不会过期，但是无法退还、转增、提现；', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(24))),
                      Text('3、1 人民币 = 1 牛币；', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(24))),
                      Text('4、各个平台规则随时更新，请遵循最新的平台规则执行；', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(24))),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: '5、如有问题请致客服电话：', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(24))),
                            TextSpan(text: '18114433550', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(26))),
                          ]
                        )
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 0, left: 0,
              child: Container(
                width: ScreenAdaper.width(750), height: ScreenAdaper.height(108), 
                padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(40), vertical: ScreenAdaper.height(13)),
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  boxShadow: [
                    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(4, 0), blurRadius: 3),
                  ]
                ),
                child: InkWell(
                  onTap: (){
                    if(_isWx) recharge();
                  },
                  child: Container(
                    width: double.infinity, height: ScreenAdaper.height(82),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffFDB342), Color(0xffF36A37)]
                      ),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Center(
                      child: Text('确认充值', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(28)),),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}