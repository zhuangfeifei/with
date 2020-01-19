import 'package:flutter/material.dart';
import 'package:with_me/pages/widget/course_list.dart';
import '../../services/screenAdaper.dart';
import '../../services/convertNum.dart';

class PointExchangeList extends StatelessWidget {
  var item;
  bool isCan;
  PointExchangeList({this.item, this.isCan});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isCan ? 1 : 0.5,
      child: Container(
        width: double.infinity, height: ScreenAdaper.height(172), 
        padding: EdgeInsets.only(right: ScreenAdaper.width(18)), margin: EdgeInsets.only(bottom: ScreenAdaper.height(23)),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/home_image58.png'), fit: BoxFit.fill
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenAdaper.width(182),
                    child: Text('${convertNum(item.price)}', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(84), fontWeight: FontWeight.w400), textAlign: TextAlign.right),
                  ),
                  SizedBox(width: ScreenAdaper.width(36),),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${item.couponTitle}', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),),
                        SizedBox(height: ScreenAdaper.height(3),),
                        Text('*实际支付大于${convertNum(item.limitPrice)}牛币可用', style: TextStyle(color: Color(0xff7E7E7E), fontSize: ScreenAdaper.size(14), fontWeight: FontWeight.bold),),
                        // Text('*有效期日期${item.startTime}～${item.endTime}', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(14), fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: '${item.salePoint}', style: TextStyle(color: Color(0xffCA560A), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),),
                      TextSpan(text: '积分', style: TextStyle(color: Color(0xffCA560A), fontSize: ScreenAdaper.size(14), fontWeight: FontWeight.bold),),
                    ]
                  )
                ),
                Text('兑换', style: TextStyle(color: Color(0xffCA560A), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
