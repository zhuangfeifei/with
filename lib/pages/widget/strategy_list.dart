import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';

class StrategyList extends StatelessWidget {

  final item;
  final index;
  StrategyList({this.item, this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/strategyDetail', arguments: {'id': item.id});
      },
      child: Container(
        padding: EdgeInsets.only(top: ScreenAdaper.height(23)), color: Color(0xffFFFFFF),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: ScreenAdaper.width(34), height: ScreenAdaper.width(34), margin: EdgeInsets.only(right: ScreenAdaper.width(25)),
              child: Image.asset('images/home_image1${index+1}.png', fit: BoxFit.fill,),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: ScreenAdaper.height(23)),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xffEFEFEF), width: 1)
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${item.title}', style: TextStyle(
                      fontSize: ScreenAdaper.size(26), color: Color(0xff000000), fontWeight: FontWeight.bold, height: 1.2),
                      maxLines: 2, overflow: TextOverflow.ellipsis, 
                    ),
                    SizedBox(height: ScreenAdaper.height(12),),
                    Row(
                      children: <Widget>[
                        Text('【${item.categoryId2Str}】', style: TextStyle(fontSize: ScreenAdaper.size(20), color: Color(0xffFF8636)),),
                        Text('${item.createTime}', style: TextStyle(fontSize: ScreenAdaper.size(20), color: Color(0xffA2A2A2),),),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}