class HotListModel {
  List<Data> data;
  bool isSuccess;
  String code;
  String message;
  bool isCache;
  Object cacheName;
  Object dictionary;

  HotListModel(
      {this.data,
      this.isSuccess,
      this.code,
      this.message,
      this.isCache,
      this.cacheName,
      this.dictionary});

  HotListModel.fromJson(Map<String, dynamic> json) {
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
  String title;
  int collgeId;
  String teacherName;
  int viewCount;
  int sort;

  Data(
      {this.title, this.collgeId, this.teacherName, this.viewCount, this.sort});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    collgeId = json['CollgeId'];
    teacherName = json['TeacherName'];
    viewCount = json['ViewCount'];
    sort = json['Sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['CollgeId'] = this.collgeId;
    data['TeacherName'] = this.teacherName;
    data['ViewCount'] = this.viewCount;
    data['Sort'] = this.sort;
    return data;
  }
}