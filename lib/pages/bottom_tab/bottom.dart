import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../services/screenAdaper.dart';
import '../home/home_page.dart';
import '../alreadybought/alreadybought_page.dart';
import '../course/coursecenter_page.dart';
import '../my/my_page.dart';

class BottomPage extends StatefulWidget {
  @override
  _BottomPageState createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {

  PageController _pageController;

  final List<Widget> tabBodies = List();
  int currentIndex= 0;

  @override
  void initState() {
    this._pageController =PageController(initialPage: this.currentIndex, keepPage: true);

    tabBodies..add(HomePage())..add(AlreadyboughtPage())..add(CoursecenterPage())..add(MyPage());

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('images/home_image14.png', width: ScreenAdaper.width(40), height: ScreenAdaper.width(40),),
            activeIcon: Image.asset('images/home_image15.png', width: ScreenAdaper.width(40), height: ScreenAdaper.width(40),),
            title:Text('发现')
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/home_image16.png', width: ScreenAdaper.width(42), height: ScreenAdaper.height(40),),
            activeIcon: Image.asset('images/home_image17.png', width: ScreenAdaper.width(42), height: ScreenAdaper.height(40),),
            title:Text('已购')
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/home_image18.png', width: ScreenAdaper.width(37), height: ScreenAdaper.height(40),),
            activeIcon: Image.asset('images/home_image19.png', width: ScreenAdaper.width(37), height: ScreenAdaper.height(40),),
            title:Text('课程中心')
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/home_image20.png', width: ScreenAdaper.width(40), height: ScreenAdaper.width(40),),
            activeIcon: Image.asset('images/home_image21.png', width: ScreenAdaper.width(40), height: ScreenAdaper.width(40),),
            title:Text('我的')
          ),
        ],
        selectedItemColor: Color(0xffFF3D00),
        unselectedItemColor: Color(0xff7F7F7F),
        selectedFontSize: ScreenAdaper.size(23),
        unselectedFontSize: ScreenAdaper.size(23),
        onTap: (index){
          setState(() {
           currentIndex = index;
           _pageController.jumpToPage(index);
          });
        },
      ),
      body: PageView(
        children: tabBodies,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}