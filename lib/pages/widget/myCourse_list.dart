import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';

class MyCourseList extends StatelessWidget {
  final item;
  MyCourseList({this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: ScreenAdaper.width(750), margin: EdgeInsets.only(bottom: ScreenAdaper.height(20)),
            padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(20)),
            child: Stack(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/watchcourse', arguments: {'collegeId': item.id});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: ScreenAdaper.width(20), vertical: ScreenAdaper.height(26)),
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
                                width: double.infinity, height: ScreenAdaper.height(220),
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}