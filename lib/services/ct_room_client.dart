import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:typed_data';

main() {
  // Uint8List u=Uint8List.fromList([1,2,3,4]);
  // print(utf8.decode(u.sublist(4)))
  var action = (CtRoomService data) {
    data.msgStream.listen((msg) => print(msg.name + ":" + msg.msg)); // 接收消息
    // if (!data.isValidate) {
    //   data.checkToken(
    //       "01118862493252128P2hEuzgyF2tuS%2bKtEE7nVPtnW9OSMXUdMt0rnf%2f%2fHSYIoUhCbDHvn5JZlBZYyCLBwc4fbT7Ec37NFGqIFJ%2f1KdyeRv13gs9M2s4dEw0DL2Rx0EJcsHDNt4Rz9YUpj9bY");
    // }
    data.send('大家好'); // 发送消息
    // data.close(); // 关闭聊天室
  };
  //初始化
  CtRoomService.invoke(action,
      token:
          "01118862493252128P2hEuzgyF2tuS%2bKtEE7nVPtnW9OSMXUdMt0rnf%2f%2fHSYIoUhCbDHvn5JZlBZYyCLBwc4fbT7Ec37NFGqIFJ%2f1KdyeRv13gs9M2s4dEw0DL2Rx0EJcsHDNt4Rz9YUpj9bY",ctRoomId: 5);
}

class CtRoomService {
  String get ip => _ip; // 当前服务器Ip地址
  Stream<Msg> get msgStream => _msgStream.stream; // 用于接收消息
  bool get isValidate => _isValidate; // Token验证是否通过
  int get currentCtRoomId => _currentCtRoomId; // 当前聊天室Id

  static CtRoomService _instance;

  // 初始化
  static void invoke(Function(CtRoomService) onCompelete,
      {String token, int ctRoomId = 0}) {
    if (_instance != null) {
      _instance.close();
    }
    _instance = CtRoomService(token, ctRoomId);
    _instance._getIp(() => _instance._connect(onCompelete));
  }

  // 关闭聊天室
  close() {
    _instance._socket.close();
    _instance = null;
  }

  // 若isValidate为false,需要重新验证Token
  checkToken(String token) {
    if (!isValidate && token != null && token.isNotEmpty) {
      print('checkToken');
      _socket.add(_sp(_operLogin) + utf8.encode(token));
    }
  }

  // 切换聊天室
  partIn(int ctRoomId) {
    _socket.add(_sp(_operLogin, operCmd: 3, para: ctRoomId));
      print('try part in $ctRoomId');
  }

  // 发送信息
  send(String msg, {int ctRommId}) {
    try {
      var para = ctRommId ?? _currentCtRoomId ?? 0;
      _socket.add(_sp(_operSendMsg, para: para) + utf8.encode(msg));
      print('send success [$para]');
    } catch (e) {
      print('send fail:$e');
    }
  }

  StreamController<Msg> _msgStream = StreamController<Msg>();
  int _port = 5009;
  String _token;
  bool _isFixIp = false;
  String _ip = '192.168.2.11';

  Socket _socket;
  bool _isValidate = false;
  int maxCheckCount = 3;
  int _currentCtRoomId;

  static const int _operSendMsg = 1;
  static const int _operLogin = 2;

  CtRoomService(this._token, this._currentCtRoomId);

  _getIp(Function callback) {
    getIpS(Response<dynamic> data) {
      if (!_isFixIp && data.statusCode == 200 && data.data != null) {
        _instance._ip = data.data;
      }
      print('use ip:${_instance._ip}');
      callback();
    }

    return Dio()
        .get("https://www.proseer.cn/zcxypcstage/api/chatroom/ip")
        .then(getIpS);
  }

  _connect(onCompelete) {
    try {
      Socket.connect(_ip, _port).then((socket) {
        _socket = socket;
        print('connect success');
        socket.listen((data) => _dealWithMsg(data));
        checkToken(_token);
        partIn(_currentCtRoomId);
        onCompelete(_instance);
      });
    } catch (e) {
      print('connect fail:$e');
    }
  }

  _sp(int oper, {int operCmd = 0, int para = 0}) =>
      Uint8List.fromList([oper, operCmd, para >> 8, para & 255]);

  _dealWithMsg(Uint8List data) {
    try {
      var oper = data[0];
      var operCmd = data[1];
      var para = (data[2] << 8) + data[3];
      var msg = utf8.decode(data.sublist(4));
      switch (oper) {
        case _operSendMsg:
          if (msg != null) {
            var msgJson = json.decode(msg);
            var msgModel = Msg(msgJson["Name"], msgJson["LogoUrl"],
                msgJson["Msg"], msgJson["SendTime"]);
            _msgStream.add(msgModel);
          }
          break;
        case _operLogin:
          if (operCmd == 1) {
            print('login success');
            _isValidate = true;
          } else if (operCmd == 0) {
            print('login fail');
            if (maxCheckCount-- > 0) {
              checkToken(_token);
            }
            _isValidate = false;
          } else if (operCmd == 4) {
            print('part in success $para');
            this._currentCtRoomId = para;
          }
          break;
      }
    } catch (e) {
      print("exp:$e");
    }
  }
}

class Msg {
  String logoUrl;
  String name;
  String msg;
  String sendTime;
  Msg(this.name, this.logoUrl, this.msg, this.sendTime);
}
