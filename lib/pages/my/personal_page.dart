import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../services/screenAdaper.dart';
import '../../config/service_method.dart';
import '../widget/toast.dart';
import '../widget/dialog.dart';
import '../widget/coupon_list.dart';
import '../../services/storage.dart';
import '../../services/industry.dart';

import 'package:city_pickers/city_pickers.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {

  var userinfo;
  String _nickname = '';
  String _city = '';
  // 公司名称
  String _companyname = '';
  // 个性签名
  String _signature = '';
  // true女false男
  bool _isSex = true;
  // 行业选择显示
  bool isIndustry = false;
  int _levelIndex = -1;
  int _secondaryIndex = -1;
  String _industryContent = '';
  bool isLevel = false;
  bool isSecondary = false;
  // 职业选择显示
  bool isPosition = false;
  int _positionIndex = -1;
  String _positionContent = '';

  @override
  void initState() {
    super.initState();
    getUserinfo();
  }

  void getUserinfo() async {
    var data = await Storage.getString('userinfo');
    setState(() {
      userinfo = json.decode(data);
    });
  }

  
  

  // 省市选择
  void _changeCity(context) async {
    Result result = await CityPickers.showCityPicker(
      context: context, 
      showType: ShowType.pc,
      cancelWidget: Text('取消', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(30), fontFamily: 'PingFang SC'),),
      confirmWidget: Text('确定', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(30), fontFamily: 'PingFang SC'),),
    );
    print(result.provinceName+result.cityName);
    setState(() {
      _city = result.provinceName+result.cityName;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffF8F8F8),
        child: Stack(
          children: <Widget>[
            userinfo !=null ? ListView(
              padding: EdgeInsets.only(top: ScreenAdaper.height(148)),
              children: <Widget>[
                Container(
                  width: double.infinity, color: Color(0xffFFFFFF), height: ScreenAdaper.height(160),
                  padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(40), vertical: ScreenAdaper.height(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ClipOval(
                            child: SizedBox(
                              width: ScreenAdaper.width(100), height: ScreenAdaper.width(100),
                              child: Image.network("${userinfo['LogoUrl']}", fit: BoxFit.fill,),
                            ),
                          ),
                          SizedBox(width: ScreenAdaper.width(26),),
                          Text('个人资料', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(30), fontFamily: 'PingFang SC'),),
                        ],
                      ),
                      Image.asset('images/link.png', width: ScreenAdaper.width(12),)
                    ],
                  ),
                ),
                SizedBox(height: ScreenAdaper.height(20),),
                Container(
                  width: double.infinity, color: Color(0xffFFFFFF),
                  padding: EdgeInsets.only(left: ScreenAdaper.width(40)),
                  child: Container(
                    width: double.infinity, height: ScreenAdaper.height(110), padding: EdgeInsets.only(right: ScreenAdaper.width(40)),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: ScreenAdaper.height(1), color: Color(0xffEFEFEF))
                      ), 
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('昵称', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC'),),
                        Container(
                          width: ScreenAdaper.width(200),
                          child: TextField(
                            style: TextStyle(fontSize: ScreenAdaper.size(28)),
                            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(6)],
                            decoration: InputDecoration(
                              hintText: '请填写你的昵称',
                              contentPadding: EdgeInsetsDirectional.fromSTEB(0, ScreenAdaper.height(32), 0, ScreenAdaper.height(32)),
                              border: InputBorder.none,
                            ),
                            onChanged: (value){
                              setState(() {
                                _nickname = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity, color: Color(0xffFFFFFF),
                  padding: EdgeInsets.only(left: ScreenAdaper.width(40)),
                  child: Container(
                    width: double.infinity, height: ScreenAdaper.height(110), padding: EdgeInsets.only(right: ScreenAdaper.width(40)),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: ScreenAdaper.height(1), color: Color(0xffEFEFEF))
                      ), 
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('手机号', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC'),),
                        Text('${userinfo['Mobile']}', style: TextStyle(color: Color(0xff7F7F7F), fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC'),),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity, color: Color(0xffFFFFFF),
                  padding: EdgeInsets.only(left: ScreenAdaper.width(40)),
                  child: Container(
                    width: double.infinity, height: ScreenAdaper.height(110), padding: EdgeInsets.only(right: ScreenAdaper.width(40)),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: ScreenAdaper.height(1), color: Color(0xffEFEFEF))
                      ), 
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('性别', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC'),),
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                setState(() {
                                  _isSex = true;
                                });
                              },
                              child: Image.asset('images/home_image67.png', width: ScreenAdaper.width(68),),
                            ),
                            SizedBox(width: ScreenAdaper.width(26),),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  _isSex = false;
                                });
                              },
                              child: Image.asset('images/home_image80.png', width: ScreenAdaper.width(68),),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      isIndustry = true;
                    });
                  },
                  child: Container(
                    width: double.infinity, color: Color(0xffFFFFFF),
                    padding: EdgeInsets.only(left: ScreenAdaper.width(40)),
                    child: Container(
                      width: double.infinity, height: ScreenAdaper.height(110), padding: EdgeInsets.only(right: ScreenAdaper.width(40)),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: ScreenAdaper.height(1), color: Color(0xffEFEFEF))
                        ), 
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('行业', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC'),),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('$_industryContent', style: TextStyle(color: Color(0xff7F7F7F), fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC'),),
                              SizedBox(width: ScreenAdaper.width(24),),
                              Image.asset('images/link.png', width: ScreenAdaper.width(12), height: ScreenAdaper.height(23),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      isPosition = true;
                    });
                  },
                  child: Container(
                    width: double.infinity, color: Color(0xffFFFFFF),
                    padding: EdgeInsets.only(left: ScreenAdaper.width(40)),
                    child: Container(
                      width: double.infinity, height: ScreenAdaper.height(110), padding: EdgeInsets.only(right: ScreenAdaper.width(40)),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: ScreenAdaper.height(1), color: Color(0xffEFEFEF))
                        ), 
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('职位', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC'),),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('$_positionContent', style: TextStyle(color: Color(0xff7F7F7F), fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC'),),
                              SizedBox(width: ScreenAdaper.width(24),),
                              Image.asset('images/link.png', width: ScreenAdaper.width(12), height: ScreenAdaper.height(23),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity, color: Color(0xffFFFFFF),
                  padding: EdgeInsets.only(left: ScreenAdaper.width(40)),
                  child: Container(
                    width: double.infinity, height: ScreenAdaper.height(110), padding: EdgeInsets.only(right: ScreenAdaper.width(40)),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: ScreenAdaper.height(1), color: Color(0xffEFEFEF))
                      ), 
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('公司名称', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC'),),
                        Container(
                          width: ScreenAdaper.width(200),
                          child: TextField(
                            style: TextStyle(fontSize: ScreenAdaper.size(28)),
                            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(6)],
                            decoration: InputDecoration(
                              hintText: '请填写公司名称',
                              contentPadding: EdgeInsetsDirectional.fromSTEB(0, ScreenAdaper.height(32), 0, ScreenAdaper.height(32)),
                              border: InputBorder.none,
                            ),
                            onChanged: (value){
                              setState(() {
                                _companyname = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    _changeCity(context);
                  },
                  child: Container(
                    width: double.infinity, color: Color(0xffFFFFFF),
                    padding: EdgeInsets.only(left: ScreenAdaper.width(40)),
                    child: Container(
                      width: double.infinity, height: ScreenAdaper.height(110), padding: EdgeInsets.only(right: ScreenAdaper.width(40)),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: ScreenAdaper.height(1), color: Color(0xffEFEFEF))
                        ), 
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('省市', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC'),),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('$_city', style: TextStyle(color: Color(0xff7F7F7F), fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC'),),
                              SizedBox(width: ScreenAdaper.width(24),),
                              Image.asset('images/link.png', width: ScreenAdaper.width(12), height: ScreenAdaper.height(23),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity, color: Color(0xffFFFFFF),
                  padding: EdgeInsets.only(left: ScreenAdaper.width(40)),
                  child: Container(
                    width: double.infinity, height: ScreenAdaper.height(110), padding: EdgeInsets.only(right: ScreenAdaper.width(40)),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: ScreenAdaper.height(1), color: Color(0xffEFEFEF))
                      ), 
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('个性签名', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC'),),
                        Container(
                          width: ScreenAdaper.width(200),
                          child: TextField(
                            style: TextStyle(fontSize: ScreenAdaper.size(28)),
                            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(6)],
                            decoration: InputDecoration(
                              hintText: '请填写个性签名',
                              contentPadding: EdgeInsetsDirectional.fromSTEB(0, ScreenAdaper.height(32), 0, ScreenAdaper.height(32)),
                              border: InputBorder.none,
                            ),
                            onChanged: (value){
                              setState(() {
                                _signature = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ) : Container(),
            isIndustry ? Positioned(
              bottom: 0, left: 0,
              child: _industry(),
            ) : Positioned(child: Container()),
            isPosition ? Positioned(
              bottom: 0, left: 0,
              child: _position(),
            ) : Positioned(child: Container()),
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
                            child: Text('个人资料', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(34), fontWeight: FontWeight.bold, fontFamily: 'PingFang SC'),),
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


  // 行业一级选择
  void _changeLevel(index){
    setState(() {
      _levelIndex = index;
      isLevel = true;
      isSecondary = false;
    });
  }
  // 行业二级选择
  void _changeSecondary(index){
    setState(() {
      _secondaryIndex = index;
      isSecondary = true;
    });
  }
  // 关闭行业选择
  void _clear(){
    setState(() {
      isIndustry = false;
      _levelIndex = -1;
      _secondaryIndex = -1;
      isLevel = false;
      isSecondary = false;
    });
  }
  // 行业弹窗
  Widget _industry() {
    return Container(								//弹出框的具体事件
      width: ScreenAdaper.width(750), height: ScreenAdaper.getScreenHeight(),
      child: Material(
        color: Color.fromRGBO(0, 0, 0, 0.58),
        child: Stack(
          children: <Widget>[
            !isLevel ? Positioned(
              bottom: ScreenAdaper.height(108), left: 0,
              child: Container(
                width: ScreenAdaper.width(750), height: ScreenAdaper.height(660), color: Color(0xffFFFFFF),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: ScreenAdaper.height(10), bottom: ScreenAdaper.height(35)),
                  itemCount: industry.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){
                        _changeLevel(index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(40)), margin: EdgeInsets.only(top: ScreenAdaper.height(25)),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: '${industry[index]['title']} ', style: TextStyle(color: Color(_levelIndex == index ? 0xffFF8636 : 0xff000000), fontSize: ScreenAdaper.size(30), 
                                fontFamily: 'PingFang SC', fontWeight: FontWeight.w400),
                              ),
                              _levelIndex == index ? TextSpan(text: '√', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(30), 
                                fontFamily: 'PingFang SC', fontWeight: FontWeight.w400),
                              ) : TextSpan(),
                            ]
                          )
                        )
                      ),
                    );
                  },
                )
              ),
            ) : Positioned(
              bottom: ScreenAdaper.height(108), left: 0,
              child: Container(
                width: ScreenAdaper.width(750), height: ScreenAdaper.height(660), color: Color(0xffFFFFFF),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: ScreenAdaper.height(10), bottom: ScreenAdaper.height(35)),
                  itemCount: industry[_levelIndex]['segmentation'].length,
                  itemBuilder: (context, index){
                    var item = industry[_levelIndex]['segmentation'][index];
                    return InkWell(
                      onTap: (){
                        _changeSecondary(index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(30)), margin: EdgeInsets.only(top: ScreenAdaper.height(25)),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: '$item ', style: TextStyle(color: Color(_secondaryIndex == index ? 0xffFF8636 : 0xff000000), fontSize: ScreenAdaper.size(30), 
                                fontFamily: 'PingFang SC', fontWeight: FontWeight.w400),
                              ),
                              _secondaryIndex == index ? TextSpan(text: '√', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(30), 
                                fontFamily: 'PingFang SC', fontWeight: FontWeight.w400),
                              ) : TextSpan(),
                            ]
                          )
                        )
                      ),
                    );
                  },
                )
              ),
            ),
            Positioned(
              bottom: ScreenAdaper.height(767), left: 0,
              child: Container(
                width: ScreenAdaper.width(750), height: ScreenAdaper.height(200), 
                padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(40)),
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10), topRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: ScreenAdaper.height(44),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('请选择您的行业', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(30), fontFamily: 'PingFang SC', fontWeight: FontWeight.bold),),
                        InkWell(
                          onTap: _clear,
                          child: Image.asset('images/home_image100.png', width: ScreenAdaper.width(38),)
                        )
                      ],
                    ),
                    SizedBox(height: ScreenAdaper.height(40),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: ScreenAdaper.width(252),
                              ),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    _secondaryIndex = -1;
                                    isLevel = false;
                                  });
                                },
                                child: Text(_levelIndex == -1 ? '请选择一级行业' : '${industry[_levelIndex]['title']}', style: TextStyle(color: Color(_levelIndex == -1 ? 0xff808080 : 0xff000000), 
                                  fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC', fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(height: ScreenAdaper.height(10),),
                            !isLevel ? Container(
                              width: ScreenAdaper.width(50), height: ScreenAdaper.height(6), 
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xffFFAE30), Color(0xffFF5F2E)]
                                ),
                              ),
                            ) : Container(width: ScreenAdaper.width(50), height: ScreenAdaper.height(6),)
                          ],
                        ),
                        SizedBox(width: ScreenAdaper.width(84)),
                        isLevel ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: ScreenAdaper.width(252),
                              ),
                              child: Text(!isSecondary ? '请选择细分行业' : '${industry[_levelIndex]['segmentation'][_secondaryIndex]}', style: TextStyle(color: Color(!isSecondary ? 0xff808080 : 0xff000000), 
                                fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC', fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: ScreenAdaper.height(10),),
                            Container(
                              width: ScreenAdaper.width(50), height: ScreenAdaper.height(6), 
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xffFFAE30), Color(0xffFF5F2E)]
                                ),
                              ),
                            )
                          ],
                        ) : Container(),
                        
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0, left: 0,
              child: Container(
                width: ScreenAdaper.width(750), height: ScreenAdaper.height(108),
                padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(40), vertical: ScreenAdaper.height(13)),
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  boxShadow: [
                    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 0), blurRadius: 5),
                  ]
                ),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      _industryContent = industry[_levelIndex]['segmentation'][_secondaryIndex];
                    });
                    _clear();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffFFAE30), Color(0xffFF5F2E)]
                      ),
                      borderRadius: BorderRadius.circular(ScreenAdaper.width(60))
                    ),
                    child: Center(
                      child: Text('确认', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(34), fontFamily: 'Adobe Heiti Std', fontWeight: FontWeight.normal),),
                    ),
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }



  // 切换职位
  void _changePosition(index){
    setState(() {
      _positionIndex = index;
    });
  }
  // 关闭职位选择
  void _clearPosition(){
    setState(() {
      isPosition = false;
    });
  }
  // 职位 弹窗
  Widget _position() {
    return Container(								//弹出框的具体事件
      width: ScreenAdaper.width(750), height: ScreenAdaper.getScreenHeight(),
      child: Material(
        color: Color.fromRGBO(0, 0, 0, 0.58),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: ScreenAdaper.height(108), left: 0,
              child: Container(
                width: ScreenAdaper.width(750), height: ScreenAdaper.height(660), color: Color(0xffFFFFFF),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: ScreenAdaper.height(10), bottom: ScreenAdaper.height(35)),
                  itemCount: position.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){
                        _changePosition(index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(40)), margin: EdgeInsets.only(top: ScreenAdaper.height(25)),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: '${position[index]} ', style: TextStyle(color: Color(_positionIndex == index ? 0xffFF8636 : 0xff000000), fontSize: ScreenAdaper.size(30), 
                                fontFamily: 'PingFang SC', fontWeight: FontWeight.w400),
                              ),
                              _positionIndex == index ? TextSpan(text: '√', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(30), 
                                fontFamily: 'PingFang SC', fontWeight: FontWeight.w400),
                              ) : TextSpan(),
                            ]
                          )
                        )
                      ),
                    );
                  },
                )
              ),
            ),
            Positioned(
              bottom: ScreenAdaper.height(767), left: 0,
              child: Container(
                width: ScreenAdaper.width(750), height: ScreenAdaper.height(200), 
                padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(40)),
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10), topRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: ScreenAdaper.height(44),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('请选择您的职位', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(30), fontFamily: 'PingFang SC', fontWeight: FontWeight.bold),),
                        InkWell(
                          onTap: _clearPosition,
                          child: Image.asset('images/home_image100.png', width: ScreenAdaper.width(38),)
                        )
                      ],
                    ),
                    SizedBox(height: ScreenAdaper.height(40),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(_positionIndex == -1 ? '请选择职位' : '${position[_positionIndex]}', style: TextStyle(color: Color(_positionIndex == -1 ? 0xff808080 : 0xff000000), 
                                fontSize: ScreenAdaper.size(28), fontFamily: 'PingFang SC', fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: ScreenAdaper.height(10),),
                            Container(
                              width: ScreenAdaper.width(50), height: ScreenAdaper.height(6), 
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xffFFAE30), Color(0xffFF5F2E)]
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0, left: 0,
              child: Container(
                width: ScreenAdaper.width(750), height: ScreenAdaper.height(108),
                padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(40), vertical: ScreenAdaper.height(13)),
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  boxShadow: [
                    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 0), blurRadius: 5),
                  ]
                ),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      _positionContent = position[_positionIndex];
                    });
                    _clearPosition();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffFFAE30), Color(0xffFF5F2E)]
                      ),
                      borderRadius: BorderRadius.circular(ScreenAdaper.width(60))
                    ),
                    child: Center(
                      child: Text('确认', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(34), fontFamily: 'Adobe Heiti Std', fontWeight: FontWeight.normal),),
                    ),
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }

}