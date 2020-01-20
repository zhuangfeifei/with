import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/rendering.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/screenAdaper.dart';
import 'package:flutter_html_widget/flutter_html_widget.dart';
import '../widget/showCustomDialog.dart';
import '../../config/service_method.dart';
import '../../model/watchcourse_model.dart';
import '../widget/loading.dart';
import '../../model/evaluationList_model.dart';
import '../widget/toast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import '../../services/storage.dart';

import '../../pages/widget/dialog.dart';

import 'package:provider/provider.dart';
import '../../provider/courseDetails.dart';
import '../../services/convertNum.dart';

import 'package:fluwx/fluwx.dart' as fluwx;


import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

class WatchcoursePage extends StatefulWidget {
 var arguments;
 WatchcoursePage({this.arguments});

  @override
  _WatchcoursePageState createState() => _WatchcoursePageState();
}

class _WatchcoursePageState extends State<WatchcoursePage> with SingleTickerProviderStateMixin {

  // tab
  TabController controller;
  var tabs = [];
  List _tab = [{'title':'简介', 'id': ''}, {'title': '目录', 'id': '42'}, {'title':'评价', 'id': '43'}];
  int _tabIndex = 0;

  // 评论
  var _inputValue = '';

  // 课程信息
  WatchcourseModel _course;

  // 视频连接
  String videoUrl = '';

  // 是否收藏
  bool isCollect = false;

  // 目录索引
  int _directoryIndex = 0;

  // 评价列表
  List<EvaluationListDataModel> _evaluationList = [];

  //用于上拉分页 listview 的控制器
  ScrollController _scrollController = ScrollController();

  get key => null;

  @override
  void initState() {
    super.initState();
    //initialIndex初始选中第几个
    controller = TabController(initialIndex: 0, length: _tab.length, vsync: this);
    controller.addListener(() => _onTabChanged());

    print(widget.arguments['collegeId']);
    apiMethod('collegedetailforapp', 'get', '/${widget.arguments['collegeId']}').then((res){
      print(res.data);
      var list = WatchcourseModel.fromJson(res.data);
      if(res.data['IsSuccess']){
        setState(() {
          _course = list;
          isCollect = list.data.isCollect;
        });
      }else{
        toast(res.data['Message']);
      }  
    });

    //监听滚动条滚动事件
    _scrollController.addListener(() {
      //_scrollController.position.pixels //获取滚动条滚动的高度
      //_scrollController.position.maxScrollExtent  //获取页面高度
      if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 20 && _tabIndex == 2) {
        if (this.flag && this._hasMore) {
          getEvaluation();
        }
      }
    });


