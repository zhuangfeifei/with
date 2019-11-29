import 'package:dio/dio.dart';
import 'dart:async';
import './service_url.dart';

Future apiMethod(url, type, formData) async{

  try{
    print('开始获取首页数据...............');
    Response response;
    Dio dio = new Dio();
    response = await (type == 'post' ? dio.post(servicePath[url], data: formData) : dio.get(servicePath[url]));
    if(response.statusCode == 200){
      return response;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(e){
    return print('ERROR:======>${e}');
  }

}