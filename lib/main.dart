import 'package:flutter/material.dart';
import 'package:with_me/router/router.dart';
import './router/router.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '跟我跨境',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xffFF8636),
        ),
        initialRoute: '/bottom',
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}