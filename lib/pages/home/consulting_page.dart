import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:with_me/services/screenAdaper.dart';
import '../../services/storage.dart';
import '../../config/service_method.dart';
import '../widget/toast.dart';

class ConsultingPage extends StatefulWidget {
  @override
  _ConsultingPageState createState() => _ConsultingPageState();
}

class _ConsultingPageState extends State<ConsultingPage> {
  TextEditingController _textController = new TextEditingController();
  FocusNode _commentFocus = FocusNode();
  var _inputValue = '';
  var logoUrl;
  var groupid;
  List _message = [];

  @override
  void initState() {
    super.initState();
    getLogo();
    getgroupid();
  }

  void getLogo() async {
    var userinfo = await Storage.getString('userinfo');
    var message = await Storage.getString('myMessageList');
    setState(() {
      logoUrl = json.decode(userinfo)['LogoUrl'];
      _message = json.decode(message);
    });
  }

  Timer t;
  void getgroupid(){
    apiMethod('getgroupid', 'post', '').then((res){
      print(res.data);
      if(res.data['IsSuccess']){
        setState(() {
          groupid = res.data['Data'];
        });
        t = Timer.periodic(Duration(milliseconds:10000), (timer){
          getM(res.data['Data']);
        });
      }else{
        toast(res.data['Message']);
      }
    });
  }

  void sendM(){
    apiMethod('sendgroup', 'post', {'Content': _inputValue, 'CtRoomGroupId': groupid}).then((res){
      print(res.data);
      if(res.data['IsSuccess']){
        setState(() {
          _message.add({'Content': _inputValue, "IsSelf": true});
        });
        _textController.clear();
        _commentFocus.unfocus();    // 失去焦点
        
      }else{
        toast(res.data['Message']);
      }
    });
  }

  void getM(groupids){
    apiMethod('getgroup', 'post', {'CtRoomGroupId': groupids}).then((res){
      print(res.data);
      if(res.data['IsSuccess']){
        setState(() {
          if(res.data['Data'].length > 0) _message.addAll(res.data['Data']);
        });
      }else{
        toast(res.data['Message']);
      }
    });
  }


  Widget getWidget(item){
    return Container(
      width: double.infinity, padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(28)),
      margin: EdgeInsets.only(bottom: ScreenAdaper.height(23)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: ScreenAdaper.width(5),
            child: Image.asset('images/home_image68.png', fit: BoxFit.fill,)
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(40), vertical: ScreenAdaper.height(23)),
            decoration: BoxDecoration(
              color: Color(0xffEFEFEF),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)
              )
            ),
            constraints: BoxConstraints(
              maxWidth: ScreenAdaper.width(680)
            ),
            child: Text('${item['Content']}', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), height: 1.15),)
          ),
        ],
      ),
    );
  }

  Widget sedWidget(item){
    return Container(
      width: double.infinity, padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(28)),
      margin: EdgeInsets.only(bottom: ScreenAdaper.height(23)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(40), vertical: ScreenAdaper.height(23)),
                decoration: BoxDecoration(
                  color: Color(0xffFF8636),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)
                  )
                ),
                constraints: BoxConstraints(
                  maxWidth: ScreenAdaper.width(560)
                ),
                child: Text('${item['Content']}', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(28), height: 1.15),)
              ),
              Container(
                width: ScreenAdaper.width(5),
                child: Image.asset('images/home_image69.png', fit: BoxFit.fill,)
              ),
            ],
          ),
          SizedBox(width: ScreenAdaper.width(10),),
          logoUrl != null ? ClipOval(
            child: SizedBox(
              width: ScreenAdaper.width(80),
              child: Image.network("$logoUrl", fit: BoxFit.fill,),
            ),
          ) : Container(),
        ],
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    Storage.setString('myMessageList',  json.encode(_message));
    t.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            ListView.builder(
              padding: EdgeInsets.only(top: ScreenAdaper.height(290), bottom: ScreenAdaper.height(98)),
              itemCount: _message.length,
              itemBuilder: (context, index){
                return _message[index]['IsSelf'] ? sedWidget(_message[index]) : getWidget(_message[index]);
              },
            ),
            // header
            Positioned(
              top: 0, left: 0,
              child: Container(
                width: ScreenAdaper.width(750), height: ScreenAdaper.height(260), 
                padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(30)),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/home_image66.png'), fit: BoxFit.fill
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: ScreenAdaper.height(69),),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: ScreenAdaper.width(50), height: ScreenAdaper.height(30), alignment: Alignment.bottomLeft,
                        child: Image.asset('images/home_image28.png', width: ScreenAdaper.width(16),)
                      ),
                    ),
                    SizedBox(height: ScreenAdaper.height(8),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('images/home_image67.png', width: ScreenAdaper.width(110),),
                      ],
                    )
                  ],
                ),
              ),
            ),
            _input()
          ],
        ),
      ),
    );
  }


  // 输入框
  Widget _input(){
    return Positioned(
      bottom: 0, left: 0,
      child: Container(
        width: ScreenAdaper.width(750), height: ScreenAdaper.height(98), padding: EdgeInsets.only(left: ScreenAdaper.width(30), right: ScreenAdaper.width(38)),
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          border: Border(top: BorderSide(width: 1, color: Color(0xffEFEFEF)))
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity, height: ScreenAdaper.height(70),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Color(0xffF8F8F8)
                ),
                child: TextField(
                  controller: _textController,
                  focusNode: _commentFocus,
                  onTap: (){
                    setState(() {
                      
                    });
                  },
                  onChanged: (value){
                    setState(() {
                      _inputValue = value;
                    });
                  },
                  decoration: InputDecoration(
                    // hintText: '写下你的评论，与作者互动',
                    contentPadding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(41), 0, 0, ScreenAdaper.height(23)),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: ScreenAdaper.width(24),),
            InkWell(
              onTap: (){
                sendM();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.5)
                ),
                child: Image.asset('images/home_image48.png', width: ScreenAdaper.width(56), height: ScreenAdaper.width(56),),
              ),
            )
          ],
        ),
      ),
    );
  }
}