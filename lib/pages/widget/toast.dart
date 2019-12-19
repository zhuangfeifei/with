import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast(massge){
  Fluttertoast.showToast(
    msg: massge,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIos: 3,
    textColor: Color(0xffFFFFFF),
    backgroundColor: Color.fromRGBO(0, 0, 0, 0.8)
  );
}