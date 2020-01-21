import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import '../widget/loading.dart';
import '../widget/toast.dart';
import '../../config/service_method.dart';
import '../../model/strategylist_model.dart';

class StrategyPage extends StatefulWidget {
  @override
  _StrategyPageState createState() => _StrategyPageState();
}

class _StrategyPageState extends State<StrategyPage> {

  List<Data> strategy = [];

  @override
  void initState() {
    super.initState();

    getList();
    
  }

  void getList(){
    apiMethod('strategylist', 'post', {'CategoryId': 40}).then((res){
      if(res.data['IsSuccess']){
        var datas = StrategylistModel.fromJson(res.data);
        setState(() {
          strategy = datas.data;
        });
      }else{
        toast(res.data['Message']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffFFFFFF),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity, height: ScreenAdaper.height(240),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/kuajinggonglve_image27.png'), fit: BoxFit.fill,
                )
              ),
            ),
            Positioned(
              child: Stack(
                children: <Widget>[
                  strategy.length > 0 ? Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(30), ScreenAdaper.height(139), ScreenAdaper.width(30), ScreenAdaper.height(20)),
                    child: ListView.builder(
                      itemCount: strategy.length, padding: EdgeInsets.all(0),
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/strategyDetail', arguments: {'id': strategy[index].id});
                          },
                          child: Container(
                            width: double.infinity, margin: EdgeInsets.only(bottom: ScreenAdaper.height(20),),
                            padding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(30), ScreenAdaper.height(25), ScreenAdaper.width(30), ScreenAdaper.height(23)),
                            decoration: BoxDecoration(
                              color: Color(0xffFFFFFF), 
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 0), blurRadius: 5),
                              ] 
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, 
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('${strategy[index].title}', style: TextStyle(
                                    color: Color(0xff000000), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold, height: ScreenAdaper.height(2.6),
                                  ),
                                  maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: ScreenAdaper.height(8),),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '【${strategy[index].categoryId2Str}】', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(20), fontWeight: FontWeight.w400)
                                      ),
                                      TextSpan(
                                        text: '${strategy[index].createTime}', style: TextStyle(color: Color(0xffA2A2A2), fontSize: ScreenAdaper.size(20), fontWeight: FontWeight.w400)
                                      ),
                                    ]
                                  )
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ) : Loading(),
                  Positioned(
                    child: Container(
                      width: double.infinity, height: ScreenAdaper.height(149), 
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
                                  child: Image.asset('images/home_image28.png', width: ScreenAdaper.width(16),)
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text('跨境攻略', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(34), fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}