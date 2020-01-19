import 'dart:convert';
import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import '../../config/service_method.dart';
import '../../model/hotList_model.dart';
import '../../model/classificationList_model.dart';
import '../../pages/widget/loading.dart';
// import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../services/storage.dart';
import '../widget/classification_list.dart';
import '../widget/search_list.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List _list = [];
   _getHotList() {
    // 大家都在搜
    apiMethod('hotList', 'get', '').then((res){
      setState(() {
        _list = HotListModel.fromJson(res.data).data;
        // print(_list[0].title);
        Storage.setString('a', json.encode(_list));
      });
      // _list = list.data;
      // return list.map((item) => _searchList(text: item, indexs: _list.indexOf(item))).toList();
    });
  }

  // 是否是检索列表
  bool _isRetrieve = false;
  // 是否存在
  bool _isThereare = true;
  // 输入框的值
  String _inputValue = '';
  // 课程名搜索列表
  List _searchbytitleandteacherList = [];
  // 猜你喜欢
  List _recommendList = [];

  @override
  void initState() {
    super.initState();
    _getHotList();
    _recommend();
    
  }

  // 搜索课程
  void _searchbytitle() async{
    // Storage.getString('a').then((v) => print(v));
    var b = await Storage.getString('a');
    // print(json.decode(b)[0].title);
  }

  // 搜索老师
  void _searchbytitleandteacher(){
    apiMethod('searchbytitleandteacher', 'post', {'SearchKey': _inputValue, 'PageIndex': 1, 'PageSize': 30}).then((res){
      setState(() {
        _searchbytitleandteacherList = ClassificationListModel.fromJson(res.data).data;
        // print(_searchbytitleList[0].title);
      });
    });
  }

  // 猜你喜欢
  void _recommend(){
    apiMethod('recommend', 'get', '').then((res){
      setState(() {
        _recommendList = ClassificationListModel.fromJson(res.data).data;
        // print(_searchbytitleList[0].title);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('as'),),
      body: Stack(
        children: <Widget>[
          Container(
            color: Color(0xffFFFFFF), margin: EdgeInsets.only(top: ScreenAdaper.width(_isRetrieve?80:160)),
            child: ListView(
              children: <Widget>[
                // 是否是检索列表
                _isRetrieve ? 
                // 结果页
                Container(
                  margin: EdgeInsets.only(top: ScreenAdaper.height(26)),
                  child: _isThereare ? _retrieve() : _noResult()// 没有结果，不存在
                )
                // 大家都在搜列表
                : _searchList(),
              ],
            ),
          ),
          // 搜索框
          Positioned(
            top: 0, left: 0,
            child: Container(
              width: ScreenAdaper.width(750), color: Color(0xffFFFFFF),
              padding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(30), ScreenAdaper.height(55), ScreenAdaper.width(30), ScreenAdaper.height(10)),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: ScreenAdaper.height(58),
                          decoration: BoxDecoration(
                            color: Color(0xfff8f8f8), 
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Stack(
                            children: <Widget>[
                              TextField(
                                onTap: (){
                                  setState(() {
                                    _isRetrieve = true;
                                  });
                                },
                                onChanged: (value){
                                  setState(() {
                                    _inputValue = value;
                                  });
                                  _searchbytitleandteacher();
                                },
                                decoration: InputDecoration(
                                  hintText: '请输入课程名',
                                  contentPadding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(74), 0, 0, ScreenAdaper.height(23)),
                                  border: InputBorder.none,
                                ),
                                // textInputAction: _lecturer ? TextInputAction.search : TextInputAction.none,
                                // onEditingComplete: (){
                                //   _searchbytitleandteacher();
                                // }
                              ),
                              Positioned(
                                top: ScreenAdaper.height(15), left: ScreenAdaper.width(30),
                                child: Image.asset('images/home_image23.png', width: ScreenAdaper.width(28), height: ScreenAdaper.width(28),),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: ScreenAdaper.width(30),),
                      InkWell(
                        onTap: (){
                          setState(() {
                            if(!_isRetrieve){
                              Navigator.pop(context);
                            }
                            _isRetrieve = false;
                          });
                        },
                        child: Text('取消', style: TextStyle(color: Color(0xff010101), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                  !_isRetrieve ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: ScreenAdaper.height(40), bottom: ScreenAdaper.height(17)),
                    child: Text('大家都在搜', style: TextStyle(color: Color(0xff7F7F7F), fontSize: ScreenAdaper.size(28)), textAlign: TextAlign.start,),
                  ) : Container()
                  // tab导航
                  // : _tabList(),
                ],
              )
            ),
          )
        ],
      ),
    );
  }

  // 课程名检索列表
  Widget _retrieve(){
    if(_searchbytitleandteacherList.length > 0&&_inputValue!=''){
      List<Widget> list = _searchbytitleandteacherList.map((item){
        return InkWell(
          onTap: (){
            Navigator.pushNamed(context, '/watchcourse', arguments: {'collegeId': item.id});
          },
          child: SearchList(item:item, value: _inputValue,),
        );
      }).toList();
      return Wrap(
        spacing: 1,
        children: list,
      );
    }else{
      return _noResult();
    }
  }


  // 大家都在搜列表
  Widget _searchList(){
    if(_list.length!=0){
      List<Widget> listWidget = _list.map((item){
        return InkWell(
          onTap: (){
            Navigator.pushNamed(context, '/watchcourse', arguments: {'collegeId': item.collgeId});
          },
          child: Container(
            padding: EdgeInsets.only(left: ScreenAdaper.width(38)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: ScreenAdaper.width(34), height: ScreenAdaper.width(34), margin: EdgeInsets.only(right: ScreenAdaper.width(25), top: ScreenAdaper.height(27)),
                  decoration: BoxDecoration(
                    color: _list.indexOf(item) > 2 ? Color(0xffE5E5E5) : Color(0xffFFFFFF), borderRadius: BorderRadius.circular(3),
                  ),
                  child: _list.indexOf(item) > 2 ? Center(
                    child: Text('${_list.indexOf(item)+1}', style: TextStyle(fontSize: ScreenAdaper.size(22), color: Color(0xffFFFFFF), fontWeight: FontWeight.bold),),
                  ) : Image.asset('images/home_image1${_list.indexOf(item)+1}.png', fit: BoxFit.fill,) 
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: ScreenAdaper.height(23), bottom: ScreenAdaper.height(23)),
                        decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xffEFEFEF), width: 1)
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              constraints: BoxConstraints(maxWidth: ScreenAdaper.width(_list.indexOf(item) < 3 ? 580 : 620)),
                              child: Text('${item.title}', style: TextStyle(
                                fontSize: ScreenAdaper.size(26), color: Color(0xff000000), fontWeight: FontWeight.bold, height: 1.2),
                                maxLines: 2, overflow: TextOverflow.ellipsis, 
                              ),
                            ),
                            SizedBox(width: ScreenAdaper.width(_list.indexOf(item) < 3 ? 20 : 0),),
                            _list.indexOf(item) < 3 ? Image.asset('images/home_image24.png', width: ScreenAdaper.width(22), height: ScreenAdaper.height(26),) : Container(),
                            SizedBox(width: ScreenAdaper.width(30),),
                          ],
                        ),
                        SizedBox(height: ScreenAdaper.height(12),),
                        Text('讲师：${item.teacherName}', style: TextStyle(fontSize: ScreenAdaper.size(20), color: Color(0xff909090)),),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );  
      }).toList();
      return Wrap(
        children: listWidget,
        spacing: 1,
      );
    }else{
      return Container(
        padding: EdgeInsets.only(top: ScreenAdaper.height(100)),
        child: Loading(),
      );
    }
  }


  // 没有结果，不存在
  Widget _noResult(){
    return Column( 
      children: <Widget>[
        Container(
          width: double.infinity, margin: EdgeInsets.only(top: ScreenAdaper.height(60)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/Lack_image01.png', width: ScreenAdaper.width(280), height: ScreenAdaper.height(220),),
              SizedBox(height: ScreenAdaper.height(35),),
              Text('暂时没有相关信息', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.normal, fontFamily: 'Adobe Heiti Std'),)
            ],
          ),
        ),
        // 猜你喜欢
        Container(
          width: double.infinity, margin: EdgeInsets.only(top: ScreenAdaper.height(150)),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: ScreenAdaper.width(30),),
                  Text('猜你喜欢', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(30), fontWeight: FontWeight.bold)),
                  SizedBox(width: ScreenAdaper.width(8),),
                  Expanded(
                    child: Container(
                      width: double.infinity, height: ScreenAdaper.height(30),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: ScreenAdaper.height(1), color: Color(0xffEFEFEF)))
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: ScreenAdaper.height(35),),
              // 猜你喜欢列表
              Container(
                child: _courseList()
              )
            ],
          ),
        )
      ],
    );
  }


  Widget _courseList(){
    if(_recommendList.length > 0){
      List<Widget> lists = _recommendList.map((item){
        return InkWell(
          child: ClassificationList(item: item),
        );
      }).toList();
      return Wrap(
        children: lists,
      );
    }else{
      return Loading();
    }
  }



}