import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/rendering.dart';

import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import 'package:flutter_html_widget/flutter_html_widget.dart';
import '../widget/showCustomDialog.dart';
import '../../config/service_method.dart';
import '../../model/live_model.dart';
import '../widget/loading.dart';
import '../../model/evaluationList_model.dart';
import '../widget/toast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import '../../services/storage.dart';

import '../../pages/widget/dialog.dart';

import 'package:provider/provider.dart';
import '../../provider/courseDetails.dart';

// import 'package:fluwx/fluwx.dart' as fluwx;
import '../../services/ct_room_client.dart';

class LivecoursePage extends StatefulWidget {
 var arguments;
 LivecoursePage({this.arguments});

  @override
  _LivecoursePageState createState() => _LivecoursePageState();
}

class _LivecoursePageState extends State<LivecoursePage> with SingleTickerProviderStateMixin {

  // tab
  TabController controller;
  var tabs = [];
  List _tab = [{'title':'简介', 'id': ''}, {'title':'互动', 'id': '43'}];
  int _tabIndex = 0;

  // 评论
  var _inputValue = '';

  // 课程信息
  LiveModel _livestreamingdetail;

  // 视频连接
  String videoUrl = '';

  // 目录索引
  int _directoryIndex = 0;

  // 评价列表
  List<EvaluationListDataModel> _evaluationList = [];

  //用于上拉分页 listview 的控制器
  ScrollController _scrollController = ScrollController();

  // 聊天室
  var _getchatroomList = [];

  String token = '';

  get key => null;

  @override
  void initState() {
    super.initState();
    //initialIndex初始选中第几个
    controller = TabController(initialIndex: 0, length: _tab.length, vsync: this);
    controller.addListener(() => _onTabChanged());

    print(widget.arguments['collegeId']);
    apiMethod('livestreamingdetail', 'get', '/${widget.arguments['collegeId']}').then((res){
      // print(res.data);
      var list = LiveModel.fromJson(res.data);
      if(res.data['IsSuccess']){
        setState(() {
          _livestreamingdetail = list;
          videoUrl = list.data.playUrl;
        });
        initPlayer(list.data.playUrl);
      }else{
        toast(res.data['Message']);
      }  
    });

    //监听滚动条滚动事件
    _scrollController.addListener(() {
      //_scrollController.position.pixels //获取滚动条滚动的高度
      //_scrollController.position.maxScrollExtent  //获取页面高度
      if (_tabIndex == 1) {
        // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        //  _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        //     duration: new Duration(seconds: 2), curve: Curves.ease);
      }
    });

    getLogo();

  }

  _onTabChanged(){
    
  }

  var logoUrl;
  var userName;
  void getLogo() async {
    var userinfo = await Storage.getString('userinfo');
    setState(() {
      token = json.decode(userinfo)['Token'];
      logoUrl = json.decode(userinfo)['LogoUrl'];
      userName = json.decode(userinfo)['UserName'];
    });
  }

  CtRoomService ctRoomService;
  getCtRoomService() {
    var action = (CtRoomService data) {
      ctRoomService = data;
      data.msgStream.listen((msg){
        print(msg.name + ":" + msg.msg);
        setState(() {
          _getchatroomList.add({'Content': msg.msg, "IsSelf": false, 'logoUrl': msg.logoUrl, 'UserName': msg.name});
        });
         _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: new Duration(seconds: 2), curve: Curves.ease);
      }); // 接收消息
    };
    
