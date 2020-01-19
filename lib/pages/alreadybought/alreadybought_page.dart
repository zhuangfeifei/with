import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/counter.dart';
import '../../config/service_method.dart';
import '../widget/toast.dart';
import '../../model/classificationList_model.dart';
import '../widget/classification_list.dart';
import '../../services/screenAdaper.dart';
import '../../services/convertNum.dart';
import '../widget/loading.dart';
import '../widget/myCourse_list.dart';


class AlreadyboughtPage extends StatefulWidget {
  @override
  _AlreadyboughtPageState createState() => _AlreadyboughtPageState();
}

class _AlreadyboughtPageState extends State<AlreadyboughtPage> with AutomaticKeepAliveClientMixin {

  List myorderList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getList();
  }

  void getList(){
    apiMethod('myorder', 'post', {"PageSize":100,"PageIndex":1,"GoodsTypeList":[1],"Filter":0,"IsNeedExtendInfo":0}).then((res){
      if(res.data['IsSuccess']){
        var list = ClassificationListModel.fromJson(res.data);
        setState(() {
          myorderList = list.data;
        });
      }else{
        toast(res.data['Message']);
      }
    });
  }

  Future<void> _onRefresh()async{
    print('下拉刷新');
    await Future.delayed(Duration(milliseconds: 1000),(){
      getList();
    }); 
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: myorderList==null ? Loading() : myorderList.length > 0 ? Container(
          color: Colors.black, padding: EdgeInsets.only(top: ScreenAdaper.getStatusBarHeight()),
          child: Container(
            color: Color(0xffFFFFFF),
            child: ListView.builder(
              padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
              itemCount: myorderList.length,
              itemBuilder: (context, index){
                var item = myorderList[index];
                return MyCourseList(item: item);
              },
            ),
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
      ),
    );
  }
}