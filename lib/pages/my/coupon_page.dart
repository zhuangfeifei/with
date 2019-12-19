import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';

class CouponPage extends StatefulWidget {
  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {

  bool _isUse = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffFFFFFF),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity, height: ScreenAdaper.height(250),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/home_image59.png'), fit: BoxFit.fill,
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
                          child: Image.asset('images/home_image28.png', width: ScreenAdaper.width(16), height: ScreenAdaper.height(30)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text('选择优惠券', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(34), fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ),
                SizedBox(height: ScreenAdaper.height(38),),
                Container(
                  width: double.infinity, height: ScreenAdaper.height(88), padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(25)),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF), borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('不使用优惠券', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),),
                      InkWell(
                        onTap: (){
                          setState(() {
                            _isUse = !_isUse;
                          });
                        },
                        child: Image.asset('images/home_image5${_isUse?5:4}.png', width: ScreenAdaper.width(42),),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}