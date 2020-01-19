import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:with_me/services/screenAdaper.dart';
 
///加载弹框
class ProgressDialog {
  static bool _isShowing = false;
  ///展示
  static void showProgress(BuildContext context,
    {
      Widget child = const SpinKitCircle(
        color: Colors.white,
        size: 40.0,
      )
    }
  ) {
    if(!_isShowing) {
      _isShowing = true;
      Navigator.push(
        context,
        _PopRoute(
          child: _Progress(
            child: child,
          ),
        ),
      );
    }
  }
 
  ///隐藏
  static void dismiss(BuildContext context) {
    if (_isShowing) {
      Navigator.of(context).pop();
      _isShowing = false;
    }
  }
}
 
///Widget
class _Progress extends StatelessWidget {
  final Widget child;
 
  _Progress({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: ScreenAdaper.width(200), height: ScreenAdaper.height(200),
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.5), borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), offset: Offset(0, 0), blurRadius: 5),
            ]
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                child,
                SizedBox(height: ScreenAdaper.height(5),),
                Text('加载中...', style: TextStyle(color: Color(0xffFFFFFF), fontSize: ScreenAdaper.size(26)),)
              ],
            ),
          ),
        ),
      )
    );
  }
}
 
///Route
class _PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;
 
  _PopRoute({@required this.child});
 
  @override
  Color get barrierColor => null;
 
  @override
  bool get barrierDismissible => true;
 
  @override
  String get barrierLabel => null;
 
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }
 
  @override
  Duration get transitionDuration => _duration;
}