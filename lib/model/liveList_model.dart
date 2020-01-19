class LiveListModel {
  List<Data> data;
  bool isSuccess;
  String code;
  String message;
  bool isCache;
  Object cacheName;
  Object dictionary;

  LiveListModel(
      {this.data,
      this.isSuccess,
      this.code,
      this.message,
      this.isCache,
      this.cacheName,
      this.dictionary});

  LiveListModel.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = new List<Data>();
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    isSuccess = json['IsSuccess'];
    code = json['Code'];
    message = json['Message'];
    isCache = json['IsCache'];
    cacheName = json['CacheName'];
    dictionary = json['Dictionary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['IsSuccess'] = this.isSuccess;
    data['Code'] = this.code;
    data['Message'] = this.message;
    data['IsCache'] = this.isCache;
    data['CacheName'] = this.cacheName;
    data['Dictionary'] = this.dictionary;
    return data;
  }
}

class Data {
  bool isBook;
  bool isNeedPop;
  int id;
  String title;
  String teacherName;
  int teacherId;
  String introduction;
  String appName;
  String streamName;
  String onlineTime;
  int bookCount;
  int status;
  String createTime;
  String updateTime;
  int hot;
  String img;
  String isOnlineUp;
  int isOnline;

  Data(
      {this.isBook,
      this.isNeedPop,
      this.id,
      this.title,
      this.teacherName,
      this.teacherId,
      this.introduction,
      this.appName,
      this.streamName,
      this.onlineTime,
      this.bookCount,
      this.status,
      this.createTime,
      this.updateTime,
      this.hot,
      this.img,
      this.isOnlineUp,
      this.isOnline});

  Data.fromJson(Map<String, dynamic> json) {
    isBook = json['IsBook'];
    isNeedPop = json['IsNeedPop'];
    id = json['Id'];
    title = json['Title'];
    teacherName = json['TeacherName'];
    teacherId = json['TeacherId'];
    introduction = json['Introduction'];
    appName = json['AppName'];
    streamName = json['StreamName'];
    onlineTime = json['OnlineTime'];
    bookCount = json['BookCount'];
    status = json['Status'];
    createTime = json['CreateTime'];
    updateTime = json['UpdateTime'];
    hot = json['Hot'];
    img = json['Img'];
    isOnlineUp = json['IsOnlineUp'];
    isOnline = json['IsOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsBook'] = this.isBook;
    data['IsNeedPop'] = this.isNeedPop;
    data['Id'] = this.id;
    data['Title'] = this.title;
    data['TeacherName'] = this.teacherName;
    data['TeacherId'] = this.teacherId;
    data['Introduction'] = this.introduction;
    data['AppName'] = this.appName;
    data['StreamName'] = this.streamName;
    data['OnlineTime'] = this.onlineTime;
    data['BookCount'] = this.bookCount;
    data['Status'] = this.status;
    data['CreateTime'] = this.createTime;
    data['UpdateTime'] = this.updateTime;
    data['Hot'] = this.hot;
    data['Img'] = this.img;
    data['IsOnlineUp'] = this.isOnlineUp;
    data['IsOnline'] = this.isOnline;
    return data;
  }
}