import 'package:flutter/material.dart';

import '../pages/login/start_page.dart';
import '../pages/login/registered_page.dart';
import '../pages/login/setpassword_page.dart';
import '../pages/login/login_page.dart';
import '../pages/login/loginpassword_page.dart';
import '../pages/login/forgotpassword_page.dart';

import '../pages/bottom_tab/bottom.dart';

import '../pages/home/home_page.dart';

import '../pages/alreadybought/alreadybought_page.dart';

final routes = {
  '/': (contxt) => StartPage(),
  '/registered': (contxt) => RegisteredPage(),   // 注册
  '/setpassword': (contxt) => SetpasswordPage(),  // 设置密码
  '/login': (contxt) => LoginPage(),                  // 手机号登录
  '/loginpassword': (contxt) => LoginpasswordPage(),  // 密码登录
  '/forgotpassword': (contxt) => ForgotpasswordPage(), // 忘记密码
  '/home': (context, {arguments}) => HomePage(arguments: arguments),
  '/bottom': (contxt) => BottomPage(), // 
  '/alreadybought': (contxt) => AlreadyboughtPage(), // 已购
};

var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  // if (settings.isInitialRoute) {
  //           return createInitialRoute(routes[name]);
  //         }
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) => pageContentBuilder(context,
              arguments: settings.arguments));
      return route;
    } else {
      final Route route = MaterialPageRoute(
          builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};


// Route<dynamic> createInitialRoute(page) {
//     return PageRouteBuilder(
//         transitionDuration: const Duration(seconds: 1),
//         pageBuilder: (BuildContext context, _, __) {
//           return page;
//         },
//         transitionsBuilder: (_, animation, __, child) {
//           return RotationTransition(
//             turns: Tween(begin: 0.0, end: 1.0).animate(animation),
//             child: ScaleTransition(
//               scale: Tween(begin: 0.0, end: 1.0).animate(animation),
//               child: child,
//             ),
//           );
//         });
//   }