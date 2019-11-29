import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:with_me/services/screenAdaper.dart';

class HomePage extends StatefulWidget {
  Map arguments;
  HomePage({Key key, this.arguments}) : super(key:key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextStyle _text = TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(24));

  bool _isCircles = false;
  void _onChange(){
    setState(() {
      _isCircles = !_isCircles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          // 头部
          _Header(),
          // 课程分类
          _Classification(text: _text),
          Container(height: ScreenAdaper.height(20), color: Color(0xffF8F8F8),),
          // 课程上线
          _Online(),
          Divider(height: 1, color: Color(0xffEFEFEF),),
          // 预告
          _Trailer(isCircles: _isCircles, onChanged: _onChange),
          Container(height: ScreenAdaper.height(20), color: Color(0xffF8F8F8),),
          // 今日热点
          _Hot(),
          Container(height: ScreenAdaper.height(20), color: Color(0xffF8F8F8),),
          // 跨境攻略
          // _Strategy()
        ],
      )
    );
  }
}


// 头部
class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdaper.width(750), height: ScreenAdaper.height(387),
      child: Stack(
        children: <Widget>[
          // 轮播图
          Swiper(
            itemBuilder: (BuildContext context,int index){
              return Image.asset("images/1.png",fit: BoxFit.fill,);
            },
            itemCount: 3,
            autoplay: true,
            pagination: SwiperPagination(
              alignment: Alignment.bottomRight,
              margin: EdgeInsetsDirectional.fromSTEB(0, 0, ScreenAdaper.width(12), ScreenAdaper.height(7)),
              builder: DotSwiperPaginationBuilder(
                size: ScreenAdaper.width(12), activeSize: ScreenAdaper.width(12),
                color: Color.fromRGBO(245,133,75,0.4), activeColor: Color(0xffFFFFFF)
              )
            ),
          ),
          // 搜索栏
          Positioned(
            top: ScreenAdaper.height(54), left: 0,
            child: Container(
              width: ScreenAdaper.width(750),
              padding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(30), 0, ScreenAdaper.width(30), 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: ScreenAdaper.width(538), height: ScreenAdaper.height(58),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.12), 
                      borderRadius: BorderRadius.circular(ScreenAdaper.width(60))
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(30), 0, ScreenAdaper.width(12), 0),
                          child: Image.asset('images/home_image08.png',fit: BoxFit.fill, width: ScreenAdaper.width(28), height: ScreenAdaper.width(28),),
                        ),
                        Text('请输入课程名或讲师名', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(24)),)
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/home_image07.png', width: ScreenAdaper.width(36), height: ScreenAdaper.height(32),),
                      Text('咨询', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(18)))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


// 课程分类
class _Classification extends StatelessWidget {

  final TextStyle text;
  _Classification({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(0, ScreenAdaper.height(40), 0, ScreenAdaper.height(28)), color: Color(0xffFFFFFF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/home_image01.png', width: ScreenAdaper.width(96), height: ScreenAdaper.width(96),),
                SizedBox(height: ScreenAdaper.height(14),),
                Text('新手入门', style: text,)
              ],
            ),
          ),
          InkWell(
            child: Column(
              children: <Widget>[
                Image.asset('images/home_image02.png', width: ScreenAdaper.width(96), height: ScreenAdaper.width(96),),
                SizedBox(height: ScreenAdaper.height(14),),
                Text('小白升级', style: text,)
              ],
            ),
          ),
          InkWell(
            child: Column(
              children: <Widget>[
                Image.asset('images/home_image03.png', width: ScreenAdaper.width(96), height: ScreenAdaper.width(96),),
                SizedBox(height: ScreenAdaper.height(14),),
                Text('高手进阶', style: text,)
              ],
            ),
          ),
          InkWell(
            child: Column(
              children: <Widget>[
                Image.asset('images/home_image04.png', width: ScreenAdaper.width(96), height: ScreenAdaper.width(96),),
                SizedBox(height: ScreenAdaper.height(14),),
                Text('全部', style: text,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// 课程上线
class _Online extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffFFFFFF),
      height: ScreenAdaper.height(122), padding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(34), 0, ScreenAdaper.width(30), 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('images/home_image05.png', width: ScreenAdaper.width(57), height: ScreenAdaper.width(55),),
          Container(width: 1, height: ScreenAdaper.height(41), color: Color(0xffDDDDDD), margin: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(26), 0, ScreenAdaper.width(21), 0),),
          Expanded(
            child: Container(
              width: double.infinity, height: ScreenAdaper.height(122),
              child: Swiper(
                itemCount: 3,
                autoplay: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context,int index){
                  return Container(
                    width: double.infinity, height: ScreenAdaper.height(122),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Allan教你如何用Google开发新客户', style: TextStyle(
                                color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontFamily: 'Adobe Heiti Std', fontWeight: FontWeight.normal),
                                overflow: TextOverflow.ellipsis, maxLines: 1,
                              ),
                              Row(
                                children: <Widget>[
                                  Text('2019年11月20日8:00已上线', style: TextStyle(color: Color(0xffA2A2A2), fontSize: ScreenAdaper.size(20)),),
                                  Container(width: ScreenAdaper.width(40),),
                                  Text('1000人已学', style: TextStyle(color: Color(0xffA2A2A2), fontSize: ScreenAdaper.size(20)),),
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: ScreenAdaper.width(12), height: ScreenAdaper.width(12), margin: EdgeInsets.only(right: ScreenAdaper.width(16)),
                              child: CircleAvatar(
                                backgroundColor: Color(0xffFB4915),
                                radius: 90.0,
                              ),
                            ),
                            Image.asset('images/home_image06.png', width: ScreenAdaper.width(11), height: ScreenAdaper.height(16),)
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          )
          
        ],
      ),
    );
  }
}