    fluwx.responseFromShare.listen((response){
      print(response);
    });

    
  }

  _onTabChanged(){
    
  }

  
  // 分享的海报
  var shareImg = '';
  // 是否是好友
  bool isGoodFriends;
  // 截图
  GlobalKey rootWidgetKey = GlobalKey();
  Uint8List images;
  _capturePng() async {
    ProgressDialog.showProgress(context);
    try {
      RenderRepaintBoundary boundary = rootWidgetKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      print(pngBytes);
      setState(() {
        images = pngBytes;
      });

      // 获取权限
      if(isGoodFriends == null){
        getPermission();
      }else{
        getShareImg();
      }
      
      return pngBytes;
    } catch (e) {
      print(e);
    }
    return null;
  }
  
  // 分享微信好友
  // 上传图片给后台生成网络图片
  void getShareImg(){
    apiMethod('uploadfile', 'post', {'FileBytes': images}).then((res){
      ProgressDialog.dismiss(context);
      print(res.data);
      if(res.data['IsSuccess']){
        setState(() {
          shareImg = res.data['Data'];
          shares();
        });
      }else{
        toast(res.data['Message']);
      }  
    });
  }
  void shares(){
    print('==============================${shareImg}');
    fluwx.share(fluwx.WeChatShareImageModel(
      image: shareImg,
      thumbnail: '',
      transaction: shareImg,
      scene: isGoodFriends ? fluwx.WeChatScene.SESSION : fluwx.WeChatScene.TIMELINE,
      description: "image")
    );
  }

  // 获取权限
  void getPermission(){
    var permission =  PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    print("permission status is " + permission.toString());
    PermissionHandler().requestPermissions(<PermissionGroup>[
      PermissionGroup.storage, // 在这里添加需要的权限
    ]);
    permission.then((res){
      if(res.toString() == 'PermissionStatus.granted'){
        _savePosters();
      }
    });
  }
  // 是否保存过
  bool isSavePosters = false;
  // 保存海报
  void _savePosters() async{
    final result = await ImageGallerySaver.saveImage(images); //这个是核心的保存图片的插件
    print(result);   //这个返回值 在保存成功后会返回true
    ProgressDialog.dismiss(context);
    setState(() {
      isSavePosters = true;
      if(result != ''){
        toast('保存成功！');
      }else{
        toast('保存失败！');
      }
    });
  }


  // 收藏
  void _collect(data){
    setState(() {
      isCollect = !isCollect;
    });
    apiMethod('collect', 'post', {'TargetType': 3, 'TargetId': data.id, 'Oper': isCollect?1:0}).then((res){
      print(res.data);
      if(res.data['IsSuccess']){
        
      }  
    });
  }


  TextEditingController _textController = new TextEditingController();
  FocusNode _commentFocus = FocusNode();
  // 评价
  void _addvaluate(){
    ProgressDialog.showProgress(context);
    apiMethod('addvaluate', 'post', {'CollegeId': widget.arguments['collegeId'], 'Content': _inputValue, 'Score': 5, 'TargetId': ''}).then((res){
      ProgressDialog.dismiss(context);
      print(res.data);
      if(res.data['IsSuccess']){
        toast('评价成功！');
        setState(() {
          _inputValue = '';
          pageIndex = 1;
        });
        _textController.clear();
        _commentFocus.unfocus();    // 失去焦点
        getEvaluation();
      }else{
        toast(res.data['Message']);
      }  
    });
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
    apiMethod('getevaluate', 'post', {'CollegeId': _course.data.collegeId, 'PageIndex': pageIndex, 'PageSize': 10}).then((res){
      print(res.data);
      if(res.data['IsSuccess']){
        var list = EvaluationListModel.fromJson(res.data);
        if (_evaluationList.length < 10) {
          setState(() {
            this._hasMore = false;
          });
        }
        setState(() {
          pageIndex == 1? _evaluationList = list.data : _evaluationList.addAll(list.data);
          this.pageIndex++;
          this.flag = true;
        });
      }  
    });
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
  initPlayer() async{
    await controllerVideo.setNetworkDataSource('$videoUrl', autoPlay: true);
    // controllerVideo.setSpeed(2.0);
    // Stream<VideoInfo> videoInfoStream = controllerVideo.videoInfoStream;
    // videoInfoStream.listen((res){
    //   // print(res.isPlaying);
    // });
    // 包含了一些信息,是否在播放,视频宽,高,视频角度,当前播放进度,总长度等信息
    Stream<IjkStatus> ijkStatusStream = controllerVideo.ijkStatusStream;
    ijkStatusStream.listen((res){
      print(res);
      if(res==IjkStatus.noDatasource){
        controllerVideo.dispose();
      }else if(res==IjkStatus.disposed){
        controllerVideo.dispose();
      }else{
        setState(() {
          if(res==IjkStatus.preparing){
            statusVideo= true;
          }
          if(res==IjkStatus.prepared){
            time = Timer(Duration(milliseconds:1000), (){
              controllerVideo.seekTo(duration);
            });
          }
          // 播放中
          if(res==IjkStatus.playing){
            statusVideo= false;
            playing = true;
          }
          // 暂停
          if(res==IjkStatus.pause){
            playing = false;
          }
          // 播放结束
          if(res==IjkStatus.complete){
            playing = false;
            if(_course.data.collegeClass[_directoryIndex].isFree){
              myDialog(context);
              videoUrl = '';
              isFreeEnd = true;
            }
          }
        }); 
      }
    });
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


  List speed = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
  List clarity = ['标清480P', '高清720P', '超清1080P'];
  var speedIndex = 2;
  var clarityIndex = 0;
  bool isShowSpeed = false;
  bool isShowClarity = false;
  // 视频UI
  Widget _buildStatusWidget(BuildContext context, IjkMediaController controller, IjkStatus status,) {
    // 初始化
    if (statusVideo) {
      return SpinKitCircle(
        color: Colors.white,
        size: 50.0,
      );
    }
    // 播放中显示倍数和清晰度
    if (status == IjkStatus.playing) {
      return Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    setState(() {
                      isShowSpeed = true;
                      isShowClarity = false;
                    });
                  },
                  child: Container(
                    width: ScreenAdaper.width(80), height: ScreenAdaper.height(52),
                    margin: EdgeInsets.only(top: ScreenAdaper.height(66), right: ScreenAdaper.width(21)),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.3), borderRadius: BorderRadius.circular(26)
                    ),
                    child: Center(
                      child: Text('倍速', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(20)),),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      isShowClarity = true;
                      isShowSpeed = false;
                    });
                  },
                  child: Container(
                    width: ScreenAdaper.width(80), height: ScreenAdaper.height(52),
                    margin: EdgeInsets.only(top: ScreenAdaper.height(10)),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.3), borderRadius: BorderRadius.circular(26)
                    ),
                    child: Center(
                      child: Text('${this._course.data.collegeClass[_directoryIndex].videoUrlList[clarityIndex].typeName.substring(0,2)}', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(20)),),
                    ),
                  ),
                ),
              ],
            )
          ),
          isShowSpeed ? Positioned(
            top: 0, left: 0,
            child: Container(
              width: ScreenAdaper.width(750), color: Color.fromRGBO(0, 0, 0, 0.8),
              padding: EdgeInsets.only(left: ScreenAdaper.width(83), top: ScreenAdaper.height(165), right: ScreenAdaper.width(83)),
              child: AspectRatio(
                aspectRatio: 75/44,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('播放速度', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(24)),),
                    SizedBox(height: ScreenAdaper.height(25)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: this.speed.map((item){
                        var index = this.speed.indexOf(item);
                        return InkWell(
                          onTap: (){
                            setState(() {
                              isShowSpeed = false;
                              speedIndex = index;
                              controllerVideo.setSpeed(item);
                            });
                          },
                          child: Container(
                            width: ScreenAdaper.width(88), height: ScreenAdaper.width(88),
                            decoration: BoxDecoration(
                              color: speedIndex==index ? Color.fromRGBO(255, 134, 54, 0.3) : Color.fromRGBO(255, 255, 255, 0.3), borderRadius: BorderRadius.circular(7)
                            ),
                            child: Center(
                              child: Text('${item}X', style: TextStyle(color: Color(speedIndex==index?0xffFF8636:0xffFFFFFF), fontSize: ScreenAdaper.size(22), fontWeight: FontWeight.bold),),
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
          ) : Container(),
          isShowClarity ? Positioned(
            top: 0, left: 0,
            child: Container(
              width: ScreenAdaper.width(750), color: Color.fromRGBO(0, 0, 0, 0.8),
              padding: EdgeInsets.only(left: ScreenAdaper.width(83), top: ScreenAdaper.height(165), right: ScreenAdaper.width(83)),
              child: AspectRatio(
                aspectRatio: 75/44,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('清晰度选择', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(24)),),
                    SizedBox(height: ScreenAdaper.height(25)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: this._course.data.collegeClass[_directoryIndex].videoUrlList.map((item){
                        var index = this._course.data.collegeClass[_directoryIndex].videoUrlList.indexOf(item);
                        return InkWell(
                          onTap: ()async{
                            VideoInfo info = await controllerVideo.getVideoInfo();
                            print(info);
                            setState((){
                              videoUrl = _course.data.collegeClass[_directoryIndex].videoUrlList[index].url;
                              isShowClarity = false;
                              clarityIndex = index;
                              duration = info.currentPosition; 
                              initPlayer();
                            });
                          },
                          child: Container(
                            width: ScreenAdaper.width(160), height: ScreenAdaper.width(88),
                            decoration: BoxDecoration(
                              color: clarityIndex==index ? Color.fromRGBO(255, 134, 54, 0.3) : Color.fromRGBO(255, 255, 255, 0.3), borderRadius: BorderRadius.circular(7)
                            ),
                            child: Center(
                              child: Text('${item.typeName}', style: TextStyle(color: Color(clarityIndex==index?0xffFF8636:0xffFFFFFF), fontSize: ScreenAdaper.size(22), fontWeight: FontWeight.bold),),
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
          ) : Container(),
        ],
      );
    }

    // you can custom your self status widget
    return IjkStatusWidget.buildStatusWidget(context, controller, status);
  }
  

  @override
  Widget build(BuildContext context) {
    // 添加状态
    var provider = Provider.of<CourseDetails>(context);
    return Scaffold(
      body: Container(
        color: Color(0xffFFFFFF),
        child: _course!=null ? Stack(
          children: <Widget>[
            CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverToBoxAdapter(
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
                                  statusWidgetBuilder: _buildStatusWidget,     
                                ) : Image.network('${_course.data.smallImageUrl}', fit: BoxFit.fill,), // 视频封面
                              ),
                            ),
                            // 如果没有地址
                            videoUrl =='' && this._course.data.collegeClass.length > 0 ? Positioned(
                              top: 0, left: 0,
                              child: Container(
                                width: ScreenAdaper.width(750), color: Color.fromRGBO(0, 0, 0, 0.8),
                                child: AspectRatio(
                                  aspectRatio: 75/44,
                                  child: _course.data.orderSatus.orderStatus == 2 || _course.data.orderSatus.orderStatus == 3 ? Center(
                                    child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          videoUrl = _course.data.collegeClass[0].videoUrlList[0].url;
                                          initPlayer();
                                        });
                                      },
                                      child: Container(
                                        width: ScreenAdaper.width(261), height: ScreenAdaper.height(88),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(255, 255, 255, 0.3), borderRadius: BorderRadius.circular(3)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset('images/home_image65.png', width: ScreenAdaper.width(48),),
                                            SizedBox(width: ScreenAdaper.width(20),),
                                            Text('观看课程', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(32)),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ) : this._course.data.collegeClass[0].isFree ? Center(
                                    // 如果免费并且观看结束的就显示试看结束
                                    child: isFreeEnd ? InkWell(
                                      onTap: (){
                                        provider.initCourseDetails(_course);
                                        Navigator.pushNamed(context, '/pay');
                                      },
                                      child: Container(
                                        width: ScreenAdaper.width(470), height: ScreenAdaper.height(88),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(255, 255, 255, 0.3), borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text('试看已结束，请点击', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(32)),),
                                            Text('购买课程', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(32), decoration: TextDecoration.underline,),)
                                          ],
                                        ),
                                      ),
                                    ) : Center(
                                      child: InkWell(// 如果是免费的就显示免费试看
                                        onTap: (){
                                          setState(() {
                                            videoUrl = _course.data.collegeClass[0].videoUrlList[0].url;
                                          });
                                          initPlayer();
                                        },
                                        child: Container(
                                          width: ScreenAdaper.width(261), height: ScreenAdaper.height(88),
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(255, 255, 255, 0.3), borderRadius: BorderRadius.circular(3)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset('images/home_image65.png', width: ScreenAdaper.width(48),),
                                              SizedBox(width: ScreenAdaper.width(20),),
                                              Text('免费试看', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(32)),)
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ) :  
                                  // 如果不是免费就显示付费
                                  Center(
                                    child: InkWell(
                                      onTap: (){
                                        provider.initCourseDetails(_course);
                                        Navigator.pushNamed(context, '/pay');
                                      },
                                      child: Container(
                                        width: ScreenAdaper.width(450), height: ScreenAdaper.height(88),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(255, 255, 255, 0.3), borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text('付费课程，请点击', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(32)),),
                                            Text('购买课程', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(32), decoration: TextDecoration.underline,),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ) : Container(),
                            Positioned(
                              top: ScreenAdaper.width(36), left: ScreenAdaper.width(20),
                              child: InkWell(
                                onTap: (){
                                  if(isShowSpeed || isShowClarity){
                                    setState(() {
                                      isShowSpeed = false;
                                      isShowClarity = false;
                                    });
                                  }else{
                                    Navigator.pop(context);
                                  }
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
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(30), ScreenAdaper.height(20), ScreenAdaper.width(30), 0), 
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${_course.data.title}', style: TextStyle(color: Color(0xfff000000), fontSize: ScreenAdaper.size(32), fontWeight: FontWeight.bold),
                              maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: ScreenAdaper.height(8),),
                            Text('讲师：${_course.data.teacherName}', style: TextStyle(color: Color(0xfff000000), fontSize: ScreenAdaper.size(22)),),
                            SizedBox(height: ScreenAdaper.height(20),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SizedBox(height: ScreenAdaper.height(10),),
                                    Text('${_course.data.viewCount}观看•${_course.data.evaluateCount}评论•${_course.data.shareCount}转发', style: TextStyle(color: Color(0xfffA2A2A2), fontSize: ScreenAdaper.size(22)),),
                                  ],
                                ),
                                Stack(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: (){
                                            _collect(_course.data);
                                          },
                                          child: Image.asset('images/home_image3${isCollect?9:8}.png', width: ScreenAdaper.width(44), height: ScreenAdaper.height(44),)
                                        ),
                                        // SizedBox(width: ScreenAdaper.width(50),),
                                        // InkWell(
                                        //   onTap: (){
                                        //     // initWx();
                                        //   },
                                        //   child: Image.asset('images/home_image37.png', width: ScreenAdaper.width(44), height: ScreenAdaper.height(44),)
                                        // ),
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
                                    // Positioned(
                                    //   bottom: 0, right: ScreenAdaper.width(86),
                                    //   child: Image.asset('images/home_image41.png', width: ScreenAdaper.width(20), height: ScreenAdaper.height(20),),
                                    // )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: ScreenAdaper.height(40),),
                            Divider(height: ScreenAdaper.height(1),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true, //是否固定在顶部
                  floating: true,
                  delegate: _SliverAppBarDelegate(
                    minHeight: 50, //收起的高度
                    maxHeight: 50, //展开的最大高度
                    child: DefaultTabController(
                      length: this._tab.length,
                      child: Container(
                        width: double.infinity, color: Color(0xffFFFFFF),
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
                              if(i == 2 && _evaluationList.length == 0) getEvaluation();
                            });
                          },
                        ),
                      ),
                    ),
                  )
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return _tabIndex == 0 ? _introduction() : _tabIndex == 1 ? _directory() : _evaluation();
                  }, childCount: 1,),
                )
              ]
            ),
            // 评价输入框
            _tabIndex == 2 ? _input() : Container(),
            // 购买课程按钮
            _course.data.orderSatus.orderStatus != 2 && _course.data.orderSatus.orderStatus != 3 && _tabIndex != 2 ? _buy(provider) : Container()
          ],
        ) : Loading(),
      ),
    );
  }


  // 分享
  Future _share(context) async{
    var userinfo = await Storage.getString('userinfo');
    var name = json.decode(userinfo)['UserName'];
    var logoUrl = json.decode(userinfo)['LogoUrl'];
    return showCustomDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: ScreenAdaper.width(85), top: ScreenAdaper.height(210)),
                child: GestureDetector(							// 手势处理事件
                  onTap: (){
                    // Navigator.of(context).pop();				//退出弹出框
                    // print('object');
                  },
                  child: Container(
                    width: ScreenAdaper.width(580), height: ScreenAdaper.height(649), color: Colors.red,
                    child: RepaintBoundary(
                      key: rootWidgetKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: ScreenAdaper.width(580), height: ScreenAdaper.height(348),
                            child: Image.network('${_course.data.smallImageUrl}', fit: BoxFit.fill,)
                          ),
                          Container(
                            width: ScreenAdaper.width(580), color: Color(0xffFFFFFF), 
                            padding: EdgeInsets.symmetric(vertical: ScreenAdaper.width(35), horizontal: ScreenAdaper.width(35)),
                            child: Column(
                              children: <Widget>[
                                Text('${_course.data.description}', 
                                  style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(27), decoration: TextDecoration.none), maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: ScreenAdaper.height(30),),
                                Row(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          width: ScreenAdaper.width(153), height: ScreenAdaper.width(153),
                                          child: Image.network('https://zcxy.oss-cn-beijing.aliyuncs.com/xcx/xcxcode.jpg', fit: BoxFit.fill,)
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
                                              child: Image.network("$logoUrl", fit: BoxFit.fill,),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: ScreenAdaper.width(13),),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('$name', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(18), decoration: TextDecoration.none)),
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
              ),
              Positioned(
                bottom: 0, left: 0,
                child: Container(
                  width: ScreenAdaper.width(750), height: ScreenAdaper.height(323), 
                  color: Color(0xffFFFFFF),
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(60)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround, 
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                if(isSavePosters) {
                                  toast('已经保存到相册');
                                }else if(images == null){
                                  _capturePng();
                                }else{
                                  // 如果有截图，就直接保存不需要再截图
                                  getPermission();
                                }
                              },
                              child: Column(
                                children: <Widget>[
                                  Image.asset('images/home_image49.png', width: ScreenAdaper.width(80),),
                                  SizedBox(height: ScreenAdaper.height(18),),
                                  Text('保存海报', style: TextStyle(color: Color(0xff5F5F5F), fontSize: ScreenAdaper.size(24), decoration: TextDecoration.none)),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  isGoodFriends = true;
                                  // 如果分享海报已经生成就直接分享，如果分享海报没有生成就判断截图有没有生成，如果没有就生成，如果有就上传后台生成海报
                                  shareImg !='' ? shares() : images == null ?_capturePng() : getShareImg();
                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Image.asset('images/home_image50.png', width: ScreenAdaper.width(80),),
                                  SizedBox(height: ScreenAdaper.height(18),),
                                  Text('微信', style: TextStyle(color: Color(0xff5F5F5F), fontSize: ScreenAdaper.size(24), decoration: TextDecoration.none)),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  isGoodFriends = false;
                                  shareImg !='' ? shares() : images == null ?_capturePng() : getShareImg();
                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Image.asset('images/home_image51.png', width: ScreenAdaper.width(80),),
                                  SizedBox(height: ScreenAdaper.height(18),),
                                  Text('朋友圈', style: TextStyle(color: Color(0xff5F5F5F), fontSize: ScreenAdaper.size(24), decoration: TextDecoration.none)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }


  // 简介
  Widget _introduction(){
    var html = '${_course.data.collegeContent.replaceAll('\"', '"').replaceAll('https://', '//')}';
    return Container(
      padding: EdgeInsets.only(bottom: _course.data.orderSatus.orderStatus != 2 && _course.data.orderSatus.orderStatus != 3 && _tabIndex != 2 ? 108 : 0),
      child: Column(
        children: <Widget>[
          Text('各个平台规则随时更新，请遵循最新的平台规则执行。'),
          HtmlWidget(html: html, key: key),
        ],
      ),
    );
  }

  // 目录
  Widget _directory(){
    return Container(
      padding: EdgeInsets.only(top: ScreenAdaper.height(20), 
      bottom: ScreenAdaper.height(_course.data.orderSatus.orderStatus != 2 && _course.data.orderSatus.orderStatus != 3 && _tabIndex != 2 ?108:0)),
      child: Wrap(
        children: this._course.data.collegeClass.map((item){
          var index = this._course.data.collegeClass.indexOf(item);
          var colors = _directoryIndex==index ? 0xffFF8636 : 0xffA2A2A2;
          // 时间
          var time;
          if(item.classTimeLong !=''){
            var times = double.parse(item.classTimeLong);
            if(times < 60){
              time = times~/1;
            }else{
              var minutes = times~/60;
              var seconds = (times%60).toStringAsFixed(0);
              time = '$minutes:$seconds';
            }
          }else{
            time = '';
          }
          return InkWell(
            onTap: (){
              setState(() {
                _directoryIndex = index;
                videoUrl = item.videoUrlList[clarityIndex].url;
                // 倍数
                isShowSpeed = false;
                // 清晰度
                isShowClarity = false;
                duration = 0.0;
                initPlayer();
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(30)), 
              margin: EdgeInsets.only(bottom: ScreenAdaper.height(49)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('第${index+1}节：', style: TextStyle(color: Color(colors), fontSize: ScreenAdaper.size(28)),),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${item.className}', style: TextStyle(color: Color(colors), fontSize: ScreenAdaper.size(28)), maxLines: 2, overflow: TextOverflow.ellipsis,),
                        SizedBox(height: ScreenAdaper.height(12),),
                        Row(
                          children: <Widget>[
                            Text('$time', style: TextStyle(color: Color(colors), fontSize: ScreenAdaper.size(20.34)),),
                            SizedBox(width: ScreenAdaper.width(23),),
                            item.isFree ? Container(
                              width: ScreenAdaper.width(62), height: ScreenAdaper.height(30),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1, color: Color(0xffF18D41)
                                ),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Center(child: Text('试看', style: TextStyle(color: Color(0xffF18D41), fontSize: ScreenAdaper.size(16.64)),),),
                            ) : Container()
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: ScreenAdaper.width(50),),
                  Container(
                    padding: EdgeInsets.only(top: ScreenAdaper.height(4)),
                    child: Image.asset('images/home_image4${_directoryIndex==index ? playing?3:4:5}.png', width: ScreenAdaper.width(38), height: ScreenAdaper.width(38),),
                  )
                ],
              ),
            ),
          );
        }).toList()
      ),
    );
  }

  // 评价
  Widget _evaluation(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(ScreenAdaper.width(32), 0, ScreenAdaper.width(32), ScreenAdaper.width(98)),
      child: this._evaluationList !=null ?Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: ScreenAdaper.height(20),),
          Text('全部评论（${_evaluationList.length}）', style: TextStyle(color: Color(0xfff000000), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.bold),),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            
            itemCount: _evaluationList.length,
            itemBuilder: (context, index){
              var item = _evaluationList[index];
              return Container(
                width: double.infinity, margin: EdgeInsets.only(bottom: ScreenAdaper.height(25)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: ScreenAdaper.width(4),),
                    Align(
                      child: ClipOval(
                        child: SizedBox(
                          width: ScreenAdaper.width(70), height: ScreenAdaper.width(70),
                          child: Image.network("${item.logoUrl}", fit: BoxFit.fill,),
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenAdaper.width(10),),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${item.userName}', style: TextStyle(color: Color(0xfff000000), fontSize: ScreenAdaper.size(26), fontWeight: FontWeight.bold),),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('images/home_image46.png', width: ScreenAdaper.width(20), height: ScreenAdaper.width(20),),
                              Image.asset('images/home_image46.png', width: ScreenAdaper.width(20), height: ScreenAdaper.width(20),),
                              Image.asset('images/home_image46.png', width: ScreenAdaper.width(20), height: ScreenAdaper.width(20),),
                              Image.asset('images/home_image46.png', width: ScreenAdaper.width(20), height: ScreenAdaper.width(20),),
                              Image.asset('images/home_image46.png', width: ScreenAdaper.width(20), height: ScreenAdaper.width(20),),
                              SizedBox(width: ScreenAdaper.width(9),),
                              Text('${item.score}', style: TextStyle(color: Color(0xfffA2A2A2), fontSize: ScreenAdaper.size(24)),),
                            ],
                          ),
                          SizedBox(height: ScreenAdaper.height(8),),
                          Text('${item.content}', style: TextStyle(color: Color(0xfff000000), fontSize: ScreenAdaper.size(26)),),
                          Wrap(
                            children: item.replyList.map((childItem){
                              return Container(
                                width: double.infinity, 
                                padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(28), vertical: ScreenAdaper.height(20)),
                                margin: EdgeInsets.only(top: ScreenAdaper.height(15)),
                                decoration: BoxDecoration(
                                  color: Color(0xffF8F8F8), borderRadius: BorderRadius.circular(3)
                                ),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: '${childItem.userName}：', style: TextStyle(color: Color(0xfff000000), fontSize: ScreenAdaper.size(22)),),
                                      TextSpan(text: '${childItem.content}', style: TextStyle(color: Color(0xfff808080), fontSize: ScreenAdaper.size(26)),),
                                    ]
                                  )
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: ScreenAdaper.height(30),),
                          Text('${item.createTime}', style: TextStyle(color: Color(0xfff808080), fontSize: ScreenAdaper.size(22)),),
                          SizedBox(height: ScreenAdaper.height(32),),
                          Divider(height: 1,)
                        ],
                      ),
                    )
                  ],
                ),
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
              onTap: _addvaluate,
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

  // 购买
  Widget _buy(provider){
    return Positioned(
      bottom: 0, left: 0,
      child: Container(
        width: ScreenAdaper.width(750), height: ScreenAdaper.height(108), padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(40)),
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 0), blurRadius: 5),
          ]
        ),
        child: Center(
          child: InkWell(
            onTap: (){
              provider.initCourseDetails(_course);
              Navigator.pushNamed(context, '/pay');
            },
            child: Container(
              width: double.infinity, height: ScreenAdaper.height(82),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffF5B342), Color(0xffEF6A36)]
                ),
                borderRadius: BorderRadius.circular(30)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('购买：${convertNum(_course.data.collegePrice)}', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(34)),),
                  Text('牛币', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(22)),),
                ],
              ),
            ),
          ),
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