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
  Stream<Msg> get msgStream => _msgStream.stream; // 用于发送消息
  bool get isValidate => _isValidate; // Token验证是否通过
  int get currentCtRoomId => _currentCtRoomId; // 当前聊天室Id

  static CtRoomService _instance;

  // 初始化
  static void invoke(Function(CtRoomService) onCompelete,
      {String token, int ctRoomId = 0, String ip = "114.215.174.191"}) {
    if (_instance != null) {
      _instance.close();
    }
    _instance = CtRoomService(token, ctRoomId, ip);
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
      print('start checkToken');
      _socket.add(_spExt(_operLogin, 0, msg: token));
    }
  }

  // 切换聊天室
  partIn(int ctRoomId) {
    print('start part in ctRoom(id:$ctRoomId)');
    _socket.add(_spExt(_operLogin, 3, msg: ctRoomId.toString()));
  }

  // 发送信息
  send(String msg, {int ctRommId}) {
    try {
      var ext = ctRommId ?? _currentCtRoomId ?? 0;
      _socket.add(_spExt(_operSendMsg, ext, msg: msg));
      print('send msg to ctRoom(id:$ext) success');
    } catch (e) {
      print('send fail:$e');
    }
  }

  StreamController<Msg> _msgStream = StreamController<Msg>();
  int _port = 5009;
  String _token;
  bool _ipFixed = false;
  String _ip;

  Socket _socket;
  bool _isValidate = false;
  int maxCheckCount = 3;
  int _currentCtRoomId;

  static const int _operSendMsg = 2;
  static const int _operLogin = 1;

  CtRoomService(this._token, this._currentCtRoomId, this._ip);

  _getIp(Function callback) {
    getIpS(Response<dynamic> data) {
      if (!_ipFixed && data.statusCode == 200 && data.data != null) {
        _instance._ip = data.data;
      }
      print('use ip:${_instance._ip}');
      callback();
    }

    return Dio()
        .get("https://www.proseer.cn/zcxypc/api/chatroom/ip")
        .then(getIpS);
  }

  _connect(onCompelete) {
    try {
      Socket.connect(_ip, _port).then((socket) {
        _socket = socket;
        checkToken(_token);
        socket.listen((data) => _dealWithMsg(data));
        if (_currentCtRoomId > 0) {
          partIn(_currentCtRoomId);
        }
        onCompelete(_instance);
        print('connect success');
      });
    } catch (e) {
      print('connect fail:$e');
    }
  }

  _spExt(int oper, int ext, {String msg}) =>
      Uint8List.fromList([1, 2, 1, 2, oper]) + utf8.encode("$ext,$msg");

  _sp(int oper, {String msg}) =>
      Uint8List.fromList([1, 2, 1, 2, oper]) + utf8.encode(msg);

  _dealWithMsg(Uint8List data) {
    try {
      var oper = int.parse(data[4].toString());
      var msg = utf8.decode(data.sublist(5));
      // print("dealWithMsg：$oper -- $msg -- $data");
      switch (oper) {
        case _operSendMsg:
          if (msg != null) {
            var msgJson = json.decode(msg);
            var msgModel = Msg(msgJson["Name"], msgJson["LogoUrl"],
                msgJson["Msg"], msgJson["SendTime"], msgJson["CtRoomId"]);
            _msgStream.add(msgModel);
          }
          break;
        case _operLogin:
          if (msg == "1") {
            print('login success');
            _isValidate = true;
          } else if (msg == "2") {
            print('login fail');
            if (maxCheckCount-- > 0) {
              checkToken(_token);
            }
            _isValidate = false;
          } else {
            var tmp = msg.split(',');
            if (tmp[0] == '4') {
              print('part in ${tmp[1]} success');
              this._currentCtRoomId = int.parse(tmp[1]);
            }
          }
          break;
      }
    } catch (e, s) {
      print("exp:$e$s");
    }
  }
}

class Msg {
  int ctRoomId;
  String logoUrl;
  String name;
  String msg;
  String sendTime;
  Msg(this.name, this.logoUrl, this.msg, this.sendTime, this.ctRoomId);
}