// 预告
class _Trailer extends StatelessWidget {
  final bool isCircles;
  var onChanged;
  _Trailer({this.isCircles : false, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, height: ScreenAdaper.height(522), color: Color(0xffFFFFFF), 
      padding: EdgeInsetsDirectional.fromSTEB(0, ScreenAdaper.height(41), 0, 0),
      child: Column(
        children: <Widget>[
          // 标题
          Container(
            padding: EdgeInsets.only(left: ScreenAdaper.width(30)),
            child: Row(
              children: <Widget>[
                isCircles ?_circles('images/home_image09.png') : _circular('images/home_image09.png', '直播预告'),
                !isCircles ?_circles('images/home_image10.png') : _circular('images/home_image10.png', '课程预告'),
              ],
            ),
          ),
          // 列表
          Container(
            width: double.infinity, height: ScreenAdaper.height(360), 
            margin: EdgeInsets.only(top: ScreenAdaper.height(29)),
            child: _list(),
          ),
        ],
      ),
    );
  }


  // 标题圆
  Widget _circles(img){
    return InkWell(
      onTap: (){
        onChanged();
      },
      child: Container(
        width: ScreenAdaper.width(64), height: ScreenAdaper.width(64), margin: EdgeInsets.only(right: ScreenAdaper.width(20)),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 0), blurRadius: 5),
          ],
        ),
        child: CircleAvatar(
          radius: 20, backgroundColor: Color(0xffFFFFFF),
          child: Center(
            child: Image.asset(img, width: ScreenAdaper.width(26), height: ScreenAdaper.width(26),),
          ),
        ),
      ),
    );
  }

  // 标题椭圆
  Widget _circular(img, text){
    return Container(
      width: ScreenAdaper.width(186), height: ScreenAdaper.width(64), margin: EdgeInsets.only(right: ScreenAdaper.width(20)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30), color: Color(0xffFFFFFF),
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 0), blurRadius: 5),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(img, width: ScreenAdaper.width(26), height: ScreenAdaper.width(26),),
          SizedBox(width: ScreenAdaper.width(12),),
          Text(text, style: TextStyle(fontSize: ScreenAdaper.size(28), color: Color(0xff000000), fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }

  // 列表
  Widget _list(){
    return ListView.builder(
      scrollDirection: Axis.horizontal, padding: EdgeInsetsDirectional.fromSTEB(0, ScreenAdaper.height(5), 0, ScreenAdaper.height(5)),
      itemCount: 4,
      itemBuilder: (context, index){
        return Container(
          width: ScreenAdaper.width(391), height: ScreenAdaper.height(347), 
          margin: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(index==0?30:0), 0, ScreenAdaper.width(index==3?30:22), 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Color(0xffFFFFFF),
            boxShadow: [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.08), offset: Offset(0, 0), blurRadius: 3),
            ],
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: ScreenAdaper.width(391), height: ScreenAdaper.height(204), 
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6),
                  ),
                  child: Image.network('https://zcxy.oss-cn-beijing.aliyuncs.com/college/385feab035b14745a6bc0ae342dd533b', fit: BoxFit.fill,),
                ),
              ),
              Container(
                width: double.infinity, margin: EdgeInsets.only(top: ScreenAdaper.height(10)),
                padding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(21), 0, ScreenAdaper.width(21), 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('光速询盘转化秘籍大揭秘', style: TextStyle(fontSize: ScreenAdaper.size(24), color: Color(0xff000000), 
                      fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                    Text('— 箴创学院主办', style: TextStyle(fontSize: ScreenAdaper.size(20), color: Color(0xffA2A2A2)),),
                    SizedBox(height: ScreenAdaper.height(10),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('1300', style: TextStyle(fontSize: ScreenAdaper.size(20), color: Color(0xffFF8636)),),
                            Text('人已预约', style: TextStyle(fontSize: ScreenAdaper.size(20), color: Color(0xffA2A2A2)),),
                          ],
                        ),
                        Container(
                          width: ScreenAdaper.width(105), height: ScreenAdaper.width(40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30), color: Color(0xffFF8636),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('images/home_image22.png', width: ScreenAdaper.width(26), height: ScreenAdaper.width(26),),
                              SizedBox(width: ScreenAdaper.width(12),),
                              Text('预约', style: TextStyle(fontSize: ScreenAdaper.size(22), color: Color(0xffFFFFFF), fontWeight: FontWeight.bold),)
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }


}


// 今日热点
class _Hot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, height: ScreenAdaper.height(500), color: Color(0xffFFFFFF),
      padding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(30), ScreenAdaper.height(35), ScreenAdaper.width(30), 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('今日热点', style: TextStyle(fontSize: ScreenAdaper.size(34), color: Color(0xff000000), fontWeight: FontWeight.bold),),
          SizedBox(height: ScreenAdaper.height(35),),
          Container(
            width: double.infinity, height: ScreenAdaper.height(374),
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index){
                return Container(
                  margin: EdgeInsets.only(bottom: ScreenAdaper.height(29)),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: ScreenAdaper.width(228), height: ScreenAdaper.height(152), margin: EdgeInsets.only(right: ScreenAdaper.width(25)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6), topRight: Radius.circular(6), bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6),
                          ),
                          child: Image.network('https://zcxy.oss-cn-beijing.aliyuncs.com/college/385feab035b14745a6bc0ae342dd533b', fit: BoxFit.fill,),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('外贸老司机-Allan教你如何用Google开发新客户', style: TextStyle(
                              fontSize: ScreenAdaper.size(26), color: Color(0xff000000), fontWeight: FontWeight.bold, height: 1.2),
                              maxLines: 2, overflow: TextOverflow.ellipsis, 
                            ),
                            SizedBox(height: ScreenAdaper.height(12),),
                            Text('石真语 • 阿里巴巴金牌讲师', style: TextStyle(fontSize: ScreenAdaper.size(22), color: Color(0xffA2A2A2),),),
                            SizedBox(height: ScreenAdaper.height(3),),
                            Text('【企业管理】', style: TextStyle(fontSize: ScreenAdaper.size(22), color: Color(0xffFF8636)),),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}


