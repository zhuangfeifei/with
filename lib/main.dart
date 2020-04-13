import 'package:flutter/material.dart';
import 'package:with_me/router/router.dart';
import './router/router.dart';
import 'package:provider/provider.dart';
import './provider/counter.dart';
import './provider/courseDetails.dart';
import './provider/liveListProvider.dart';
import './services/storage.dart';
import 'dart:convert';

void main()=>runApp(MyApp());


class MyApp extends StatelessWidget {
  // var userinfo;
  // void getUserinfo() async {
  //   var data = await Storage.getString('userinfo');
  //   userinfo = json.decode(data);
  // }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => Counter()),
        ChangeNotifierProvider(builder: (_) => CourseDetails()),
        ChangeNotifierProvider(builder: (_) => LiveListProvider()),
      ],
      child: Container(
        child: MaterialApp(
          title: '跟我跨境',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0xffFF8636),
          ),
          initialRoute: '/',
          onGenerateRoute: onGenerateRoute,
        ),
      ),
    );
  }
}