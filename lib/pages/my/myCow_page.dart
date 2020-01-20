import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:with_me/config/service_method.dart';
import 'package:with_me/pages/widget/loading.dart';
import '../../services/screenAdaper.dart';
import '../../services/storage.dart';
import '../../services/convertNum.dart';
import '../widget/toast.dart';
import '../widget/loading.dart';
import '../widget/dialog.dart';
import '../../model/myConsumption_model.dart';
import '../../model/myPointinfo_model.dart';
import '../../services/convertNum.dart';

class MyCowPage extends StatefulWidget {
  var arguments;
  MyCowPage({Key key, this.arguments}) : super(key:key);

  @override
  _MyCowPageState createState() => _MyCowPageState();
}

class _MyCowPageState extends State<MyCowPage> {

  List _tab = ['我的牛币', '我的积分'];
  int _tabIndex = 0;

  var userinfo;

  MyConsumptionModel myConsumption;
  MyPointinfoModel myPointinfo;

  int pageIndex = 1;
  //解决重复请求的问题
  bool flag = true;
  //是否有数据
  bool _hasMore = true;
  //用于上拉分页 listview 的控制器
  ScrollController _scrollController = ScrollController();

  int pageIndex1 = 1;
  //解决重复请求的问题
  bool flag1 = true;
  //是否有数据
  bool _hasMore1 = true;
  //用于上拉分页 listview 的控制器
  ScrollController _scrollController1 = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabIndex = widget.arguments['index'];
    getUserinfo();
    widget.arguments['index'] == 0 ? getmyConsumption() : getmyPointinfo();

