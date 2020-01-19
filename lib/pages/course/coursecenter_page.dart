import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import '../widget/classification_list.dart';
import '../widget/loading.dart';
import '../widget/toast.dart';
import '../../config/service_method.dart';
import '../../model/classificationList_model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import '../../pages/widget/dialog.dart';

class CoursecenterPage extends StatefulWidget {
  @override
  _CoursecenterPageState createState() => _CoursecenterPageState();
}

class _CoursecenterPageState extends State<CoursecenterPage> with AutomaticKeepAliveClientMixin {
  List _tab = [{'title':'全部', 'id': ''}, {'title':'新手入门', 'id': '41'}, {'title': '小白升级', 'id': '42'}, {'title':'高手进阶', 'id': '43'}];
  int _tabIndex = 0;

  int pageIndex = 1;
  List<Data> _classificationList;

  var _categoryIdAPP;

  @override
  void initState() {
    super.initState();
    _categoryIdAPP = _tab[0]['id'];
    getList(false);
  }

  void getList(isShowDialog){
    if(isShowDialog && pageIndex==1) ProgressDialog.showProgress(context);
    apiMethod('classification', 'post', {'CategoryIdAPP': _categoryIdAPP, 'PageIndex': pageIndex, 'PageSize': 10}).then((res){
      if(isShowDialog) ProgressDialog.dismiss(context);
      if(res.data['IsSuccess']){
        var list = ClassificationListModel.fromJson(res.data);
        setState(() {
          pageIndex == 1? _classificationList = list.data : _classificationList.addAll(list.data);
        });
      }else{
        toast(res.data['Message']);
      }
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: ScreenAdaper.height(98)+ScreenAdaper.getStatusBarHeight()),
            child: _classificationList ==null ? Loading() : _classificationList.length > 0 ? EasyRefresh.custom(
              header: BallPulseHeader(),
              footer: BallPulseFooter(),
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 1), () {
                  setState(() {
                    pageIndex = 1;
                    getList(true);
                  });
                });
              },
              onLoad: () async {
                await Future.delayed(Duration(seconds: 1), () {
                  setState(() {
                    pageIndex += 1;
                    getList(true);
                  });
                });
              },
              slivers: <Widget>[
                // SizedBox(height: ScreenAdaper.height(20),),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return InkWell(
                        child: _classificationList.length > 0 ? ClassificationList(item:_classificationList[index]) : Loading(),
                      );
                    },
                    childCount: _classificationList.length,
                  ),
                ),
              ],
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
          ),
          Positioned(
            // top: ScreenAdaper.getStatusBarHeight(), left: 0,
            child: Container(
              color: Colors.black, height: ScreenAdaper.height(98) + ScreenAdaper.getStatusBarHeight(),
              padding: EdgeInsets.only(top: ScreenAdaper.getStatusBarHeight()),
              child: Column(
                children: <Widget>[
                  // Container(
                  //   width: double.infinity, height: ScreenAdaper.height(127),
                  //   padding: EdgeInsets.only(top: ScreenAdaper.height(30)),
                  //   child: Stack(
                  //     children: <Widget>[
                  //       Align(
                  //         alignment: Alignment.center,
                  //         child: Text('课程中心', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(34), fontWeight: FontWeight.bold, fontFamily: 'PingFang SC'),),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Divider(height: ScreenAdaper.height(1), color: Color(0xffEFEFEF),),
                  _tabList()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget _tabList(){
    return Container(
      padding: EdgeInsets.only(left: ScreenAdaper.width(20), right: ScreenAdaper.width(20)),
      width: double.infinity, height: ScreenAdaper.height(98), color: Color(0xffFFFFFF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: this._tab.map((item){
          return InkWell(
            onTap: (){
              setState(() {
                setState(() {
                  _tabIndex = _tab.indexOf(item);
                  _categoryIdAPP = item['id'];
                  pageIndex = 1;
                });
                getList(true);
              });
            },
            child: Container(
              height: ScreenAdaper.height(40),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: ScreenAdaper.width(_tab.indexOf(item) == 0?90:145), height: ScreenAdaper.height(10), color: Color(_tab.indexOf(item) == _tabIndex ? 0xffFF8636 : 0xffFFFFFF),
                    margin: EdgeInsets.only(top: ScreenAdaper.height(30)),
                  ),
                  Positioned(
                    bottom: ScreenAdaper.height(_tab.indexOf(item) == _tabIndex ?-3:0), left: 0, 
                    child: Container(
                      width: ScreenAdaper.width(_tab.indexOf(item) == 0?90:145),
                      child: Text('${item['title']}', style: TextStyle(
                        color: Color(_tab.indexOf(item) == _tabIndex ? 0xff000000 : 0xff7E7E7E) , fontSize: ScreenAdaper.size(_tab.indexOf(item) == _tabIndex ? 32 : 28), 
                          fontWeight: _tab.indexOf(item) == _tabIndex ? FontWeight.bold : FontWeight.w400), 
                        textAlign: TextAlign.center,
                      ),
                    )
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}