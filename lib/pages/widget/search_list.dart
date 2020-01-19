import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import '../../services/convertNum.dart';

class SearchList extends StatelessWidget {

  final item;
  final value;
  SearchList({this.item, this.value});

  // 检索
  getItem(val, isName){
    var itemList = List<TextSpan>();
    var splitRes = val.split(value);
    var i=0;
    for (var items in splitRes) {
      i++;
      itemList.add(
        TextSpan(text: '$items', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(isName?22:28), fontWeight: isName ? FontWeight.w400 : FontWeight.bold))
      );
      if(i != splitRes.length){
        itemList.add(
          TextSpan(text: '$value', style: TextStyle(color: Color(0xffFF8636), fontSize: ScreenAdaper.size(isName?22:28), fontWeight: isName ? FontWeight.w400 : FontWeight.bold))
        );
      }
    }
    return RichText(
      text: TextSpan(
        children: itemList,
      ), overflow: TextOverflow.ellipsis, maxLines: 1,
    );
  }

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
                              child: Image.network('${item.teacherImg}', fit: BoxFit.fill,),
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
                                  getItem(item.title, false),
                                  SizedBox(height: ScreenAdaper.height(8),),
                                  Row(
                                    children: <Widget>[
                                      getItem(item.teacherName, true),
                                      Text(' • ${item.teacherTitle}', style: TextStyle(color: Color(0xff000000), fontSize: ScreenAdaper.size(22)),),
                                    ],
                                  ),
                                  SizedBox(height: ScreenAdaper.height(15),),
                                  Text('${item.description}', style: TextStyle(color: Color(0xffA2A2A2), fontSize: ScreenAdaper.size(22), height: 1.25), 
                                    maxLines: 2, overflow: TextOverflow.ellipsis, 
                                  ),
                                  SizedBox(height: ScreenAdaper.height(27),),
                                  Text('${item.viewCount}观看 • ${item.evaluateCount}评论 • ${item.collectCount}收藏', style: TextStyle(color: Color(0xffA2A2A2), fontSize: ScreenAdaper.size(18))),
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
                item.isHaveFree ? Positioned(
                  top: 0, right: 0,
                  child: Container(
                    width: ScreenAdaper.width(102), height: ScreenAdaper.height(60),
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
                      TextSpan(text: '${convertNum(item.collegePrice)}', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(27))),
                      TextSpan(text: '购买', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(16))),
                    ]
                  )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}