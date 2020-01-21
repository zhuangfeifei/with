import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import '../../services/convertNum.dart';

class ClassificationList extends StatelessWidget {

  final item;
  ClassificationList({this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity, margin: EdgeInsets.only(bottom: ScreenAdaper.height(20)),
            padding: EdgeInsets.only(left: ScreenAdaper.width(30), right: ScreenAdaper.width(30)),
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/watchcourse', arguments: {'collegeId': item.id});
                  },
                  child: Container(
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
                              width: ScreenAdaper.width(162), height: ScreenAdaper.width(222),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: Image.network('${item.teacherImg}', fit: BoxFit.fill,),
                              ),
                            ),
                            Positioned(
                              top: 0, left: 0,
                              child: Container(
                                width: ScreenAdaper.width(90), height: ScreenAdaper.height(26),
                                padding: EdgeInsets.only(left: ScreenAdaper.width(6), top: ScreenAdaper.height(3)),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('images/home_image32.png'), alignment: Alignment.centerLeft, fit: BoxFit.fill,
                                  )
                                ),
                                child: Text('${item.categoryIdrStr}', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(16)),),
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: ScreenAdaper.width(20),),
                        Expanded(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: double.infinity, height: ScreenAdaper.width(220),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('${item.title}', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.bold), 
                                      maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: ScreenAdaper.height(8),),
                                    Text('${item.teacherName} • ${item.teacherTitle}', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(22)), 
                                      maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: ScreenAdaper.height(15),),
                                    Text('${item.description}', style: TextStyle(color: Color(0xffA2A2A2), fontSize: ScreenAdaper.size(22), height: 1.25), 
                                      maxLines: 2, overflow: TextOverflow.ellipsis, 
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: ScreenAdaper.height(10), left: 0,
                                child: Text('${item.viewCount}观看 • ${item.evaluateCount}评论 • ${item.collectCount}收藏', style: TextStyle(color: Color(0xffA2A2A2), fontSize: ScreenAdaper.size(18))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    // child: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: <Widget>[
                    //     Container(
                    //       width: double.infinity, height: ScreenAdaper.height(370),
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    //         child: Image.network('${item.smallImageUrl}', fit: BoxFit.fill,),
                    //       ),
                    //     ),
                    //     Container(
                    //       padding: EdgeInsets.only(left: ScreenAdaper.width(25)), margin: EdgeInsets.only(top: ScreenAdaper.height(18)),
                    //       child: Text('${item.title}', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.bold), 
                    //         maxLines: 1, overflow: TextOverflow.ellipsis,
                    //       ),
                    //     ),
                    //     Container(
                    //       padding: EdgeInsets.only(left: ScreenAdaper.width(25)), margin: EdgeInsets.only(top: ScreenAdaper.height(8)),
                    //       child: Text('${item.description}', style: TextStyle(color: Color(0xff666666), fontSize: ScreenAdaper.size(22)), 
                    //         maxLines: 1, overflow: TextOverflow.ellipsis,
                    //       ),
                    //     ),
                    //     SizedBox(height: ScreenAdaper.height(23),),
                    //     // 标签
                    //     Row(
                    //       children: <Widget>[
                    //         SizedBox(width: ScreenAdaper.width(25),),
                    //         Container(
                    //           padding: EdgeInsetsDirectional.fromSTEB(ScreenAdaper.width(15), ScreenAdaper.height(3), ScreenAdaper.width(15), ScreenAdaper.height(3)),
                    //           decoration: BoxDecoration(
                    //             border: Border.all(width: ScreenAdaper.width(1), color: Color(0xffFF8636)),
                    //             borderRadius: BorderRadius.circular(30)
                    //           ),
                    //           child: Text('${item.categoryIdrStr}', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(18), fontWeight: FontWeight.bold)),
                    //         ),
                    //         SizedBox(width: ScreenAdaper.width(15),),
                    //         Text('${item.viewCount}观看 • ${item.evaluateCount}评论', style: TextStyle(color: Color(0xffA2A2A2), fontSize: ScreenAdaper.size(18))),
                    //       ],
                    //     ),
                    //     // 头像
                    //     Container(
                    //       child: ListTile(
                    //         leading: Container(
                    //           width: ScreenAdaper.width(50), height: ScreenAdaper.width(50),
                    //           child: CircleAvatar(backgroundImage: NetworkImage('${item.teacherImg}',),),
                    //         ),
                    //         title: Text('${item.teacherName} • ${item.teacherTitle}', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(22)), textAlign: TextAlign.start,),
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ),
                ),
                item.isHaveFree && item.salePrice > 0 ? Positioned(
                  top: 0, right: 0,
                  child: Container(
                    width: ScreenAdaper.width(102),
                    child: Image.asset('images/home_image33.png', fit: BoxFit.fill,),
                  ),
                ) : Container(),
              ],
            ),
          ),
          Positioned(
            bottom: ScreenAdaper.height(50), right: ScreenAdaper.width(22),
            child: Container(
              width: ScreenAdaper.width(120), height: ScreenAdaper.height(46),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/home_image26.png'), fit: BoxFit.fill,
                )
              ),
              child: Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: '￥', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(16))),
                      TextSpan(text: '${convertNum(item.salePrice)}', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(27))),
                      TextSpan(text: '购买', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(16))),
                    ]
                  )
                ),
              ),
            ),
          ),
          // 去观看
          // Positioned(
          //   bottom: ScreenAdaper.height(61), right: ScreenAdaper.width(12),
          //   child: Container(
          //     width: ScreenAdaper.width(144), height: ScreenAdaper.height(78), padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: AssetImage('images/home_image25.png'), fit: BoxFit.fill
          //       )
          //     ),
          //     child: Center(
          //       child: Text.rich(
          //         TextSpan(
          //           children: [
          //             TextSpan(text: '￥', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(28), fontWeight: FontWeight.bold),),
          //             TextSpan(text: '${item.salePrice/100}', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(38), fontWeight: FontWeight.bold),),
          //           ]
          //         )
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}