class MyPointinfoModel {
  int pageSize;
  int pageIndex;
  int totalCount;
  List<Data> data;
  bool isSuccess;
  String code;
  String message;
  bool isCache;
  Object cacheName;
  Object dictionary;

  MyPointinfoModel(
      {this.pageSize,
      this.pageIndex,
      this.totalCount,
      this.data,
      this.isSuccess,
      this.code,
      this.message,
      this.isCache,
      this.cacheName,
      this.dictionary});

  MyPointinfoModel.fromJson(Map<String, dynamic> json) {
    pageSize = json['PageSize'];
    pageIndex = json['PageIndex'];
    totalCount = json['TotalCount'];
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
    data['PageSize'] = this.pageSize;
    data['PageIndex'] = this.pageIndex;
    data['TotalCount'] = this.totalCount;
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
  String createTime;
  int id;
  int userId;
  int operType;
  int operFrom;
  String operDes;
  int operPoint;
  int extend;
  int extend2;
  int extend3;

  Data(
      {this.createTime,
      this.id,
      this.userId,
      this.operType,
      this.operFrom,
      this.operDes,
      this.operPoint,
      this.extend,
      this.extend2,
      this.extend3});

  Data.fromJson(Map<String, dynamic> json) {
    createTime = json['CreateTime'];
    id = json['Id'];
    userId = json['UserId'];
    operType = json['OperType'];
    operFrom = json['OperFrom'];
    operDes = json['OperDes'];
    operPoint = json['OperPoint'];
    extend = json['Extend'];
    extend2 = json['Extend2'];
    extend3 = json['Extend3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CreateTime'] = this.createTime;
    data['Id'] = this.id;
    data['UserId'] = this.userId;
    data['OperType'] = this.operType;
    data['OperFrom'] = this.operFrom;
    data['OperDes'] = this.operDes;
    data['OperPoint'] = this.operPoint;
    data['Extend'] = this.extend;
    data['Extend2'] = this.extend2;
    data['Extend3'] = this.extend3;
    return data;
  }
}