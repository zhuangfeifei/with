import 'package:flutter/material.dart';
import '../config/service_method.dart';
import '../model/liveList_model.dart';
import '../pages/widget/toast.dart';

class LiveListProvider with ChangeNotifier{

  LiveListModel _livelists;

  LiveListModel get livelists => _livelists;

  // LiveListProvider(){
  //   apiMethod('livestreaming', 'post','?pageIndex=1').then((res){
  //     print(res);
  //     // if(res.data['Code'] == '5002'){
  //     //   Navigator.pushNamed(context, '/login');
  //     // }
  //     if(res.data['IsSuccess']){
  //       var list = LiveListModel.fromJson(res.data);
  //       this._livelists = list;
  //     }else{
  //       toast(res.data['Message']);
  //     }
  //   });
  // }


  initliveListProvider(value){               // 更新状态
    this._livelists = value;
    notifyListeners();    // 表示更新状态
  }

}
 
 