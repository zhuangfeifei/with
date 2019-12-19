import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:with_me/pages/widget/classification_list.dart';
import '../../services/screenAdaper.dart';
import '../widget/course_list.dart';
import '../../config/service_method.dart';
import '../../model/home_model.dart';
import '../widget/loading.dart';
import '../widget/strategy_list.dart';
import '../widget/toast.dart';
import '../../pages/widget/dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  Map arguments;
  HomePage({Key key, this.arguments}) : super(key:key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeModel _homeList;

  TextStyle _text = TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(24));

  bool _isCircles = false;

  void _onChange(){
    setState(() {
      _isCircles = !_isCircles;
    });
  }

  @override
  void initState() {
    super.initState();
    // getHome();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getHome();
  }

  getHome(){
    apiMethod('home', 'get','').then((res){
      // print(res);
      var list = HomeModel.fromJson(res.data);
      setState(() {
        _homeList = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _homeList != null ? ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          // 头部
          _Header(bannerLists: _homeList.data.bannerList),
          // 课程分类
          _Classification(text: _text),
          Container(height: ScreenAdaper.height(20), color: Color(0xffF8F8F8),),
          // 课程上线
          _Online(),
          Divider(height: 1, color: Color(0xffEFEFEF),),
          // 预告
          _Trailer(isCircles: _isCircles, onChanged: _onChange, bookCollegeLists: _homeList.data.bookCollegeList, bookLsRoomLists: _homeList.data.bookLsRoomList),
          Container(height: ScreenAdaper.height(20), color: Color(0xffF8F8F8),),
          // 今日热点
          _Hot(hotCollegeLists: _homeList.data.hotCollegeList),
          Container(height: ScreenAdaper.height(20), color: Color(0xffF8F8F8),),
          // 跨境攻略
          _Strategy(kJGLLists: _homeList.data.kJGLList)
        ],
      ) : Loading()
    );
  }
}


// 头部
class _Header extends StatelessWidget {
  final List<BannerList> bannerLists;
  _Header({this.bannerLists});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdaper.width(750), height: ScreenAdaper.height(387),
      child: Stack(
        children: <Widget>[
          // 轮播图
          Swiper(
            itemCount: bannerLists.length,
            itemBuilder: (BuildContext context,int index){
              return Image.network("${bannerLists[index].imageUrl}",fit: BoxFit.fill,);
            },
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
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/search');
                      // ProgressDialog.showProgress(context, child: SpinKitFadingCircle(
                      //   itemBuilder: (_, int index) {
                      //     return DecoratedBox(
                      //       decoration: BoxDecoration(
                      //         color: index.isEven ? Colors.red : Colors.green,
                      //       ),
                      //     );
                      //   },)
                      // );
                    },
                    child: Container(
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
            onTap: (){
              Navigator.pushNamed(context, '/classification', arguments: {'index': 0});
            },
            child: Column(
              children: <Widget>[
                Image.asset('images/home_image04.png', width: ScreenAdaper.width(96), height: ScreenAdaper.width(96),),
                SizedBox(height: ScreenAdaper.height(14),),
                Text('全部', style: text,)
              ],
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/classification', arguments: {'index': 1});
            },
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
            onTap: (){
              Navigator.pushNamed(context, '/classification', arguments: {'index': 2});
            },
            child: Column(
              children: <Widget>[
                Image.asset('images/home_image02.png', width: ScreenAdaper.width(96), height: ScreenAdaper.width(96),),
                SizedBox(height: ScreenAdaper.height(14),),
                Text('小白升级', style: text,)
              ],
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/classification', arguments: {'index': 3});
            },
            child: Column(
              children: <Widget>[
                Image.asset('images/home_image03.png', width: ScreenAdaper.width(96), height: ScreenAdaper.width(96),),
                SizedBox(height: ScreenAdaper.height(14),),
                Text('高手进阶', style: text,)
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
  final onChanged;
  final List<BookCollegeList> bookCollegeLists;
  final List<BookLsRoomList> bookLsRoomLists;
  _Trailer({this.isCircles : false, @required this.onChanged, this.bookCollegeLists, this.bookLsRoomLists});

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
                _circular('images/home_image${!isCircles?'09':'34'}.png', '直播预告', !isCircles),
                _circular('images/home_image${isCircles?'10':'35'}.png', '课程预告', isCircles),
                // isCircles ?_circles('images/home_image09.png') : _circular('images/home_image09.png', '直播预告'),
                // !isCircles ?_circles('images/home_image10.png') : _circular('images/home_image10.png', '课程预告'),
              ],
            ),
          ),
          // 列表
          Container(
            width: double.infinity, height: ScreenAdaper.height(360), 
            margin: EdgeInsets.only(top: ScreenAdaper.height(29)),
            child: _list(isCircles),
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
  Widget _circular(img, text, isCircles){
    return InkWell(
      onTap: (){
        onChanged();
      },
      child: Container(
        width: ScreenAdaper.width(186), height: ScreenAdaper.width(64), margin: EdgeInsets.only(right: ScreenAdaper.width(20)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Color(isCircles ? 0xffFFFFFF : 0xffF8F8F8),
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 0), blurRadius: 5),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(img, width: ScreenAdaper.width(26), height: ScreenAdaper.width(26),),
            SizedBox(width: ScreenAdaper.width(12),),
            Text(text, style: TextStyle(fontSize: ScreenAdaper.size(28), color: Color(isCircles ? 0xff000000 : 0xffA2A2A2), fontWeight: isCircles ? FontWeight.bold : FontWeight.w400),)
          ],
        ),
      ),
    );
  }

