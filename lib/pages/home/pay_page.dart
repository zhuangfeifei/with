import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';

class PayPage extends StatefulWidget {

  var arguments;
  PayPage({this.arguments});

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffF8F8F8),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity, height: ScreenAdaper.height(329),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/home_image52.png'), fit: BoxFit.fill,
                )
              ),
            ),
            ListView(
              padding: EdgeInsets.only(top: ScreenAdaper.height(50), left: ScreenAdaper.width(20), right: ScreenAdaper.width(20)),
              children: <Widget>[
                Container(
                  width: double.infinity, height: ScreenAdaper.height(45), 
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomLeft, 
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Image.asset('images/home_image28.png', width: ScreenAdaper.width(16), height: ScreenAdaper.height(30)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text('支付', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(34), fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ),
                SizedBox(height: ScreenAdaper.height(42),),
                Container(
                  padding: EdgeInsets.only(left: ScreenAdaper.width(35)),
                  child: Text('您好，爱学习的小杨：', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(32), fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: ScreenAdaper.height(36),),
                // 课程
                Container(
                  padding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(20), ScreenAdaper.height(26), ScreenAdaper.width(20), ScreenAdaper.height(26)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Color(0xffFFFFFF),
                    boxShadow: [
                      BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 0), blurRadius: 5)
                    ]
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            width: ScreenAdaper.width(162), height: ScreenAdaper.height(220),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: Image.network('http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg', fit: BoxFit.fill,),
                            ),
                          ),
                          Positioned(
                            top: 0, left: 0,
                            child: Container(
                              width: ScreenAdaper.width(90), height: ScreenAdaper.height(26),
                              padding: EdgeInsets.only(left: ScreenAdaper.width(6)),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('images/home_image32.png'), alignment: Alignment.centerLeft, fit: BoxFit.fill,
                                )
                              ),
                              child: Text('456456', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(16)),),
                            ),
                          )
                        ],
                      ),
                      SizedBox(width: ScreenAdaper.width(20),),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: double.infinity, height: ScreenAdaper.height(220),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Aellen老师揭晓学院年度大课的秘密', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold), 
                                    maxLines: 1, overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: ScreenAdaper.height(8),),
                                  Text('严杰 • 阿里巴巴金牌讲师师', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(20)), 
                                    maxLines: 1, overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: ScreenAdaper.height(15),),
                                  Text('这个课程帮助一个人的人格完善完成帮助你更好的洞察能力，一个人的人格完善完成帮助你更好的洞察能嗯嗯问', style: TextStyle(color: Color(0xffA2A2A2), fontSize: ScreenAdaper.size(20), height: 1.25), 
                                    maxLines: 2, overflow: TextOverflow.ellipsis, 
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: ScreenAdaper.height(10), left: 0,
                              child: Row(
                                children: <Widget>[
                                  Text('103课时 • ', style: TextStyle(color: Color(0xffA2A2A2), fontSize: ScreenAdaper.size(18))),
                                  Text('￥1888', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(18))),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: ScreenAdaper.height(20),),
                // 优惠券
                Container(
                  width: double.infinity, height: ScreenAdaper.height(86), padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(34)),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF), borderRadius: BorderRadius.circular(6)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('优惠券', style: TextStyle(color: Color(0xff090909), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),), 
                          Text('（已选推荐优惠券）', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(20), fontWeight: FontWeight.bold),)
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('-￥5', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(28)),),
                          SizedBox(width: ScreenAdaper.width(15),),
                          Text('>', style: TextStyle(color: Color(0xffC2C2C2), fontSize: ScreenAdaper.size(28)),),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: ScreenAdaper.height(20),),
                // 金额
                Container(
                  width: double.infinity, height: ScreenAdaper.height(86), padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(34)),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF), borderRadius: BorderRadius.circular(6)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset('images/home_image53.png', width: ScreenAdaper.width(37), height: ScreenAdaper.height(46),),
                          SizedBox(width: ScreenAdaper.width(27),),
                          Text('牛币', style: TextStyle(color: Color(0xff090909), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),), 
                          SizedBox(width: ScreenAdaper.width(15),),
                          Text('￥222220.00', style: TextStyle(color: Color(0xffC1C1C1), fontSize: ScreenAdaper.size(22)),),
                        ],
                      ),
                      Image.asset('images/home_image55.png', width: ScreenAdaper.width(42)),
                    ],
                  ),
                ),
                SizedBox(height: ScreenAdaper.height(20),),
                Container(
                  width: double.infinity, height: ScreenAdaper.height(86), padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(34)),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF), borderRadius: BorderRadius.circular(6)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset('images/home_image53.png', width: ScreenAdaper.width(37), height: ScreenAdaper.height(46),),
                          SizedBox(width: ScreenAdaper.width(27),),
                          Text('牛币', style: TextStyle(color: Color(0xff090909), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),), 
                          SizedBox(width: ScreenAdaper.width(15),),
                          Text('￥0.00（不足支付）', style: TextStyle(color: Color(0xffC1C1C1), fontSize: ScreenAdaper.size(22)),),
                        ],
                      ),
                      Text('去充值', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                SizedBox(height: ScreenAdaper.height(20),),
                // 购买须知
                Container(
                  width: double.infinity, padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(34), vertical: ScreenAdaper.height(20)),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF), borderRadius: BorderRadius.circular(6)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('购买须知', style: TextStyle(color: Color(0xff090909), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),), 
                      SizedBox(height: ScreenAdaper.height(20),),
                      Text('1、本课程为预期课程，包含老师亲自录制的授课视频，讲义演示及学术问答；', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(24)),), 
                      Text('2、本课程购买成功后，可永久性学习使用该课程的所有内容请在“已购”处学习和使用；', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(24)),), 
                      Text('3、本课程一经购买，概不支持更换，敬请理解！', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(24)),), 
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0, left: 0,
              child: Container(
                width: ScreenAdaper.width(750), height: ScreenAdaper.height(98), color: Color(0xffFFFFFF),
                padding: EdgeInsets.only(left: ScreenAdaper.width(55), right: ScreenAdaper.width(40)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[ 
                    Row(
                      children: <Widget>[
                        Text('应付：', style: TextStyle(color: Color(0xff3B3B3B), fontSize: ScreenAdaper.size(26)),), 
                        Text('￥194', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(34), fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Container(
                      width: ScreenAdaper.width(194), height: ScreenAdaper.height(72),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffFDB342), Color(0xffF36A37)]
                        ),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Center(
                        child: Text('确认支付', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(28)),),
                      ),
                    ),
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