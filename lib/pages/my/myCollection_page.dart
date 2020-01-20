import 'package:flutter/material.dart';
import 'package:left_scroll_actions/left_scroll_list.dart';
import '../../services/screenAdaper.dart';
import '../../config/service_method.dart';
import '../../model/classificationList_model.dart';
import '../widget/toast.dart';
import '../widget/loading.dart';
import '../widget/myCourse_list.dart';
import 'package:left_scroll_actions/left_scroll_actions.dart';

class MyCollectionPage extends StatefulWidget {
  @override
  _MyCollectionPageState createState() => _MyCollectionPageState();
}

class _MyCollectionPageState extends State<MyCollectionPage> {

  List myorderList;

  @override
  void initState() {
    super.initState();
    getList();
  }

  void getList(){
    apiMethod('getmyfavoriate', 'post', {"PageSize":100,"PageIndex":1}).then((res){
      if(res.data['IsSuccess']){
        for (var i = 0; i < res.data['Data'].length; i++) {
          res.data['Data'][i]['checked'] = false;
        }
        var list = ClassificationListModel.fromJson(res.data);
        setState(() {
          myorderList = list.data;
        });
      }else{
        toast(res.data['Message']);
      }
    });
  }

  // 管理
  bool _isManagement = false;
  // 是否全选反选
  bool _isChecked = false;
  // 监听全反选
  bool _isAll(){
    for (var i = 0; i < myorderList.length; i++) {
      if(myorderList[i].checked == false) return false;
    }
    return true;
  }
  // 全选反选
  void _allChecked(){
    _isChecked = !_isChecked;
    for (var i = 0; i < myorderList.length; i++) {
      setState(() {
        myorderList[i].checked = _isChecked;
      });
    }
  }
  // 取消收藏
  void collectpl(array){
    apiMethod('collectpl', 'post', {'TargetType': 3, 'TargetIds': array, 'Oper':0}).then((res){
      print(res.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffFFFFFF),
        child: Stack(
          children: <Widget>[
            myorderList==null ? Loading() : myorderList.length > 0 ? LeftScrollList.builder(
              padding: EdgeInsets.only(top: ScreenAdaper.height(148), bottom: ScreenAdaper.height(_isManagement ? 108 : 0)), 
              count: myorderList.length, 
              builder: (context, index) => LeftScrollListItem(
                key: myorderList[index].id.toString(),
                child: Container(
                  width: double.infinity, height: ScreenAdaper.height(300),
                  child: Stack(
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          setState(() {
                            myorderList[index].checked = !myorderList[index].checked;
                          });
                        },
                        child: Container(
                          width: ScreenAdaper.width(100),
                          child: Center(
                            child: Image.asset('images/home_image5${myorderList[index].checked?'5':'4'}.png', width: ScreenAdaper.width(42),),
                          ),
                        ),
                      ),
                      Positioned(
                        left: ScreenAdaper.width(_isManagement ? 100 : 0), top: ScreenAdaper.height(_isManagement ? 3 : 0),
                        child: MyCourseList(item: myorderList[index]),
                      )
                    ],
                  ),
                ),
                buttons: [
                  InkWell(
                    onTap: (){
                      List array = [];
                      array.add(myorderList[index].id);
                      collectpl(array);
                      setState(() {
                        myorderList.removeAt(index);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: ScreenAdaper.width(25)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: ScreenAdaper.width(54), height: ScreenAdaper.width(54),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 0), blurRadius: 5),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 20, backgroundColor: Color(0xffFFFFFF),
                              child: Center(
                                child: Image.asset('images/home_image39.png', width: ScreenAdaper.width(32)),
                              ),
                            ),
                          ),
                          SizedBox(height: ScreenAdaper.height(5),),
                          Text('取消收藏', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(20)),),
                        ],
                      ),
                    ),
                  )
                ],
                onTap: (){
                  print('tap row');
                }
              ),
            ) : Container(
              color: Color(0xffFFFFFF),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('images/Lack_image01.png', width: ScreenAdaper.width(280), height: ScreenAdaper.height(220),),
                    SizedBox(height: ScreenAdaper.height(35),),
                    Text('暂时没有相关信息', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.normal, fontFamily: 'Adobe Heiti Std'),)
                  ],
                ),
              )
            ),
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
                            child: Text('我的收藏', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(34), fontWeight: FontWeight.bold, fontFamily: 'PingFang SC'),),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  if(myorderList.length > 0) _isManagement = !_isManagement;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(right: ScreenAdaper.width(30)),
                                child: Text('管理', style: TextStyle(color: Color(0xff7F7F7F), fontSize: ScreenAdaper.size(32), fontFamily: 'PingFang SC'),),
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                    Divider(height: ScreenAdaper.height(1), color: Color(0xffEFEFEF),),
                  ],
                ),
              ),
            ),
            _isManagement ? Positioned(
              bottom: 0, left: 0,
              child: Container(
                width: ScreenAdaper.width(750), height: ScreenAdaper.height(108),
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  boxShadow: [
                    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 0), blurRadius: 5)
                  ]
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: ScreenAdaper.width(30),),
                    InkWell(
                      onTap: _allChecked,
                      child: Image.asset('images/home_image5${_isAll()?'5':'4'}.png', width: ScreenAdaper.width(42)),
                    ),
                    SizedBox(width: ScreenAdaper.width(18),),
                    Text('全选', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(30), fontFamily: 'PingFang SC'),),
                    SizedBox(width: ScreenAdaper.width(60),),
                    InkWell(
                      onTap: (){
                        showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("温馨提示"),
                              content: Text("您确定取消收藏吗?"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("取消"),
                                  onPressed: () => Navigator.of(context).pop(), //关闭对话框
                                ),
                                FlatButton(
                                  child: Text("确定"),
                                  onPressed: () {
                                    List array = [];
                                    for (var i = 0; i < myorderList.length; i++) {
                                      array.add(myorderList[i].id);
                                    }
                                    collectpl(array);
                                    Navigator.of(context).pop(true); //关闭对话框
                                  },
                                ),
                              ],
                            );
                          }
                        );
                      },
                      child: Container(
                        width: ScreenAdaper.width(502), height: ScreenAdaper.height(82),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffFDB342), Color(0xffF36A37)]
                          ),
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Center(
                          child: Text('取消收藏（3）', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(34)),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }
}