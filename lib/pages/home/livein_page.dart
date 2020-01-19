import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/screenAdaper.dart';
import '../widget/live_list copy.dart';
import '../../config/service_method.dart';
import '../widget/toast.dart';
import '../../model/liveList_model.dart';
import '../../provider/liveListProvider.dart';

class LiveinPage extends StatefulWidget {
  @override
  _LiveinPageState createState() => _LiveinPageState();
}

class _LiveinPageState extends State<LiveinPage> {
  // List liveinlist = [];

  @override
  void initState() {
    super.initState();
    // livestreaming();
  }

  // livestreaming(){
  //   apiMethod('livestreaming', 'post','?pageIndex=1').then((res){
  //     print(res);
  //     if(res.data['Code'] == '5002'){
  //       Navigator.pushNamed(context, '/login');
  //     }
  //     if(res.data['IsSuccess']){
  //       var list = LiveListModel.fromJson(res.data);
  //       setState(() {
  //         liveinlist = list.data;
  //       });
  //     }else{
  //       toast(res.data['Message']);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LiveListProvider>(context);
    LiveListModel liveinlist = provider.livelists;
    return Scaffold(
      body: Container(
        color: Color(0xffFFFFFF),
        child: Stack(
          children: <Widget>[
            liveinlist.data.length > 0 ? ListView.builder(
              padding: EdgeInsets.only(top: ScreenAdaper.height(148)),
              itemCount: liveinlist.data.length,
              itemBuilder: (context, index){
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(30)),
                  child: LiveList(list: liveinlist.data[index]),
                );
              },
            ) : Container(),
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
                                child: Image.asset('images/home_image29.png', width: ScreenAdaper.width(16), height: ScreenAdaper.height(30)),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text('直播中', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(34), fontWeight: FontWeight.bold, fontFamily: 'PingFang SC'),),
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
}