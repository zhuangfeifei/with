import 'package:flutter/material.dart';

class Counter with ChangeNotifier{

  int _count = 0;   // 状态

  int get count => _count;  // 获取状态

  Counter(){     // 初始化
    // _count = 10;
  }

  incCount(value){               // 更新状态
    this._count+=value;
    notifyListeners();    // 表示更新状态
  }


}