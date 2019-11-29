import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../services/screenAdaper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../config/service_method.dart';



class LoginpasswordPage extends StatefulWidget {
  @override
  _LoginpasswordPageState createState() => _LoginpasswordPageState();
}

class _LoginpasswordPageState extends State<LoginpasswordPage> {

  String _phone = '';
  String _password = '';
  bool isPassword = true;
  // String _userPhone = TextEditingController();

  @override
  void initState() { 
    super.initState();
    
  }

  
  // 注册
  void logins(){
    RegExp reg = RegExp(r"\d{6}$");
    if(reg.hasMatch(_password)){
      // apiMethod('homeList', 'get', '').then((res){
      //   // var a = HomeModel.fromJson(res.data);
      //   setState(() {
      //     // homeList = a.data.bannerList;
      //   });
      //   print(res);
      // });
      Fluttertoast.showToast(
        msg: "验证码格式错误",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 3
      );
    }else{
      Fluttertoast.showToast(
        msg: "验证码格式错误",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 3
      );
    }
    print(_password);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: ScreenAdaper.width(30), height: ScreenAdaper.width(30),
                          child: Image.asset('images/login_image05.png'),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text('免密登录', style: TextStyle(fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.fromSTEB(0, ScreenAdaper.height(90), 0, ScreenAdaper.height(25)),
                    child: Text('欢迎登录', style: TextStyle(fontSize: ScreenAdaper.size(48), fontWeight: FontWeight.bold),),
                  ),
                  Text('登录即可学习更多跨境知识！', style: TextStyle(fontSize: ScreenAdaper.size(24), color: Color(0xff7F7F7F)),),
                  SizedBox(height: ScreenAdaper.height(70),),
                  Stack(
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: ScreenAdaper.size(30)),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(11)],
                        decoration: InputDecoration(
                          hintText: '请输入手机号码',
                          contentPadding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(105), ScreenAdaper.height(32), 0, ScreenAdaper.height(32)),
                        ),
                        onChanged: (value){
                          setState(() {
                            _phone = value;
                          });
                        },
                      ),
                      Positioned(
                        top: ScreenAdaper.height(36), left: 0,
                        child: Row(
                          children: <Widget>[
                            Text('+86', style: TextStyle(fontSize: ScreenAdaper.size(30)),),
                            Container(
                              width: ScreenAdaper.width(12), height: ScreenAdaper.height(6), margin: EdgeInsets.only(left: ScreenAdaper.width(10)),
                              child: Image.asset('images/login_image07.png', fit: BoxFit.fill,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenAdaper.height(40),),
                  Stack(
                    children: <Widget>[
                      TextField(
                        obscureText: isPassword,
                        style: TextStyle(fontSize: ScreenAdaper.size(30)),
                        decoration: InputDecoration(
                          hintText: '请输入密码',
                          contentPadding: EdgeInsetsDirectional.fromSTEB(0, ScreenAdaper.height(32), 0, ScreenAdaper.height(32)),
                        ),
                        onChanged: (value){
                          setState(() {
                            _password = value;
                          });
                        },
                      ),
                      Positioned(
                        top: ScreenAdaper.height(38), right: 0,
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          child: isPassword ? Container(
                            width: ScreenAdaper.width(33), height: ScreenAdaper.width(24),
                            child: Image.asset('images/login_image03.png'),
                          ) : Container(
                            width: ScreenAdaper.width(33), height: ScreenAdaper.width(24),
                            child: Image.asset('images/login_image02.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenAdaper.height(100),),
                  Opacity(
                    opacity: _phone!='' && _password!='' ? 1 : 0.6,
                    child: InkWell(
                      onTap: (){
                        
                      },
                      child: Container(
                        width: double.infinity, height: ScreenAdaper.height(96),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffFF8636), Color(0xffFDAB29)]
                          ),
                          borderRadius: BorderRadius.circular(ScreenAdaper.width(60))
                        ),
                        child: Center(
                          child: Text('登录', style: TextStyle(fontSize: ScreenAdaper.size(32), color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity, margin: EdgeInsets.only(top: ScreenAdaper.height(40)),
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/forgotpassword');
                      },
                      child: Text('忘记密码', 
                        style: TextStyle(
                          fontSize: ScreenAdaper.size(24), color: Color(0xff7F7F7F), 
                          decoration: TextDecoration.underline
                        ), 
                        textAlign: TextAlign.center,
                      )
                    ),
                  )
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
