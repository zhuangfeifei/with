import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import '../widget/loading.dart';
import '../widget/dialog.dart';
import '../widget/toast.dart';
import '../../config/service_method.dart';
import '../../model/coupon_model.dart';
import '../widget/pointexchange_list.dart';
import '../../services/storage.dart';
import '../../services/userinfo.dart';

class ExchangeCouponPage extends StatefulWidget {
  @override
  _ExchangeCouponPageState createState() => _ExchangeCouponPageState();
}

class _ExchangeCouponPageState extends State<ExchangeCouponPage> {

  List pointexchangelist = [];

  var userinfo;

  @override
  void initState() {
    super.initState();
    getUserinfo();
    getCoupon();
    
  }

  void getUserinfo() async {
    var data = await Storage.getString('userinfo');
    setState(() {
      userinfo = json.decode(data);
    });
  }

  void getCoupon(){
    // ProgressDialog.showProgress(context);
    apiMethod('pointexchangelist', 'get', '').then((res){
      // ProgressDialog.dismiss(context);
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

  // 兑换
  Timer time;
  void exchange(id){
    ProgressDialog.showProgress(context);
    apiMethod('createorder', 'post', {'GoodsId': id, 'PayType': 5, 'GoodsType': 5}).then((res){
      ProgressDialog.dismiss(context);
      if(res.data['IsSuccess']){
        toast('兑换成功！');
        getUserinfo();
        // time = Timer(Duration(milliseconds:1000), (){
        //   Navigator.pop(context);
        // });
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
            ListView(
              padding: EdgeInsets.only(top: ScreenAdaper.height(270)),
              children: <Widget>[
                pointexchangelist.length > 0 ? Wrap(
                  children: pointexchangelist.map((item){
                    return InkWell(
                      onTap: (){
                        exchange(item.id);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(30)),
                        child: PointExchangeList(item: item, isCan: item.salePoint < userinfo['Point'] ? true : false,),
                      ),
                    );
                  }).toList(),
                ) : Container(
                  color: Color(0xffFFFFFF),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('images/Lack_image01.png', width: ScreenAdaper.width(280), height: ScreenAdaper.height(220),),
                        SizedBox(height: ScreenAdaper.height(35),),
                        Text('暂时没有相关信息', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.normal, fontFamily: 'Adobe Heiti Std'),)
                      ],
                    ),
                  )
                ),
                SizedBox(height: ScreenAdaper.height(30),),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('兑换须知：', style: TextStyle(color: Color(0xff090909), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),),
                      SizedBox(height: ScreenAdaper.height(30),),
                      Text('1、兑换后牛币可用于购买App内的所有课程；', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(24), height: 1.2),),
                      Text('2、牛币为虚拟币，兑换后不会过期，不可提现或转赠他人；', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(24), height: 1.2),),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: '3、如有问题请致客服电话：', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(24), height: 1.2),),
                            TextSpan(text: '18114433550', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(24), height: 1.2),),
                          ]
                        )
                      )
                    ],
                  ),
                ),
                SizedBox(height: ScreenAdaper.height(60),),
              ],
            ),
            Positioned(
              child: Container(
                width: double.infinity, height: ScreenAdaper.height(240),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/kuajinggonglve_image27.png'), fit: BoxFit.fill,
                  )
                ),
              ),
            ),
            Positioned(
              child: Container(
                width: double.infinity, height: ScreenAdaper.height(149), 
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
                            child: Image.asset('images/home_image28.png', width: ScreenAdaper.width(16),)
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text('兑换优惠券', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(34), fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              child: Container(
                width: ScreenAdaper.width(690), height: ScreenAdaper.height(94),
                margin: EdgeInsets.only(top: ScreenAdaper.height(148), left: ScreenAdaper.width(30)),
                padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(38)),
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF), borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 0), blurRadius: 5),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('当前账户积分', style: TextStyle(color: Color(0xff090909), fontSize: ScreenAdaper.size(30), fontWeight: FontWeight.bold),),
                    Text('${userinfo['Point']}', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(32), fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //       color: Color(0xffFFFFFF),
  //       child: Stack(
  //         children: <Widget>[
  //           Container(
  //             width: double.infinity, height: ScreenAdaper.height(240),
  //             decoration: BoxDecoration(
  //               image: DecorationImage(
  //                 image: AssetImage('images/kuajinggonglve_image27.png'), fit: BoxFit.fill,
  //               )
  //             ),
  //           ),
  //           Positioned(
  //             child: Stack(
  //               children: <Widget>[
  //                 userinfo!=null ? ListView(
  //                   children: <Widget>[
  //                     Container(
  //                       width: ScreenAdaper.width(690), height: ScreenAdaper.height(94),
  //                       margin: EdgeInsets.only(top: ScreenAdaper.height(148), left: ScreenAdaper.width(30)),
  //                       padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(38)),
  //                       decoration: BoxDecoration(
  //                         color: Color(0xffFFFFFF), borderRadius: BorderRadius.circular(5),
  //                         boxShadow: [
  //                           BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 0), blurRadius: 5),
  //                         ],
  //                       ),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: <Widget>[
  //                           Text('当前账户积分', style: TextStyle(color: Color(0xff090909), fontSize: ScreenAdaper.size(30), fontWeight: FontWeight.bold),),
  //                           Text('${userinfo['Point']}', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(32), fontWeight: FontWeight.bold),),
  //                         ],
  //                       ),
  //                     ),
  //                     SizedBox(height: ScreenAdaper.height(26),),
  //                     pointexchangelist.length > 0 ? Wrap(
  //                       children: pointexchangelist.map((item){
  //                         return Container(
  //                           padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(30)),
  //                           child: PointExchangeList(item: item, isCan: item.salePoint < userinfo['Point'] ? true : false,),
  //                         );
  //                       }).toList(),
  //                     ) : Container(
  //                       color: Color(0xffFFFFFF),
  //                       child: Center(
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: <Widget>[
  //                             Image.asset('images/Lack_image01.png', width: ScreenAdaper.width(280), height: ScreenAdaper.height(220),),
  //                             SizedBox(height: ScreenAdaper.height(35),),
  //                             Text('暂时没有相关信息', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.normal, fontFamily: 'Adobe Heiti Std'),)
  //                           ],
  //                         ),
  //                       )
  //                     ),
  //                     SizedBox(height: ScreenAdaper.height(60),),
  //                     Container(
  //                       padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(30)),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: <Widget>[
  //                           Text('当前账户积分', style: TextStyle(color: Color(0xff090909), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),),
  //                           SizedBox(height: ScreenAdaper.height(30),),
  //                           Text('1、兑换后牛币可用于购买App内的所有课程；', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(24), height: 1.2),),
  //                           Text('2、牛币为虚拟币，兑换后不会过期，不可提现或转赠他人；', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(24), height: 1.2),),
  //                           Text('3、如有问题请致客服电话：', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(24), height: 1.2),),
  //                         ],
  //                       ),
  //                     )
  //                   ],
  //                 ) : Container(),
  //                 Positioned(
  //                   child: Container(
  //                     width: double.infinity, height: ScreenAdaper.height(149), 
  //                     child: Stack(
  //                       children: <Widget>[
  //                         Align(
  //                           alignment: Alignment.centerLeft, 
  //                           child: InkWell(
  //                             onTap: (){
  //                               Navigator.pop(context);
  //                             },
  //                             child: Container(
  //                               padding: EdgeInsets.only(left: ScreenAdaper.width(30)),
  //                               child: Container(
  //                                 width: ScreenAdaper.width(50), height: ScreenAdaper.height(30), alignment: Alignment.bottomLeft,
  //                                 child: Image.asset('images/home_image28.png', width: ScreenAdaper.width(16),)
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Align(
  //                           alignment: Alignment.center,
  //                           child: Text('兑换优惠券', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(34), fontWeight: FontWeight.bold),),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}