// 跨境攻略
class _Strategy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, height: ScreenAdaper.height(474), color: Color(0xffFFFFFF),
      padding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(30), ScreenAdaper.height(35), ScreenAdaper.width(30), 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('跨境攻略', style: TextStyle(fontSize: ScreenAdaper.size(34), color: Color(0xff000000), fontWeight: FontWeight.bold),),
          SizedBox(height: ScreenAdaper.height(35),),
          Container(
            width: double.infinity, height: ScreenAdaper.height(374),
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index){
                return Container(
                  margin: EdgeInsets.only(bottom: ScreenAdaper.height(29)),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: ScreenAdaper.width(228), height: ScreenAdaper.height(152), margin: EdgeInsets.only(right: ScreenAdaper.width(25)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6), topRight: Radius.circular(6), bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6),
                          ),
                          child: Image.network('https://zcxy.oss-cn-beijing.aliyuncs.com/college/385feab035b14745a6bc0ae342dd533b', fit: BoxFit.fill,),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('外贸老司机-Allan教你如何用Google开发新客户', style: TextStyle(
                              fontSize: ScreenAdaper.size(26), color: Color(0xff000000), fontWeight: FontWeight.bold, height: 1.2),
                              maxLines: 2, overflow: TextOverflow.ellipsis, 
                            ),
                            SizedBox(height: ScreenAdaper.height(12),),
                            Text('石真语 • 阿里巴巴金牌讲师', style: TextStyle(fontSize: ScreenAdaper.size(22), color: Color(0xffA2A2A2),),),
                            SizedBox(height: ScreenAdaper.height(3),),
                            Text('【企业管理】', style: TextStyle(fontSize: ScreenAdaper.size(22), color: Color(0xffFF8636)),),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}



