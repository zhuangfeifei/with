import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';

class CourseList extends StatelessWidget {
  final list;
  CourseList({this.list});


  @override
  Widget build(BuildContext context) {
    print(list);
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/watchcourse');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: ScreenAdaper.height(29)),
        child: Row(
          children: <Widget>[
            Container(
              width: ScreenAdaper.width(228), height: ScreenAdaper.height(152), margin: EdgeInsets.only(right: ScreenAdaper.width(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6), topRight: Radius.circular(6), bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6),
                ),
                child: Image.network('${list.smallImageUrl}', fit: BoxFit.fill,),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${list.title}', style: TextStyle(
                    fontSize: ScreenAdaper.size(26), color: Color(0xff000000), fontWeight: FontWeight.bold, height: 1.2),
                    maxLines: 2, overflow: TextOverflow.ellipsis, 
                  ),
                  SizedBox(height: ScreenAdaper.height(12),),
                  Text('${list.teacherName} • ${list.teacherTitle}', style: TextStyle(fontSize: ScreenAdaper.size(22), color: Color(0xffA2A2A2),),maxLines: 1, overflow: TextOverflow.ellipsis,),
                  SizedBox(height: ScreenAdaper.height(3),),
                  Text('【${list.categoryIdrStr}】', style: TextStyle(fontSize: ScreenAdaper.size(22), color: Color(0xffFF8636)),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}