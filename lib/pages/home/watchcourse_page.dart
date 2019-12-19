import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/rendering.dart';

import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '../../services/screenAdaper.dart';
import 'package:flutter_html_widget/flutter_html_widget.dart';
import '../widget/showCustomDialog.dart';

class WatchcoursePage extends StatefulWidget {
 var arguments;
 WatchcoursePage({this.arguments});

  @override
  _WatchcoursePageState createState() => _WatchcoursePageState();
}

class _WatchcoursePageState extends State<WatchcoursePage> with SingleTickerProviderStateMixin {

  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  TabController controller;
  var tabs = [];

  List _tab = [{'title':'简介', 'id': ''}, {'title': '目录', 'id': '42'}, {'title':'评价', 'id': '43'}];
  int _tabIndex = 0;

  var _inputValue = '';

  get key => null;

  @override
  void initState() {
    super.initState();
    //配置视频地址
    videoPlayerController = VideoPlayerController.network('https://proseer.cn/cfcefcf3b99f477eb534243599302f91/b6e0131180844b49ba56d2e5462d1d67-ea6e1fe785f4a954f0832eda12986e5c-sd.mp4');
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 75 / 44, //宽高比
      autoPlay: true, //自动播放
      looping: true, //循环播放
      autoInitialize: true,
    );

