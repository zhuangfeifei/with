import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../services/screenAdaper.dart';
import '../../config/service_method.dart';
import '../widget/toast.dart';
import '../../services/storage.dart';
import '../bottom_tab/bottom.dart';
import '../../pages/widget/dialog.dart';



class LoginpasswordPage extends StatefulWidget {
  @override
  _LoginpasswordPageState createState() => _LoginpasswordPageState();
}

class _LoginpasswordPageState extends State<LoginpasswordPage> {

  String _phone = '';
  String _password = '';
  bool isPassword = true;

  FocusNode _commentFocus = FocusNode();
  FocusNode _commentFocus1 = FocusNode();

  @override
  void initState() { 
    super.initState();
    
  }

  
  // 密码登录
  Timer time;
  void logins(){
    _commentFocus.unfocus();    // 失去焦点
    _commentFocus1.unfocus();    // 失去焦点
    RegExp reg = RegExp(r"^1\d{10}$");
    if(reg.hasMatch(_phone)){
      ProgressDialog.showProgress(context);
      apiMethod('login', 'post', {'Account': _phone, 'Pwd': _password}).then((res){
        ProgressDialog.dismiss(context);
        if(res.data['IsSuccess']){
          // toast('登录成功！');
          Storage.setString('userinfo',  json.encode(res.data['Data']));
          // time = Timer(Duration(milliseconds:1000), (){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BottomPage()), (route) => route == null);
          // });
        }else{
          toast(res.data['Message']);
        }
      });
    }else{
      toast('手机号格式错误！');
    }
    print(_phone);
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
                          Navigator.pushNamed(context, '/');
                        },
                        child: Container(
                          width: ScreenAdaper.width(30), height: ScreenAdaper.width(30),
                          child: Image.asset('images/login_image04.png'),
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
                  Text('登录即可享受专业的跨境服务！', style: TextStyle(fontSize: ScreenAdaper.size(24), color: Color(0xff7F7F7F)),),
                  SizedBox(height: ScreenAdaper.height(70),),
                  Stack(
                    children: <Widget>[
                      TextField(
                        focusNode: _commentFocus,
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
                        focusNode: _commentFocus1,
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
                      onTap: logins,
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
                        Navigator.pushReplacementNamed(context, '/forgotpassword');
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
