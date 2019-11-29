import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    ScreenAdaper.init(context);

    return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/StartBackground.png'), 
              // image: NetworkImage('https://zcxy.oss-cn-beijing.aliyuncs.com/App/StartBackground.png'), 
              fit: BoxFit.fill,
            )
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: ScreenAdaper.height(103),
                child: Container(
                  width: ScreenAdaper.width(750),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/registered');
                        },
                        child: Container(
                          width: ScreenAdaper.width(570), height: ScreenAdaper.height(98), color: Colors.white,
                          child: Center(
                            child: Text('注册领取礼包', style: TextStyle(
                              color: Color(0xff000000), fontSize: ScreenAdaper.size(32), fontWeight: FontWeight.bold
                            ),),
                          )
                        ),
                      ),
                      Container(
                        width: ScreenAdaper.width(570), margin: EdgeInsets.only(top: ScreenAdaper.height(29)),
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: Container(
                                  width: ScreenAdaper.width(275), height: ScreenAdaper.height(98),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: ScreenAdaper.width(2))
                                  ),
                                  child: Center(child: Text('手机登录', style: TextStyle(
                                    fontSize: ScreenAdaper.size(32), color: Colors.white, fontWeight: FontWeight.bold
                                  ),),),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                child: Container(
                                  width: ScreenAdaper.width(275), height: ScreenAdaper.height(98),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white, width: ScreenAdaper.width(2))
                                  ),
                                  child: Center(child: Text('微信授权登录', style: TextStyle(
                                    fontSize: ScreenAdaper.size(32), color: Colors.white, fontWeight: FontWeight.bold
                                  ),),),
                                ),
                              ),
                            ),
                          ],
                        )
                      )
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