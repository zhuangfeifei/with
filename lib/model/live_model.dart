class LiveModel {
  Data data;
  bool isSuccess;
  String code;
  String message;
  bool isCache;
  Object cacheName;
  Object dictionary;

  LiveModel(
      {this.data,
      this.isSuccess,
      this.code,
      this.message,
      this.isCache,
      this.cacheName,
      this.dictionary});

  LiveModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
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
      data['Data'] = this.data.toJson();
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
  String playUrl;
  int ctRoomGroupId;
  List<LsRoomDataList> lsRoomDataList;
  int id;
  String title;
  int teacherId;
  String teacherName;
  String teacherImg;
  String introduction;
  String onlineTime;
  int bookCount;
  int status;
  int hot;
  String img;
  bool isBook;
  int isOnline;

  Data(
      {this.playUrl,
      this.ctRoomGroupId,
      this.lsRoomDataList,
      this.id,
      this.title,
      this.teacherId,
      this.teacherName,
      this.teacherImg,
      this.introduction,
      this.onlineTime,
      this.bookCount,
      this.status,
      this.hot,
      this.img,
      this.isBook,
      this.isOnline});

  Data.fromJson(Map<String, dynamic> json) {
    playUrl = json['PlayUrl'];
    ctRoomGroupId = json['CtRoomGroupId'];
    if (json['LsRoomDataList'] != null) {
      lsRoomDataList = new List<LsRoomDataList>();
      json['LsRoomDataList'].forEach((v) {
        lsRoomDataList.add(new LsRoomDataList.fromJson(v));
      });
    }
    id = json['Id'];
    title = json['Title'];
    teacherId = json['TeacherId'];
    teacherName = json['TeacherName'];
    teacherImg = json['TeacherImg'];
    introduction = json['Introduction'];
    onlineTime = json['OnlineTime'];
    bookCount = json['BookCount'];
    status = json['Status'];
    hot = json['Hot'];
    img = json['Img'];
    isBook = json['IsBook'];
    isOnline = json['IsOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PlayUrl'] = this.playUrl;
    data['CtRoomGroupId'] = this.ctRoomGroupId;
    if (this.lsRoomDataList != null) {
      data['LsRoomDataList'] =
          this.lsRoomDataList.map((v) => v.toJson()).toList();
    }
    data['Id'] = this.id;
    data['Title'] = this.title;
    data['TeacherId'] = this.teacherId;
    data['TeacherName'] = this.teacherName;
    data['TeacherImg'] = this.teacherImg;
    data['Introduction'] = this.introduction;
    data['OnlineTime'] = this.onlineTime;
    data['BookCount'] = this.bookCount;
    data['Status'] = this.status;
    data['Hot'] = this.hot;
    data['Img'] = this.img;
    data['IsBook'] = this.isBook;
    data['IsOnline'] = this.isOnline;
    return data;
  }
}

class LsRoomDataList {
  int id;
  int lsRoomId;
  String fileName;
  String url;
  String remark;
  String size;
  int type;
  int dataFlag;
  int flag;

  LsRoomDataList(
      {this.id,
      this.lsRoomId,
      this.fileName,
      this.url,
      this.remark,
      this.size,
      this.type,
      this.dataFlag,
      this.flag});

  LsRoomDataList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    lsRoomId = json['LsRoomId'];
    fileName = json['FileName'];
    url = json['Url'];
    remark = json['Remark'];
    size = json['Size'];
    type = json['Type'];
    dataFlag = json['DataFlag'];
    flag = json['Flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['LsRoomId'] = this.lsRoomId;
    data['FileName'] = this.fileName;
    data['Url'] = this.url;
    data['Remark'] = this.remark;
    data['Size'] = this.size;
    data['Type'] = this.type;
    data['DataFlag'] = this.dataFlag;
    data['Flag'] = this.flag;
    return data;
  }
}