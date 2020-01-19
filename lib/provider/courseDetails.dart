import 'package:flutter/material.dart';

class CourseDetails with ChangeNotifier{

  var _courseDetails;
  var _couponItem;
  var _couponIndex = -1;

  Object get courseDetails => _courseDetails;
  Object get couponItem => _couponItem;
  Object get couponIndex => _couponIndex;

  CourseDetails(

  );

  initCourseDetails(value){               // 更新状态
    this._courseDetails = value;
    notifyListeners();    // 表示更新状态
  }

  initCouponItem(value){               
    this._couponItem = value;
    notifyListeners();    
  }

  initCouponIndex(value){               
    this._couponIndex = value;
    notifyListeners();    
  }

}