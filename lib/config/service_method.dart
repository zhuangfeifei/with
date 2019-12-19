import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:async';
import './service_url.dart';
import '../services/storage.dart';
import '../pages/widget/dialog.dart';

Future apiMethod(url, type, formData) async{

  try{
    // BuildContext context;
    // ProgressDialog.showProgress(context);
    Response response;
    Dio dio = new Dio();
    var userinfo = await Storage.getString('userinfo');
    if(userinfo !=null){
      var token = json.decode(userinfo)['Token'];
      dio.options.headers['Token'] = token;
    }
    response = await (type == 'post' ? dio.post(servicePath[url], data: formData) : dio.get(servicePath[url]));
    if(response.statusCode == 200){
      // ProgressDialog.dismiss(context);
      return response;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(e){
    return print('ERROR:======>${e}');
  }

}