    //监听滚动条滚动事件
    _scrollController.addListener(() {
      //_scrollController.position.pixels //获取滚动条滚动的高度
      //_scrollController.position.maxScrollExtent  //获取页面高度
      if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 20) {
        if (this.flag && this._hasMore) {
          getmyConsumption();
        }
      }
    });
    //监听滚动条滚动事件
    _scrollController1.addListener(() {
      //_scrollController.position.pixels //获取滚动条滚动的高度
      //_scrollController.position.maxScrollExtent  //获取页面高度
      if (_scrollController1.position.pixels > _scrollController1.position.maxScrollExtent - 20) {
        if (this.flag1 && this._hasMore1) {
          getmyPointinfo();
        }
      }
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    var bools = ModalRoute.of(context).isCurrent;
    if (bools) {
      getUserinfo();
    }
  }

  void getUserinfo() async {
    var data = await Storage.getString('userinfo');
    setState(() {
      userinfo = json.decode(data);
    });
  }
  // 牛币记录
  void getmyConsumption(){
    setState(() {
      this.flag = false;
    });
    apiMethod('myConsumption', 'post', {"PageSize":10,"PageIndex":pageIndex,"GoodsTypeList":[1,2,3,4,6,7],"Filter":0,"IsNeedExtendInfo":0}).then((res){
      if(res.data['IsSuccess']){
        var list = MyConsumptionModel.fromJson(res.data);
        setState(() {
          if(list.data.length < 10) this._hasMore = false;
          pageIndex == 1? myConsumption = list : myConsumption.data.addAll(list.data);
          this.pageIndex++;
          this.flag = true;
        });
      }else{
        toast(res.data['Message']);
      }  
    });
  }
  // 积分记录
  void getmyPointinfo(){
    setState(() {
      this.flag1 = false;
    });
    apiMethod('myPointinfo', 'post', {"PageSize":10,"PageIndex":pageIndex1}).then((res){
      if(res.data['IsSuccess']){
        var list = MyPointinfoModel.fromJson(res.data);
        setState(() {
          if(list.data.length < 10) this._hasMore1 = false;
          pageIndex1 == 1? myPointinfo = list : myPointinfo.data.addAll(list.data);
          this.pageIndex1++;
          this.flag1 = true;
        });
      }else{
        toast(res.data['Message']);
      }  
    });
  }

  // 说明
  Future getInstructions(context){
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
          return GestureDetector(							// 手势处理事件
            onTap: (){
              // Navigator.of(context).pop();				//退出弹出框
            },
            child: Container(								//弹出框的具体事件
              child: Material(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                child: Center(
                  child: Container( 
                    width: ScreenAdaper.width(508), height: ScreenAdaper.height(800),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              width: double.infinity, height: ScreenAdaper.height(610),
                              padding: EdgeInsets.only(top: ScreenAdaper.height(140),),
                              child: Container(
                                width: ScreenAdaper.width(508), height: ScreenAdaper.height(450), 
                                padding: EdgeInsets.only(top: ScreenAdaper.height(130), left: ScreenAdaper.width(56), right: ScreenAdaper.width(56), bottom: ScreenAdaper.height(_tabIndex == 0 ? 40 : 60),),
                                decoration: BoxDecoration(
                                  color: Color(0xffFFFFFF), borderRadius: BorderRadius.circular(10)
                                ),
                                child: _tabIndex == 0 ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('1、牛币可用于购买App内所有课程；', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(24), fontWeight: FontWeight.bold, height: 1.5),),
                                    Text('2、牛币为虚拟货币，充值后不会过期，但是无法退还、转增、提现，敬请理解；', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(24), fontWeight: FontWeight.bold, height: 1.5),),
                                    Text('3、1RMB=1牛币。', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(24), fontWeight: FontWeight.bold, height: 1.5),),
                                    Text('4、各个平台规则随时更新，请遵循最新的平台规则执行。', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(24), fontWeight: FontWeight.bold, height: 1.5),),
                                  ],
                                ) : ListView(
                                  children: <Widget>[
                                    Text('1、签到、观看/分享课程、观看/分享直播、发表评论、邀请好友、购买课程/直播均可获得积分；', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(24), fontWeight: FontWeight.bold, height: 1.5),),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(text: '2、积分数达到一定额度，即可升级；每升一级，送对应等级', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(24), fontWeight: FontWeight.bold, height: 1.5),),
                                          TextSpan(text: '*10', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(24), fontWeight: FontWeight.bold, height: 1.5),),
                                        ]
                                      )
                                    ),
                                    SizedBox(height: ScreenAdaper.height(20)),
                                    Container(
                                      width: double.infinity, height: ScreenAdaper.height(430),
                                      padding: EdgeInsets.only(left: ScreenAdaper.width(30)),
                                      child: Image.asset('images/home_image98.png', fit: BoxFit.fill,),
                                    ),
                                    SizedBox(height: ScreenAdaper.height(20)),
                                    Text('3、积分可用来兑换优惠券，抵扣课程购买金额；', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(24), fontWeight: FontWeight.bold, height: 1.5),),
                                  ],
                                )
                              ),
                            ),
                            Positioned(
                              top: 0, left: ScreenAdaper.width(45),
                              child: Container(
                                width: ScreenAdaper.width(417), height: ScreenAdaper.height(227), padding: EdgeInsets.only(bottom: ScreenAdaper.height(25)),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('images/home_image97.png'), fit: BoxFit.fill 
                                  )
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text('${_tabIndex == 0 ? '牛币说明':'积分说明'}', style: TextStyle(
                                        color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(34), fontWeight: FontWeight.bold, height: 1),
                                      ),
                                    )
                                  ],
                                )
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: ScreenAdaper.height(27),),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pop();				//退出弹出框
                          },
                          child: Image.asset('images/close_image30.png', width: ScreenAdaper.width(54), height: ScreenAdaper.width(54),),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          );
          
      },
    );      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffFFFFFF),
        child: ListView(
          padding: EdgeInsets.only(top: 0),
          children: <Widget>[
            Container(
              width: double.infinity, height: ScreenAdaper.height(410), 
              padding: EdgeInsets.only(top: ScreenAdaper.height(69)),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/home_image93.png'), fit: BoxFit.fill
                )
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: ScreenAdaper.width(30)),
                            child: Container(
                              width: ScreenAdaper.width(50), height: ScreenAdaper.height(30), alignment: Alignment.bottomLeft,
                              child: Image.asset('images/home_image28.png', width: ScreenAdaper.width(16),)
                            ),
                          ),
                        ),
                        SizedBox(height: ScreenAdaper.height(10),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: this._tab.map((item){
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  _tabIndex = this._tab.indexOf(item);
                                });
                                if(_tabIndex == 0 && myConsumption==null) getmyConsumption();
                                if(_tabIndex == 1 && myPointinfo==null) getmyPointinfo();
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: ScreenAdaper.width(this._tab.indexOf(item) == 1 ? 103 : 0)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text('$item', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(36), fontWeight: FontWeight.bold),),
                                    SizedBox(height: ScreenAdaper.height(20)),
                                    Opacity(
                                      opacity: _tabIndex == this._tab.indexOf(item) ? 1 : 0,
                                      child: Container(
                                        width: ScreenAdaper.width(70), height: ScreenAdaper.height(6), color: Color(0xffFFFFFF),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList()
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: ScreenAdaper.width(670), height: ScreenAdaper.height(188),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/home_image95.png'), fit: BoxFit.fill
                        )
                      ),
                      child: userinfo!=null?Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: ScreenAdaper.width(52)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('${_tabIndex == 0 ? convertNum(userinfo['Balance']) : userinfo['Point']}', style: TextStyle(color: Color(0xff5A3F2D), fontSize: ScreenAdaper.size(84),),),
                                InkWell(
                                  onTap: (){
                                    getInstructions(context);
                                  },
                                  child: Image.asset('images/home_image94.png', width: ScreenAdaper.width(30),),
                                )
                              ],
                            )
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, _tabIndex == 0 ? '/recharge' : '/exchangeCoupon');
                            },
                            child: _tabIndex==0? Container(
                              width: ScreenAdaper.width(164), height: ScreenAdaper.height(58),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xffFDB342), Color(0xffF36A37)]
                                ),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))
                              ),
                              child: Center(
                                child: Text('充值牛币', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(28), height: 1),),
                              ),
                            ): Container(
                              width: ScreenAdaper.width(184), height: ScreenAdaper.height(58),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xffFDB342), Color(0xffF36A37)]
                                ),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))
                              ),
                              child: Center(
                                child: Text('兑换优惠券', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(28), height: 1),),
                              ),
                            ),
                          )
                        ],
                      ):Container(),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: ScreenAdaper.height(18),),
            records()
          ],
        ),
      ),
    );
  }

  Widget records(){
    return Container(
      width: ScreenAdaper.width(750), height: ScreenAdaper.height(900),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/home_image96.png'), fit: BoxFit.fill
        )
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: ScreenAdaper.height(58),),
          _tabIndex == 0 ? Expanded(
            child: myConsumption == null ? Loading() : myConsumption.data.length >0 ? ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(70)),
              itemCount: myConsumption.data.length,
              itemBuilder: (context, index){
                var item = myConsumption.data[index];
                return Container(
                  width: double.infinity, padding: EdgeInsets.symmetric(vertical: ScreenAdaper.height(25)),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: ScreenAdaper.height(1), color: Color(0xffEFEFEF))
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text('${item.title}', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), height: 1.2),),
                          ),
                          SizedBox(width: ScreenAdaper.width(5),),
                          Text('${convertNum(item.cB)}', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(30), height: 1.2),),
                        ],
                      ),
                      SizedBox(height: ScreenAdaper.height(13),),
                      Text('${item.dateTime2.substring(0, 9)}', style: TextStyle(color: Color(0xffC2C2C2), fontSize: ScreenAdaper.size(26), height: 1),),
                    ],
                  ),
                );
              },
            ) : Center(
              child: Text('暂无记录'),
            ),
          ) :
          Expanded(
            child: myPointinfo == null ? Loading() : myPointinfo.data.length >0 ? ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(70)),
              itemCount: myPointinfo.data.length,
              itemBuilder: (context, index){
                var item = myPointinfo.data[index];
                return Container(
                  width: double.infinity, padding: EdgeInsets.symmetric(vertical: ScreenAdaper.height(25)),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: ScreenAdaper.height(1), color: Color(0xffEFEFEF))
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text('${item.operDes}', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), height: 1.2),),
                          ),
                          SizedBox(width: ScreenAdaper.width(5),),
                          Text('${item.operPoint}', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(30), height: 1.2),),
                        ],
                      ),
                      SizedBox(height: ScreenAdaper.height(13),),
                      Text('${item.createTime}', style: TextStyle(color: Color(0xffC2C2C2), fontSize: ScreenAdaper.size(26), height: 1),),
                    ],
                  ),
                );
              },
            ) : Center(
              child: Text('暂无记录'),
            ),
          ),
          SizedBox(height: ScreenAdaper.height(58),),
        ],
      ),
    );
  }
}