    //初始化聊天室
    CtRoomService.invoke(action, token: token, ctRoomId: _livestreamingdetail.data.ctRoomGroupId);

  }

  // 发送消息
  TextEditingController _textController = new TextEditingController();
  FocusNode _commentFocus = FocusNode();
  void sendM(){
    ctRoomService.send(_inputValue);
    print(userName);
    setState(() {
      _getchatroomList.add({'Content': _inputValue, "IsSelf": true, 'logoUrl': logoUrl, 'UserName': userName});
    });
    _textController.clear();
    _commentFocus.unfocus();    // 失去焦点
    // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
     _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: new Duration(seconds: 2), curve: Curves.ease);
  }


  int pageIndex = 1;
  //解决重复请求的问题
  bool flag = true;
  //是否有数据
  bool _hasMore = true;
  // 评价列表
  void getEvaluation(){
    setState(() {
      this.flag = false;
    });
    // apiMethod('getevaluate', 'post', {'CollegeId': _livestreamingdetail.data.collegeId, 'PageIndex': pageIndex, 'PageSize': 10}).then((res){
    //   print(res.data);
    //   if(res.data['IsSuccess']){
    //     var list = EvaluationListModel.fromJson(res.data);
    //     if (_evaluationList.length < 10) {
    //       setState(() {
    //         this._hasMore = false;
    //       });
    //     }
    //     setState(() {
    //       pageIndex == 1? _evaluationList = list.data : _evaluationList.addAll(list.data);
    //       this.pageIndex++;
    //       this.flag = true;
    //     });
    //   }  
    // });
  }


  // 视频是否加载完成显示加载圈圈
  bool statusVideo = true;
  // 视频播放中
  bool playing = false;
  // 切换清晰度是的播放时间
  var duration = 0.0;
  // 是否是看结束
  bool isFreeEnd = false;
  Timer time;
  // 切换视频
  IjkMediaController controllerVideo = IjkMediaController();
  initPlayer(videoUrls) async{
    await controllerVideo.setNetworkDataSource('$videoUrls', autoPlay: true);
    
  }


  // 弹窗
  Future myDialog(context){
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
                          width: double.infinity, padding: EdgeInsets.only(bottom: ScreenAdaper.height(40)),
                          decoration: BoxDecoration(
                            color: Color(0xffFFFFFF), borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: <Widget>[
                              Image.asset('images/home_image64.png', width: ScreenAdaper.width(509),),
                              SizedBox(height: ScreenAdaper.height(30),),
                              Text('本课程试看部分已结束啦～', style: TextStyle(
                                color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.bold
                              ),),
                              Text('购买即可查看全部', style: TextStyle(
                                color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.bold
                              ),),
                              SizedBox(height: ScreenAdaper.height(50),),
                              RaisedButton(
                                onPressed: (){
                                  Navigator.of(context).pop();				//退出弹出框
                                  Navigator.pushNamed(context, '/pay');
                                },
                                child: Text('确定购买', style: TextStyle(fontSize: ScreenAdaper.size(25), color: Color(0xffFFFFFF)),),
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

  

  @override
  Widget build(BuildContext context) {
    // 添加状态
    var provider = Provider.of<CourseDetails>(context);
    return Scaffold(
      body: Container(
        color: Color(0xffFFFFFF),
        child: _livestreamingdetail !=null ? Stack(
          children: <Widget>[
            Container(
              // color: Colors.yellow,
              child: ListView(
                controller: _scrollController,
                padding: EdgeInsets.only(top: ScreenAdaper.height(840)),
                children: <Widget>[
                  _tabIndex == 0 ? _introduction() : _evaluation()
                ],
              ),
            ),
            Positioned(
              top: 0, left: 0,
              child: Container(
                color: Color(0xffFFFFFF),
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.black, padding: EdgeInsets.only(top: ScreenAdaper.getStatusBarHeight()),
                      //视频播放器
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: ScreenAdaper.width(750),
                            child: AspectRatio(
                              aspectRatio: 75/44,
                              // 如果有地址就显示播放器
                              child: videoUrl !='' ? IjkPlayer(
                                mediaController: controllerVideo,    
                              ) : Image.network('${_livestreamingdetail.data.img}', fit: BoxFit.fill,), // 视频封面
                            ),
                          ),
                          Positioned(
                            top: ScreenAdaper.width(36), left: ScreenAdaper.width(20),
                            child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: ClipOval(
                                child: Container(
                                  width: ScreenAdaper.width(52), height: ScreenAdaper.width(52), color: Color.fromRGBO(0, 0, 0, 0.3),
                                  child: Center(
                                    child: Image.asset('images/home_image28.png', width: ScreenAdaper.width(13), height: ScreenAdaper.height(25),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          _livestreamingdetail.data.status == 2 && _livestreamingdetail.data.isOnline==0 ? Positioned(
                            top: 0, left: 0,
                            child: Container(
                              width: ScreenAdaper.width(750),
                              child: AspectRatio(
                                aspectRatio: 75/44,
                                child: Center(
                                  child: Container(
                                    width: ScreenAdaper.width(550), height: ScreenAdaper.height(88), 
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 0.3), borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Center(
                                      child: Text('该直播于${_livestreamingdetail.data.onlineTime}开始', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(32)),),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ):Container(),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(30), ScreenAdaper.height(20), ScreenAdaper.width(30), 0), 
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${_livestreamingdetail.data.title}', style: TextStyle(color: Color(0xfff000000), fontSize: ScreenAdaper.size(32), fontWeight: FontWeight.bold),
                            maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: ScreenAdaper.height(8),),
                          Text('讲师：${_livestreamingdetail.data.teacherName}', style: TextStyle(color: Color(0xfff000000), fontSize: ScreenAdaper.size(22)),),
                          SizedBox(height: ScreenAdaper.height(20),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  SizedBox(height: ScreenAdaper.height(10),),
                                  Text('${_livestreamingdetail.data.bookCount}已预约', style: TextStyle(color: Color(0xfffA2A2A2), fontSize: ScreenAdaper.size(22)),),
                                ],
                              ),
                              Stack(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      // 分享
                                      // InkWell(
                                      //   onTap: (){
                                      //     _share(context);
                                      //   },
                                      //   child: Image.asset('images/home_image36.png', width: ScreenAdaper.width(44), height: ScreenAdaper.height(44),),
                                      // )
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
                          Container(
                            width: ScreenAdaper.width(690), height: ScreenAdaper.height(1),color: Color(0xffEFEFEF),
                          ),
                        ],
                      ),
                    ),
                    
                    DefaultTabController(
                      length: this._tab.length,
                      child: Container(
                        width: ScreenAdaper.width(750), 
                        // color: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: ScreenAdaper.height(25)),
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
                              if(i == 1) getCtRoomService();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 评价输入框
            _tabIndex == 1 ? _input() : Container(),
          ],
        ) : Loading(),
        
      ),
    );
  }


  // 简介
  Widget _introduction(){
    var html = '${_livestreamingdetail.data.introduction.replaceAll('\"', '"').replaceAll('https://', '//')}';
    return Container(
      child: Column(
        children: <Widget>[
          HtmlWidget(html: html, key: key)
        ],
      ),
    );
  }

  // 资料
  Widget _directory(){
    return Wrap(
      children: this._livestreamingdetail.data.lsRoomDataList.map((item){
        var index = this._livestreamingdetail.data.lsRoomDataList.indexOf(item);
        var colors = _directoryIndex==index ? 0xffFF8636 : 0xffA2A2A2;
        
        return InkWell(
          onTap: (){
            setState(() {
              
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(30)), 
            margin: EdgeInsets.only(bottom: ScreenAdaper.height(16)),
            child: Container(
              width: double.infinity, height: ScreenAdaper.height(99),
              padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(30)),
              decoration: BoxDecoration(
                color: Color(0xffEFEFEF), borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/home_image7${item.type}.png', width: ScreenAdaper.width(57),),
                  SizedBox(width: ScreenAdaper.width(16),),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('${item.fileName}', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(24)),),
                        Text('${item.size}', style: TextStyle(color: Color(0xffA2A2A2), fontSize: ScreenAdaper.size(20)),),
                      ],
                    ),
                  ),
                  SizedBox(width: ScreenAdaper.width(16),),
                  // Text('下载', style: TextStyle(color: Color(0xffA2A2A2), fontSize: ScreenAdaper.size(22)),),
                  Image.asset('images/home_image44.png', width: ScreenAdaper.width(30),),
                ],
              ),
            )
          ),
        );
      }).toList()
    );
  }

  // 评价
  Widget _evaluation(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(ScreenAdaper.width(30), ScreenAdaper.height(20), ScreenAdaper.width(30), ScreenAdaper.height(98)),
      child: this._getchatroomList !=null ?Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 0),
            itemCount: _getchatroomList.length,
            itemBuilder: (context, index){
              var item = _getchatroomList[index];
              return Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: ScreenAdaper.height(10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: item['IsSelf'] ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: <Widget>[
                    !item['IsSelf']? ClipOval(
                      child: SizedBox(
                        width: ScreenAdaper.width(48),
                        child: Image.network('${item['logoUrl']}', fit: BoxFit.fill,),
                      ),
                    ) : Container(),
                    SizedBox(width: ScreenAdaper.width(item['IsSelf']?0:15),),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: item['IsSelf'] ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${item['UserName']}', style: TextStyle(color: Color(0xff808080), fontSize: ScreenAdaper.size(26)),),
                          SizedBox(height: ScreenAdaper.height(5),),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(27), vertical: ScreenAdaper.height(20)),
                            decoration: BoxDecoration(
                              color: Color(item['IsSelf']?0xffFF8636 :0xffF8F8F8), borderRadius: BorderRadius.circular(4)
                            ),
                            child: Text('${item['Content']}', style: TextStyle(color: Color(item['IsSelf']?0xffFFFFFF :0xff000000), fontSize: ScreenAdaper.size(26)),),
                          )
                        ],
                      )
                    ),
                    SizedBox(width: ScreenAdaper.width(item['IsSelf']?15:0),),
                    item['IsSelf'] && logoUrl != null ? ClipOval(
                      child: SizedBox(
                        width: ScreenAdaper.width(48),
                        child: Image.network('${item['logoUrl']}', fit: BoxFit.fill,),
                      ),
                    ) : Container(),
                  ],
                )
              );
            },
          )
        ],
      ) : Loading(),
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
                  controller: _textController,
                  focusNode: _commentFocus,
                  onTap: (){
                    
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
              onTap: sendM,
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
    controllerVideo.dispose();

    if(ctRoomService!=null) ctRoomService.close(); // 关闭聊天室

    //为了满足全屏时候 控制器不被直接销毁 判断只有不是全屏的时候 才允许控制器被销毁
    // if (chewieController != null && !chewieController.isFullScreen) {
    //   videoPlayerController.dispose();
    //   chewieController.dispose();
    //   print('控制器销毁');
    // }
    super.dispose();
  }

}



class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}