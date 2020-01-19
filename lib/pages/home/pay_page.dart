import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:with_me/config/service_method.dart';
import '../../services/screenAdaper.dart';
import 'package:provider/provider.dart';
import '../../provider/courseDetails.dart';
import '../../model/watchcourse_model.dart';
import '../../model/coupon_model.dart';
import '../../services/storage.dart';
import '../../services/convertNum.dart';
import '../widget/toast.dart';
import '../widget/dialog.dart';
import '../bottom_tab/bottom.dart';
import '../../services/userinfo.dart';

class PayPage extends StatefulWidget {
  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {

  var _userName = '';
  int _balance = 0;


  @override
  void initState() {
    super.initState();

    getUser();
  }

  void getUser()async{
    var userinfo = await Storage.getString('userinfo');
    setState((){
      _userName = json.decode(userinfo)['UserName'];
      _balance = json.decode(userinfo)['Balance'];
      print(_balance);
    });
  }


  Timer time;
  void pay(goodsId, couponId){
    ProgressDialog.showProgress(context);
    apiMethod('createorder', 'post', {'GoodsId': goodsId, 'PayType': 3, 'UserCouponId': couponId, 'GoodsType': 1}).then((res){
      ProgressDialog.dismiss(context);
      if(res.data['IsSuccess']){
        toast('支付成功！');
        getUserinfoMethod();
        time = Timer(Duration(milliseconds:1000), (){
          Navigator.pushReplacementNamed(context, '/watchcourse', arguments: {'collegeId': goodsId});
        });
      }else{
        toast(res.data['Message']);
      }
    });
  }


  // 弹出对话框
  Future<bool> showDeleteConfirmDialog1() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CourseDetails>(context);
    WatchcourseModel course = provider.courseDetails;
    CouponModelData coupon = provider.couponItem;
    int couponIndex = provider.couponIndex;
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
                          child: Container(
                            width: ScreenAdaper.width(50), height: ScreenAdaper.height(30), alignment: Alignment.bottomLeft,
                            child: Image.asset('images/home_image28.png', width: ScreenAdaper.width(16),)
                          ),
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
                  child: Text('您好，爱学习的$_userName：', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(32), fontWeight: FontWeight.bold),),
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
                              child: Image.network('${course.data.teacherImg}', fit: BoxFit.fill,),
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
                              child: Text('${course.data.categoryIdrStr}', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(16)),),
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
                                  Text('${course.data.title}', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold), 
                                    maxLines: 1, overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: ScreenAdaper.height(8),),
                                  Text('${course.data.teacherName} • ${course.data.teacherTitle}', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(20)), 
                                    maxLines: 1, overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: ScreenAdaper.height(15),),
                                  Text('${course.data.description}', style: TextStyle(color: Color(0xffA2A2A2), fontSize: ScreenAdaper.size(20), height: 1.25), 
                                    maxLines: 2, overflow: TextOverflow.ellipsis, 
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: ScreenAdaper.height(10), left: 0,
                              child: Row(
                                children: <Widget>[
                                  Text('${course.data.collegeClass.length}课时 • ', style: TextStyle(color: Color(0xffA2A2A2), fontSize: ScreenAdaper.size(18))),
                                  Text('￥${convertNum(course.data.collegePrice)}', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(18))),
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
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/coupon');
                    },
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
                            Text('-￥${coupon!=null&&couponIndex!=-1?convertNum(coupon.price):0}', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(28)),),
                            SizedBox(width: ScreenAdaper.width(15),),
                            Text('>', style: TextStyle(color: Color(0xffC2C2C2), fontSize: ScreenAdaper.size(28)),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: ScreenAdaper.height(20),),
                // 金额
                _balance > course.data.collegePrice ? Container(
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
                          Text('￥${(convertNum(_balance))}', style: TextStyle(color: Color(0xffC1C1C1), fontSize: ScreenAdaper.size(22)),),
                        ],
                      ),
                      Image.asset('images/home_image55.png', width: ScreenAdaper.width(42)),
                    ],
                  ),
                ) :
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/recharge');
                  },
                  child: Container(
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
                            Text('￥${convertNum(course.data.collegePrice)}（不足支付）', style: TextStyle(color: Color(0xffC1C1C1), fontSize: ScreenAdaper.size(22)),),
                          ],
                        ),
                        Text('去充值', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),)
                      ],
                    ),
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
                        Text('￥${convertNum(course.data.collegePrice - (coupon!=null&&couponIndex!=-1?coupon.price:0))}', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(34), fontWeight: FontWeight.bold),),
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("提示"),
                            content: Text("您确定要支付吗?"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("取消"),
                                onPressed: () => Navigator.of(context).pop(), //关闭对话框
                              ),
                              FlatButton(
                                child: Text("支付"),
                                onPressed: () {
                                  pay(course.data.id, coupon!=null&&couponIndex!=-1?coupon.id:'');
                                  Navigator.of(context).pop(true); //关闭对话框
                                },
                              ),
                            ],
                          );
                        });
                      },
                      child: Container(
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