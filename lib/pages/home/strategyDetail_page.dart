import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import 'package:flutter_html_widget/flutter_html_widget.dart';
import '../../config/service_method.dart';
import '../widget/toast.dart';
import '../../model/strategyDetail_model.dart';
import '../widget/loading.dart';

class StrategyDetailPage extends StatefulWidget {
 var arguments;
 StrategyDetailPage({this.arguments});

  @override
  _StrategyDetailPageState createState() => _StrategyDetailPageState();
}

class _StrategyDetailPageState extends State<StrategyDetailPage> {

  StrategyDetailModel strategyDetail;
  String html;


  @override
  void initState() { 
    super.initState();
    
    apiMethod('strategylistdetail', 'get', '/${widget.arguments['id']}').then((res){
      if(res.data['IsSuccess']){
        var datas = StrategyDetailModel.fromJson(res.data);
        setState(() {
          strategyDetail = datas;
          html = '${datas.data.content.replaceAll('\"', '"').replaceAll('https://', '//')}';
        });
      }else{
        toast(res.data['Message']);
      }
    });
  }

  get key => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffFFFFFF),
        child: Stack(
          children: <Widget>[
            strategyDetail !=null ? ListView(
              padding: EdgeInsets.only(top: ScreenAdaper.height(148), left: ScreenAdaper.width(30), right: ScreenAdaper.width(30), bottom: ScreenAdaper.height(30)),
              children: <Widget>[
                Text('${strategyDetail.data.title}', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(30), fontWeight: FontWeight.bold, height: 1.2)),
                SizedBox(height: ScreenAdaper.height(10),),
                Text('${strategyDetail.data.createTime}', style: TextStyle(color: Color(0xff7E7E7E), fontSize: ScreenAdaper.size(26)),),
                SizedBox(height: ScreenAdaper.height(20),),
                Container(
                  child: HtmlWidget(html: html, key: key),
                )
              ],
            ) : Loading(),
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
                            child: Text('攻略详情', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(34), fontWeight: FontWeight.bold, fontFamily: 'PingFang SC'),),
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