  // 列表
  Widget _list(_isCircles){
    return ListView.builder(
      scrollDirection: Axis.horizontal, padding: EdgeInsetsDirectional.fromSTEB(0, ScreenAdaper.height(5), 0, ScreenAdaper.height(5)),
      itemCount: !_isCircles ? bookLsRoomLists.length :bookCollegeLists.length,
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
                  child: Image.network('${!_isCircles ? bookLsRoomLists[index].img : bookCollegeLists[index].smallImageUrl}', fit: BoxFit.fill,),
                ),
              ),
              Container(
                width: double.infinity, margin: EdgeInsets.only(top: ScreenAdaper.height(10)),
                padding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(21), 0, ScreenAdaper.width(21), 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${!_isCircles ? bookLsRoomLists[index].title :bookCollegeLists[index].title}', style: TextStyle(fontSize: ScreenAdaper.size(24), color: Color(0xff000000), 
                      fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                    Text('— ${!_isCircles ? bookLsRoomLists[index].teacherName :bookCollegeLists[index].teacherName}', style: TextStyle(fontSize: ScreenAdaper.size(20), color: Color(0xffA2A2A2)),),
                    SizedBox(height: ScreenAdaper.height(10),),
                    !isCircles ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('${bookLsRoomLists[index].bookCount}', style: TextStyle(fontSize: ScreenAdaper.size(20), color: Color(0xffFF8636)),),
                            Text('人已预约', style: TextStyle(fontSize: ScreenAdaper.size(20), color: Color(0xffA2A2A2)),),
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            if(!bookLsRoomLists[index].isBook){
                              myDialog(context, index);
                            }
                          },
                          child: Container(
                            width: ScreenAdaper.width(120), height: ScreenAdaper.width(40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30), color: Color(!bookLsRoomLists[index].isBook?0xffFF8636:0xffDDDDDD),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('images/home_image22.png', width: ScreenAdaper.width(26), height: ScreenAdaper.width(26),),
                                SizedBox(width: ScreenAdaper.width(12),),
                                Text(!bookLsRoomLists[index].isBook?'预约':'已预约', style: TextStyle(fontSize: ScreenAdaper.size(22), color: Color(0xffFFFFFF), fontWeight: FontWeight.bold),),                              
                              ],
                            ),
                          ),
                        )
                      ],
                    ) : Text(' ')
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // 弹窗
  Future myDialog(context, index){
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
          return GestureDetector(							// 手势处理事件
            onTap: (){
              // Navigator.of(context).pop();				//退出弹出框
            },
            child: Container(								//弹出框的具体事件
              child: Material(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                child: Center(
                  child: Container( 
                    width: ScreenAdaper.width(509), height: ScreenAdaper.height(700), 
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity, height: ScreenAdaper.height(576), 
                          decoration: BoxDecoration(
                            color: Color(0xffFFFFFF), borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: <Widget>[
                              Image.asset('images/close_image31.png', width: ScreenAdaper.width(509),),
                              SizedBox(height: ScreenAdaper.height(50),),
                              Text('“${bookLsRoomLists[index].title}”直播课程', style: TextStyle(
                                color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.bold
                              ),),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: '将于', style: TextStyle(
                                      color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.bold
                                    ),),
                                    TextSpan(text: '${bookLsRoomLists[index].onlineTime}', style: TextStyle(
                                      color: Color(0xffFF8636), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.bold
                                    ),),
                                    TextSpan(text: '开始', style: TextStyle(
                                      color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.bold
                                    ),),
                                  ]
                                )
                              ),
                              SizedBox(height: ScreenAdaper.height(50),),
                              RaisedButton(
                                onPressed: (){
                                  apiMethod('book', 'post', {'TargetType': 9, 'TargetId': bookLsRoomLists[index].id, 'Oper': 1}).then((res){
                                    if(res.data['IsSuccess']){
                                      toast('预约成功！');
                                    }else{
                                      toast(res.data['Message']);
                                    }
                                    Navigator.of(context).pop();				//退出弹出框
                                  });
                                },
                                child: Text('确定预约', style: TextStyle(fontSize: ScreenAdaper.size(25), color: Color(0xffFFFFFF)),),
                                color: Color(0xffFED34E), padding: EdgeInsets.only(left: ScreenAdaper.width(120), right: ScreenAdaper.width(120)),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 0,
                                  ),
                                  borderRadius: BorderRadius.circular(30)
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: ScreenAdaper.height(27),),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pop();				//退出弹出框
                          },
                          child: Image.asset('images/close_image30.png', width: ScreenAdaper.width(54), height: ScreenAdaper.width(54),),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          );
          
      },
    );
  }


}


