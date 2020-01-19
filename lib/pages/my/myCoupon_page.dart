import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import '../../config/service_method.dart';
import '../../model/coupon_model.dart';
import '../widget/toast.dart';
import '../widget/dialog.dart';
import '../widget/coupon_list.dart';

class MyCouponPage extends StatefulWidget {
  @override
  _MyCouponPageState createState() => _MyCouponPageState();
}

class _MyCouponPageState extends State<MyCouponPage> {

  List myCouponList = [];

  @override
  void initState() {
    super.initState();
    getCoupon();
  }

  void getCoupon(){
    // ProgressDialog.showProgress(context);
    apiMethod('mycouponlist', 'post', {'Status': 1, 'PageSize': 100, 'PageIndex': 1}).then((res){
      // ProgressDialog.dismiss(context);
      print(res.data);
      var list = CouponModel.fromJson(res.data);
      if(res.data['IsSuccess']){
        setState(() {
          myCouponList = list.data;
        });
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
            myCouponList.length > 0 ? ListView.builder(
              padding: EdgeInsets.only(top: ScreenAdaper.height(148)),
              itemCount: myCouponList.length,
              itemBuilder: (context, index){
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(30)),
                  child: CouponList(item: myCouponList[index]),
                );
              },
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
                            child: Text('我的优惠券', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(34), fontWeight: FontWeight.bold, fontFamily: 'PingFang SC'),),
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