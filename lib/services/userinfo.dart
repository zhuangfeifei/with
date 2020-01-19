import 'dart:convert';

import '../config/service_method.dart';
import './storage.dart';
import '../pages/widget/toast.dart';

getUserinfoMethod(){
  apiMethod('getcache', 'post', '').then((res){
    if(res.data['IsSuccess']){
        Storage.setString('userinfo',  json.encode(res.data['Data']));
      }else{
        toast(res.data['Message']);
      }
  });
}