// 今日热点
class _Hot extends StatelessWidget {
  final List<HotCollegeList> hotCollegeLists;
  _Hot({this.hotCollegeLists});

  List<Widget> _generateList() {
    return hotCollegeLists.map((item) => _hotList(item, hotCollegeLists.indexOf(item))).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, color: Color(0xffFFFFFF),
      padding: EdgeInsetsDirectional.fromSTEB(0, ScreenAdaper.height(35), 0, ScreenAdaper.height(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: ScreenAdaper.width(30)),
            child: Text('今日热点', style: TextStyle(fontSize: ScreenAdaper.size(34), color: Color(0xff000000), fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: ScreenAdaper.height(30),),
          Container(
            width: double.infinity, 
            // color: Colors.red,
            child: Wrap(
              children: _generateList(),
              spacing: 1,
            )
          )
        ],
      ),
    );
  }


  Widget _hotList(item, index){
    if(index < 2){
      return ClassificationList(item: item);
    }else{
      return Container();
    }
  }
}


// 跨境攻略
class _Strategy extends StatelessWidget {
  final List<KJGLList> kJGLLists;
  _Strategy({this.kJGLLists});

  List<Widget> _generateList() {
    return kJGLLists.map((item) => _strategyList(item, kJGLLists.indexOf(item))).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, color: Color(0xffFFFFFF),
      padding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(30), ScreenAdaper.height(35), ScreenAdaper.width(30), 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity, height: ScreenAdaper.height(50),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('跨境攻略', style: TextStyle(fontSize: ScreenAdaper.size(34), color: Color(0xff000000), fontWeight: FontWeight.bold),),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/strategy');
                    },
                    child: Text('查看更多>', style: TextStyle(fontSize: ScreenAdaper.size(22), color: Color(0xffA2A2A2), fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: ScreenAdaper.height(10),),
          Container(
            width: double.infinity,
            child: Wrap(
              children: _generateList(),
              spacing: 1,
            ),
          )
        ],
      ),
    );
  }


  Widget _strategyList(item, index){
    return StrategyList(item: item, index: index);
  }
}



