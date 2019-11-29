import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../services/screenAdaper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../config/service_method.dart';



class SetnewpasswordPage extends StatefulWidget {
  @override
  _SetnewpasswordPageState createState() => _SetnewpasswordPageState();
}

class _SetnewpasswordPageState extends State<SetnewpasswordPage> {

  String _password = '';
  String _passwords = '';

  @override
  void initState() { 
    super.initState();
    
  }

  void routers(){
    Navigator.pushNamed(context, '/registered');
  }

  setpasswords(){
    if(_password == _passwords){

    }else{
      Fluttertoast.showToast(
        msg: "手机号格式错误",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 3
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    ScreenAdaper.init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Color(0xffFFFFFF),
        child: Stack(
          children: <Widget>[
            // 底部图片
            Positioned(
              bottom: 0.0, left: 0.0,
              child: Container(
                width: ScreenAdaper.width(750), height: ScreenAdaper.height(440),
                child: Image.asset('images/login_image01.png', fit: BoxFit.fill,),
              ),
            ),
            Container(
              padding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(60), 0, ScreenAdaper.width(60), 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: ScreenAdaper.height(98)),
                  InkWell(
                    onTap: routers,
                    child: Container(
                      width: ScreenAdaper.width(41), height: ScreenAdaper.width(35),
                      child: Image.asset('images/login_image05.png'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.fromSTEB(0, ScreenAdaper.height(90), 0, ScreenAdaper.height(25)),
                    child: Text('设置新密码', style: TextStyle(fontSize: ScreenAdaper.size(48), fontWeight: FontWeight.bold),),
                  ),
                  Text('新密码设置成功后请妥善保存哦！', style: TextStyle(fontSize: ScreenAdaper.size(24), color: Color(0xff7F7F7F)),),
                  SizedBox(height: ScreenAdaper.height(70),),
                  TextField(
                    obscureText: true,
                    maxLength: 16, 
                    decoration: InputDecoration(
                      hintText: '请设置6〜16位密码',
                      contentPadding: EdgeInsetsDirectional.fromSTEB(0, ScreenAdaper.height(32), 0, ScreenAdaper.height(32)),
                    ),
                    onChanged: (value){
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                  TextField(
                    obscureText: true,
                    maxLength: 16,
                    decoration: InputDecoration(
                      hintText: '请再次输入密码',
                      contentPadding: EdgeInsetsDirectional.fromSTEB(0, ScreenAdaper.height(32), 0, ScreenAdaper.height(32)),
                    ),
                    onChanged: (value){
                      setState(() {
                        _passwords = value;
                      });
                    },
                  ),
                  SizedBox(height: ScreenAdaper.height(70),),
                  Opacity(
                    opacity: _password!='' && _passwords!='' ? 1 : 0.6,
                    child: InkWell(
                      onTap: setpasswords,
                      child: Container(
                        width: double.infinity, height: ScreenAdaper.height(96),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffFF8636), Color(0xffFDAB29)]
                          ),
                          borderRadius: BorderRadius.circular(ScreenAdaper.width(60))
                        ),
                        child: Center(
                          child: Text('完成', style: TextStyle(fontSize: ScreenAdaper.size(32), color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