    //initialIndex初始选中第几个
    controller = TabController(initialIndex: 0, length: _tab.length, vsync: this);
    controller.addListener(() => _onTabChanged());
  }

  _onTabChanged(){
    
  }


  GlobalKey rootWidgetKey = GlobalKey();
 
  List<Uint8List> images = List();
 
  _capturePng() async {
    try {
      RenderRepaintBoundary boundary =
          rootWidgetKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      print(pngBytes);
      setState(() {
        images.add(pngBytes);
      });
      return pngBytes;
    } catch (e) {
      print(e);
    }
    return null;
  }


  

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: rootWidgetKey,
      child: Scaffold(
        body: DefaultTabController(
          length: _tab.length,
          child: Stack(
            children: <Widget>[
              Container(
                color: Color(0xffFFFFFF),
                child: ListView(
                  padding: EdgeInsets.all(0),
                  children: <Widget>[
                    // Center(
                    //   //视频播放器
                    //   child: Chewie(
                    //     controller: chewieController,
                    //   ),
                    // ),
                    Container(
                      padding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(30), ScreenAdaper.height(20), ScreenAdaper.width(30), ScreenAdaper.height(20)), 
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Allan老师教你如何用Google开发新客户', style: TextStyle(color: Color(0xfff000000), fontSize: ScreenAdaper.size(32), fontWeight: FontWeight.bold),
                            maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: ScreenAdaper.height(8),),
                          Text('讲师：徐子善&李勤', style: TextStyle(color: Color(0xfff000000), fontSize: ScreenAdaper.size(22)),),
                          SizedBox(height: ScreenAdaper.height(20),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  SizedBox(height: ScreenAdaper.height(10),),
                                  Text('1.8w观看•1.4k评论•5k转发', style: TextStyle(color: Color(0xfffA2A2A2), fontSize: ScreenAdaper.size(22)),),
                                ],
                              ),
                              Stack(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Image.asset('images/home_image38.png', width: ScreenAdaper.width(44), height: ScreenAdaper.height(44),),
                                      SizedBox(width: ScreenAdaper.width(50),),
                                      Image.asset('images/home_image37.png', width: ScreenAdaper.width(44), height: ScreenAdaper.height(44),),
                                      SizedBox(width: ScreenAdaper.width(50),),
                                      // 分享
                                      InkWell(
                                        onTap: (){
                                          _share(context);
                                        },
                                        child: Image.asset('images/home_image36.png', width: ScreenAdaper.width(44), height: ScreenAdaper.height(44),),
                                      )
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 0, right: ScreenAdaper.width(86),
                                    child: Image.asset('images/home_image41.png', width: ScreenAdaper.width(20), height: ScreenAdaper.height(20),),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: ScreenAdaper.height(40),),
                          Divider(height: ScreenAdaper.height(1),),
                          SizedBox(height: ScreenAdaper.height(35),),
                          Container(
                            width: double.infinity, 
                            child: TabBar(
                              tabs: this._tab.map((item){
                                return Container(
                                  height: ScreenAdaper.height(40),
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        width: ScreenAdaper.width(85), height: ScreenAdaper.height(10), color: Color(_tab.indexOf(item) == _tabIndex ? 0xffFF8636 : 0xffFFFFFF),
                                        margin: EdgeInsets.only(top: ScreenAdaper.height(30)),
                                      ),
                                      Positioned(
                                        bottom: ScreenAdaper.height(_tab.indexOf(item) == _tabIndex ?-3:0), left: 0, 
                                        child: Container(
                                          width: ScreenAdaper.width(85),
                                          child: Text('${item['title']}', style: TextStyle(
                                            color: Color(_tab.indexOf(item) == _tabIndex ? 0xff000000 : 0xff7E7E7E) , fontSize: ScreenAdaper.size(_tab.indexOf(item) == _tabIndex ? 32 : 28), 
                                              fontWeight: _tab.indexOf(item) == _tabIndex ? FontWeight.bold : FontWeight.w400), 
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                              controller: controller,
                              labelStyle: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(32), fontWeight: FontWeight.bold),
                              unselectedLabelStyle: TextStyle(color: Color(0xff7E7E7E), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.w400),
                              indicatorColor: Color(0xffFFFFFF),
                              // isScrollable: true,
                              onTap: (i){
                                setState(() {
                                  _tabIndex = i;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    _tabIndex == 0 ? _introduction() : _tabIndex == 1 ? _directory() : _evaluation(),
                    
                  ],
                ),
              ),
              
              // 输入框
              _input()
            ],
          ),
        ),
      ),
    );
  }


  // 分享
  Future _share(context){
    return showCustomDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
            Center(
              child: GestureDetector(							// 手势处理事件
                onTap: (){
                  // Navigator.of(context).pop();				//退出弹出框
                  print('object');
                },
                child: Container(
                  width: ScreenAdaper.width(580),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: ScreenAdaper.height(210),),
                      Container(
                        width: ScreenAdaper.width(580), height: ScreenAdaper.height(284),
                        child: Image.network('https://zcxy.oss-cn-beijing.aliyuncs.com/college/385feab035b14745a6bc0ae342dd533b', fit: BoxFit.fill,)
                      ),
                      Container(
                        width: ScreenAdaper.width(580), color: Color(0xffFFFFFF),
                        padding: EdgeInsets.symmetric(vertical: ScreenAdaper.width(35), horizontal: ScreenAdaper.width(35)),
                        child: Column(
                          children: <Widget>[
                            Text('掌握不被市场淘汰的基本能力：年轻一代的成长指南，未来人才必备6中能力', 
                              style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(27), decoration: TextDecoration.none), maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: ScreenAdaper.height(30),),
                            Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      width: ScreenAdaper.width(153), height: ScreenAdaper.width(153),
                                      child: Image.network('https://zcxy.oss-cn-beijing.aliyuncs.com/college/385feab035b14745a6bc0ae342dd533b', fit: BoxFit.fill,)
                                    ),
                                    Text('扫码跟我一起学跨境',style: TextStyle(color: Color(0xffABABAB), fontSize: ScreenAdaper.size(14.37), decoration: TextDecoration.none)),
                                  ],
                                ),
                                SizedBox(width: ScreenAdaper.width(31),),
                                Row(
                                  children: <Widget>[
                                    Align(
                                      child: ClipOval(
                                        child: SizedBox(
                                          width: ScreenAdaper.width(52), height: ScreenAdaper.width(52),
                                          child: Image.network("http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg", fit: BoxFit.fill,),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: ScreenAdaper.width(13),),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('爱学习的小杨', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(18), decoration: TextDecoration.none)),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: '邀请您免费学习', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(18), decoration: TextDecoration.none)),
                                              TextSpan(text: '跟我跨境精品课', style: TextStyle(color: Color(0xffEF8C4A), fontSize: ScreenAdaper.size(18), decoration: TextDecoration.none)),
                                            ]
                                          )
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0, left: 0,
              child: GestureDetector(
                child: Container(
                  width: ScreenAdaper.width(750), height: ScreenAdaper.height(323), color: Color(0xffFFFFFF),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: ScreenAdaper.height(50),),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 1, decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xffFFFFFF), Color(0xffFFFFFF), Color.fromRGBO(0, 0, 0, 0.05),]
                                )
                              ),
                            ),
                          ),
                          Text('邀请好友学习，即可获得50牛币', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold, decoration: TextDecoration.none)),
                          Expanded(
                            child: Container(
                              height: 1, decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color.fromRGBO(0, 0, 0, 0.05), Color(0xffFFFFFF), Color(0xffFFFFFF)]
                                )
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenAdaper.height(50),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Image.asset('images/home_image49.png', width: ScreenAdaper.width(80),),
                              SizedBox(height: ScreenAdaper.height(18),),
                              Text('保存海报', style: TextStyle(color: Color(0xff5F5F5F), fontSize: ScreenAdaper.size(24), decoration: TextDecoration.none)),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Image.asset('images/home_image50.png', width: ScreenAdaper.width(80),),
                              SizedBox(height: ScreenAdaper.height(18),),
                              Text('微信', style: TextStyle(color: Color(0xff5F5F5F), fontSize: ScreenAdaper.size(24), decoration: TextDecoration.none)),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Image.asset('images/home_image51.png', width: ScreenAdaper.width(80),),
                              SizedBox(height: ScreenAdaper.height(18),),
                              Text('朋友圈', style: TextStyle(color: Color(0xff5F5F5F), fontSize: ScreenAdaper.size(24), decoration: TextDecoration.none)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }
    );
  }


  // 简介
  Widget _introduction(){
    var html = """
      <section class="homepage__key_points card">
        <h1 class="homepage__title">
          Build beautiful native apps in record time
        </h1>

        <div class="homepage__tagline">
          Flutter is Google’s mobile app SDK for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.
        </div>
      </section>
    """;
    return Container(
      child: Column(
        children: <Widget>[
          HtmlWidget(html: html, key: key),
          Container(
            height: ScreenAdaper.height(500),
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return Image.memory(
                    images[index],
                    fit: BoxFit.cover,
                  );
                },
                itemCount: images.length,
                scrollDirection: Axis.horizontal,
              ),
          )

        ],
      ),
    );
  }

  // 目录
  Widget _directory(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(30)), 
      margin: EdgeInsets.only(bottom: ScreenAdaper.height(49)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('第一节：', style: TextStyle(color: Color(0xffA2A2A2), fontSize: ScreenAdaper.size(28)),),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('业务能力-光速询盘转化秘籍', style: TextStyle(color: Color(0xffA2A2A2), fontSize: ScreenAdaper.size(28)), maxLines: 2, overflow: TextOverflow.ellipsis,),
                SizedBox(height: ScreenAdaper.height(12),),
                Row(
                  children: <Widget>[
                    Text('3:30', style: TextStyle(color: Color(0xffA2A2A2), fontSize: ScreenAdaper.size(20.34)),),
                    SizedBox(width: ScreenAdaper.width(23),),
                    Container(
                      width: ScreenAdaper.width(62), height: ScreenAdaper.height(30),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1, color: Color(0xffF18D41)
                        ),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(child: Text('试看', style: TextStyle(color: Color(0xffF18D41), fontSize: ScreenAdaper.size(16.64)),),),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(width: ScreenAdaper.width(50),),
          Container(
            padding: EdgeInsets.only(top: ScreenAdaper.height(4)),
            child: Image.asset('images/home_image43.png', width: ScreenAdaper.width(38), height: ScreenAdaper.width(38),),
          )
        ],
      ),
    );
  }

  // 评价
  Widget _evaluation(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(32)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('全部评论（120）', style: TextStyle(color: Color(0xfff000000), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.bold),),
          SizedBox(height: ScreenAdaper.height(34),),
          Container(
            width: double.infinity, margin: EdgeInsets.only(bottom: ScreenAdaper.height(25)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: ScreenAdaper.width(4),),
                Align(
                  child: ClipOval(
                    child: SizedBox(
                      width: ScreenAdaper.width(70), height: ScreenAdaper.width(70),
                      child: Image.network(
                        "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg",
                        fit: BoxFit.fill,),
                    ),
                  ),
                ),
                SizedBox(width: ScreenAdaper.width(10),),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('勤劳小蜜蜂', style: TextStyle(color: Color(0xfff000000), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('images/home_image46.png', width: ScreenAdaper.width(20), height: ScreenAdaper.width(20),),
                          Image.asset('images/home_image46.png', width: ScreenAdaper.width(20), height: ScreenAdaper.width(20),),
                          Image.asset('images/home_image46.png', width: ScreenAdaper.width(20), height: ScreenAdaper.width(20),),
                          Image.asset('images/home_image46.png', width: ScreenAdaper.width(20), height: ScreenAdaper.width(20),),
                          Image.asset('images/home_image46.png', width: ScreenAdaper.width(20), height: ScreenAdaper.width(20),),
                          SizedBox(width: ScreenAdaper.width(9),),
                          Text('4.5', style: TextStyle(color: Color(0xfffA2A2A2), fontSize: ScreenAdaper.size(24)),),
                        ],
                      ),
                      SizedBox(height: ScreenAdaper.height(8),),
                      Text('创新永无止境，创意无边界。在云大物移广泛用用用消费者异常挑剔的时代，这个课很棒！', style: TextStyle(color: Color(0xfff000000), fontSize: ScreenAdaper.size(26)),),
                      Container(
                        width: double.infinity, 
                        padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(28), vertical: ScreenAdaper.height(20)),
                        margin: EdgeInsets.only(top: ScreenAdaper.height(15)),
                        decoration: BoxDecoration(
                          color: Color(0xffF8F8F8), borderRadius: BorderRadius.circular(3)
                        ),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: '李勤：', style: TextStyle(color: Color(0xfff000000), fontSize: ScreenAdaper.size(22)),),
                              TextSpan(text: '非常棒，看了两遍，受益匪浅，下载了之留着以后再看，记得分享。', style: TextStyle(color: Color(0xfff808080), fontSize: ScreenAdaper.size(26)),),
                            ]
                          )
                        ),
                      ),
                      SizedBox(height: ScreenAdaper.height(30),),
                      Text('2019-09-09 18:30:00', style: TextStyle(color: Color(0xfff808080), fontSize: ScreenAdaper.size(22)),),
                      SizedBox(height: ScreenAdaper.height(32),),
                      Divider(height: 1,)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // 输入框
  Widget _input(){
    return Positioned(
      bottom: 0, left: 0,
      child: Container(
        width: ScreenAdaper.width(750), height: ScreenAdaper.height(98), padding: EdgeInsets.only(left: ScreenAdaper.width(30), right: ScreenAdaper.width(38)),
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          border: Border(top: BorderSide(width: 1, color: Color(0xffEFEFEF)))
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity, height: ScreenAdaper.height(70),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Color(0xffF8F8F8)
                ),
                child: TextField(
                  onTap: (){
                    setState(() {
                      
                    });
                  },
                  onChanged: (value){
                    setState(() {
                      _inputValue = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: '写下你的评论，与作者互动',
                    contentPadding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(41), 0, 0, ScreenAdaper.height(23)),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: ScreenAdaper.width(24),),
            InkWell(
              onTap: (){
                this._capturePng();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.5)
                ),
                child: Image.asset('images/home_image48.png', width: ScreenAdaper.width(56), height: ScreenAdaper.width(56),),
              ),
            )
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    /**
     * 当页面销毁的时候，将视频播放器也销毁
     * 否则，当页面销毁后会继续播放视频！
     */
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

}