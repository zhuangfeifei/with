import 'package:flutter/material.dart';
import 'package:with_me/pages/widget/loading.dart';
import '../../services/screenAdaper.dart';
import '../../config/service_method.dart';
import '../../model/coupon_model.dart';
import '../widget/toast.dart';
import '../widget/loading.dart';
import 'package:provider/provider.dart';
import '../../provider/courseDetails.dart';
import '../../services/convertNum.dart';

class CouponPage extends StatefulWidget {
  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {

  bool _isUse = false;

  CouponModel pointexchangelist;

  @override
  void initState() {
    super.initState();

    apiMethod('mycouponlist', 'post', {'Status': 1, 'PageSize': 100, 'PageIndex': 1 }).then((res){
      // print(res.data);
      var list = CouponModel.fromJson(res.data);
      if(res.data['IsSuccess']){
        setState(() {
          pointexchangelist = list;
        });
      }else{
        toast(res.data['Message']);
      }  
    });
    
  }

  @override
  Widget build(BuildContext context) {
    var couponItem = Provider.of<CourseDetails>(context);
    return Scaffold(
      body: Container(
        color: Color(0xffFFFFFF),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity, height: ScreenAdaper.height(250),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/home_image59.png'), fit: BoxFit.fill,
                )
              ),
            ),
            ListView(
              padding: EdgeInsets.only(top: ScreenAdaper.height(50), left: ScreenAdaper.width(30), right: ScreenAdaper.width(30)),
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
                        child: Text('选择优惠券', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(34), fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ),
                SizedBox(height: ScreenAdaper.height(44),),
                InkWell(
                  onTap: (){
                    setState(() {
                      _isUse = !_isUse;
                    });
                    couponItem.initCouponIndex(-1);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity, height: ScreenAdaper.height(88), padding: EdgeInsets.only(left: ScreenAdaper.width(25), right: ScreenAdaper.width(35)),
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF), borderRadius: BorderRadius.circular(5)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('不使用优惠券', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),),
                        Image.asset('images/home_image5${_isUse?5:4}.png', width: ScreenAdaper.width(42),),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: ScreenAdaper.height(50),),
                // 优惠券列表
                this.pointexchangelist !=null ? this.pointexchangelist.data.length>0 ? Wrap(
                  children: this.pointexchangelist.data.map((item){
                    return InkWell(
                      onTap: (){
                        setState(() {
                          _isUse = false;
                        });
                        couponItem.initCouponItem(item);
                        couponItem.initCouponIndex(this.pointexchangelist.data.indexOf(item));
                        Navigator.pop(context);
                      },
                      child: Opacity(
                        opacity: 1,
                        // opacity: this.pointexchangelist.data.indexOf(item) > 2 ? 0.5 : 1,
                        child: Container(
                          width: double.infinity, height: ScreenAdaper.height(172), 
                          padding: EdgeInsets.only(right: ScreenAdaper.width(35)), margin: EdgeInsets.only(bottom: ScreenAdaper.height(26)),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/home_image58.png'), fit: BoxFit.fill
                            )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: ScreenAdaper.width(182),
                                    child: Text('${convertNum(item.price)}', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(84), fontWeight: FontWeight.w400), textAlign: TextAlign.right),
                                  ),
                                  SizedBox(width: ScreenAdaper.width(36),),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('${item.couponTitle}', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),),
                                      SizedBox(height: ScreenAdaper.height(3),),
                                      Text('*实际支付大于${convertNum(item.limitPrice)}牛币可用', style: TextStyle(color: Color(0xff7E7E7E), fontSize: ScreenAdaper.size(14), fontWeight: FontWeight.bold),),
                                      Text('*有效期日期${item.startTime}～${item.endTime}', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(14), fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ],
                              ),
                              Image.asset('images/home_image5${couponItem.couponIndex==this.pointexchangelist.data.indexOf(item)?7:6}.png', width: ScreenAdaper.width(42),),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList()
                ) : Container(
                  color: Color(0xffFFFFFF), margin: EdgeInsets.only(top: ScreenAdaper.height(200)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('images/Lack_image01.png', width: ScreenAdaper.width(280), height: ScreenAdaper.height(220),),
                        SizedBox(height: ScreenAdaper.height(35),),
                        Text('暂无可用优惠券', style: TextStyle(color: Color(0xff909090), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.normal, fontFamily: 'Adobe Heiti Std'),)
                      ],
                    ),
                  )
                ) : Loading()
              ],
            )
          ],
        ),
      ),
    );
  }
}