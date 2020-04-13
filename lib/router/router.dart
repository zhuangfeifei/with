import 'package:flutter/material.dart';

import '../pages/login/starts_page.dart';
import '../pages/login/start_page.dart';
import '../pages/login/registered_page.dart';
import '../pages/login/setpassword_page.dart';
import '../pages/login/login_page.dart';
import '../pages/login/loginpassword_page.dart';
import '../pages/login/forgotpassword_page.dart';
import '../pages/login/setnewpassword_page.dart';

import '../pages/bottom_tab/bottom.dart';

import '../pages/home/home_page.dart';
import '../pages/home/search_page.dart';
import '../pages/home/strategy_page.dart';
import '../pages/home/classification_page.dart';
import '../pages/home/watchcourse_page.dart';
import '../pages/home/pay_page.dart';
import '../pages/home/recharge_page.dart';
import '../pages/home/livecourse_page.dart';
import '../pages/home/consulting_page.dart';
import '../pages/home/livein_page.dart';
import '../pages/home/strategyDetail_page.dart';

import '../pages/alreadybought/alreadybought_page.dart';

import '../pages/my/my_page.dart';
import '../pages/my/coupon_page.dart';
import '../pages/my/myCoupon_page.dart';
import '../pages/my/myCollection_page.dart';
import '../pages/my/myCow_page.dart';
import '../pages/my/exchangeCoupon_page.dart';
import '../pages/my/setup_page.dart';
import '../pages/my/personal_page.dart';

final routes = {
  '/': (contxt) => StartsPage(),
  '/starts': (contxt) => StartPage(),
  '/registered': (contxt) => RegisteredPage(),   // 注册
  '/setpassword': (contxt) => SetpasswordPage(),  // 设置密码
  '/login': (contxt) => LoginPage(),                  // 手机号登录
  '/loginpassword': (contxt) => LoginpasswordPage(),  // 密码登录
  '/forgotpassword': (contxt) => ForgotpasswordPage(), // 忘记密码
  '/setnewpassword': (contxt) => SetnewpasswordPage(), // 忘记密码
  '/home': (context, {arguments}) => HomePage(arguments: arguments),
  '/search': (contxt) => SearchPage(), // 搜索
  '/strategy': (contxt) => StrategyPage(), // 攻略
  '/strategyDetail': (context, {arguments}) => StrategyDetailPage(arguments: arguments), // 攻略详情
  '/classification': (context, {arguments}) => ClassificationPage(arguments: arguments), // 课程分类
  '/watchcourse': (context, {arguments}) => WatchcoursePage(arguments: arguments), // 观看课程
  '/pay': (context) => PayPage(), // 支付
  '/recharge': (contxt) => RechargePage(), // 充值
  '/consulting': (contxt) => ConsultingPage(), // 咨询
  '/livein': (contxt) => LiveinPage(), // 直播中 
  '/bottom': (contxt) => BottomPage(), // tab
  '/alreadybought': (contxt) => AlreadyboughtPage(), // 已购
  '/my': (contxt) => MyPage(), // 我的
  '/livecourse': (contxt, {arguments}) => LivecoursePage(arguments: arguments), // 直播
  '/coupon': (contxt) => CouponPage(), // 优惠券
  '/mycoupon': (contxt) => MyCouponPage(), // 优惠券
  '/exchangeCoupon': (contxt) => ExchangeCouponPage(), // 优惠券
  '/myCollection': (contxt) => MyCollectionPage(), // 我的收藏
  '/myCow': (contxt, {arguments}) => MyCowPage(arguments: arguments), // 我的牛币
  '/setup': (contxt) => SetupPage(), // 设置
  '/personal': (contxt) => PersonalPage(), // 个人资料
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