import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../services/screenAdaper.dart';
import '../../config/service_method.dart';
import '../widget/toast.dart';
import '../../services/storage.dart';
import '../../pages/widget/dialog.dart';



class RegisteredPage extends StatefulWidget {
  @override
  _RegisteredPageState createState() => _RegisteredPageState();
}

class _RegisteredPageState extends State<RegisteredPage> {

  String _phone = '';
  String _code = '';
  int seconds = 60;
  bool isCode = true;
  // String _userPhone = TextEditingController();

  FocusNode _commentFocus = FocusNode();

  @override
  void initState() { 
    super.initState();
    
  }

  _showTimer(){
    setState(() {
      isCode = false;
    });
    Timer t;
    t = Timer.periodic(Duration(milliseconds:1000), (timer){
      setState(() {
        seconds--;
      });
      if(seconds==0){
        t.cancel();
        setState(() {
          isCode = true;
          seconds = 60;
        });
      }
    });
  }


  // 获取验证码
  void sendCode(){
    RegExp reg = RegExp(r"^1\d{10}$");
    if(reg.hasMatch(_phone)){
      ProgressDialog.showProgress(context);
      apiMethod('captcha', 'post', {'Mobile': _phone, 'Type': 2}).then((res){
        ProgressDialog.dismiss(context);
        if(res.data['IsSuccess']){
          _showTimer();
          toast('发送成功！');
        }else{
          toast(res.data['Message']);
        }
      });
    }else{
      toast('手机号格式错误！');
    }
    print(_phone);
  }
  
  // 注册
  // Timer time;
  void registereds(){
    _commentFocus.unfocus();    // 失去焦点
    RegExp reg = RegExp(r"\d{6}$");
    if(reg.hasMatch(_code)){
      ProgressDialog.showProgress(context);
      apiMethod('quicklogin', 'post', {'Mobile': _phone, 'Captcha': _code}).then((res){
        ProgressDialog.dismiss(context);
        if(res.data['IsSuccess']){
          // toast('注册成功！');
          Storage.setString('userinfo',  json.encode(res.data['Data']));
          // time = Timer(Duration(milliseconds:2000), (){
            Navigator.pushNamed(context, '/setpassword');
          // });
        }else{
          toast(res.data['Message']);
        }
        print(res);
      });
    }else{
      toast('验证码格式错误！');
    }
    print(_code);
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
                width: ScreenAdaper.width(750), height: ScreenAdaper.height(470),
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
                        child: Text('去登录', style: TextStyle(fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.fromSTEB(0, ScreenAdaper.height(90), 0, ScreenAdaper.height(25)),
                    child: Text('欢迎注册', style: TextStyle(fontSize: ScreenAdaper.size(48), fontWeight: FontWeight.bold),),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: ScreenAdaper.width(7)),
                        width: ScreenAdaper.width(28), height: ScreenAdaper.height(30),
                        child: Image.asset('images/login_image06.png'),
                      ),
                      Text('注册成功可获得10牛币用于购买课程', style: TextStyle(fontSize: ScreenAdaper.size(24), color: Color(0xff7F7F7F)),),
                    ],
                  ),
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
                          // errorText: _userPhone.length < 11 ? '请输入正确的手机号' : false,
                          // suffixIcon: Icon(Icons.remove_red_eye,),
                          // suffixText: "******",
                          contentPadding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(105), ScreenAdaper.height(32), 0, ScreenAdaper.height(32)),
                        ),
                        onChanged: (value){
                          setState(() {
                            _phone = value;
                          });
                        },
                      ),
                      Positioned(
                        top: ScreenAdaper.height(40), left: 0,
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
                        focusNode: _commentFocus,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: ScreenAdaper.size(30)),
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(6)],
                        decoration: InputDecoration(
                          hintText: '请输入验证码',
                          contentPadding: EdgeInsetsDirectional.fromSTEB(0, ScreenAdaper.height(32), 0, ScreenAdaper.height(32)),
                        ),
                        onChanged: (value){
                          setState(() {
                            _code = value;
                          });
                        },
                      ),
                      Positioned(
                        top: ScreenAdaper.height(34), right: 0,
                        child: isCode ? InkWell(
                          child: Container(
                            child: Text('获取验证码', style: TextStyle(fontSize: ScreenAdaper.size(30), color: Color(0xffFF8636)),),
                          ),
                          // child: Text(isCode?'获取验证码':'${seconds}', style: TextStyle(fontSize: ScreenAdaper.size(30), color: Color(0xffFF8636)),),
                          onTap: sendCode,
                        ) : Container(
                          child: Text('${seconds}秒后可重新获取', style: TextStyle(fontSize: ScreenAdaper.size(30), color: Color(0xffFF8636)),),
                        )
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenAdaper.height(100),),
                  Opacity(
                    opacity: _phone!='' && _code!='' ? 1 : 0.6,
                    child: InkWell(
                      onTap: registereds,
                      child: Container(
                        width: double.infinity, height: ScreenAdaper.height(96),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffFF8636), Color(0xffFDAB29)]
                          ),
                          borderRadius: BorderRadius.circular(ScreenAdaper.width(60))
                        ),
                        child: Center(
                          child: Text('下一步', style: TextStyle(fontSize: ScreenAdaper.size(32), color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenAdaper.height(40),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('注册即视为同意', style: TextStyle(fontSize: ScreenAdaper.size(24), color: Color(0xff7F7F7F)),), 
                      Text('《跟我跨境隐私政策》', style: TextStyle(fontSize: ScreenAdaper.size(24), color: Color(0xffFF8636)),)
                    ],
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
