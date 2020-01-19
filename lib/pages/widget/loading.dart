import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:with_me/services/screenAdaper.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: ScreenAdaper.width(200), height: ScreenAdaper.height(200),
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.5), borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 0), blurRadius: 5),
            ]
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SpinKitCircle(
                  color: Colors.white,
                  size: 40.0,
                ),
                SizedBox(height: ScreenAdaper.height(5),),
                Text('加载中...', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(26)),)
              ],
            ),
          ),
        ),
      )
    );
  }
}