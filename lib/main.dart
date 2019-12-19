import 'package:flutter/material.dart';
import 'package:with_me/router/router.dart';
import './router/router.dart';
import 'package:provider/provider.dart';
import './provider/counter.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => Counter()),
      ],
      child: Container(
        child: MaterialApp(
          title: '跟我跨境',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0xffFF8636),
          ),
          initialRoute: '/coupon',
          onGenerateRoute: onGenerateRoute,
        ),
      ),
    );
  }
}