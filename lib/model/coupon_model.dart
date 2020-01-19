class CouponModel {
  List<CouponModelData> data;
  bool isSuccess;
  String code;
  String message;
  bool isCache;
  Object cacheName;
  Object dictionary;

  CouponModel(
      {this.data,
      this.isSuccess,
      this.code,
      this.message,
      this.isCache,
      this.cacheName,
      this.dictionary});

  CouponModel.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = new List<CouponModelData>();
      json['Data'].forEach((v) {
        data.add(new CouponModelData.fromJson(v));
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

class CouponModelData {
  int id;
  int price;
  int limitPrice;
  int limitDay;
  String couponTitle;
  String couponDes;
  String startTime;
  String endTime;
  int status;
  int useStatus;
  String createTime;
  int salePoint;

  CouponModelData(
      {this.id,
      this.price,
      this.limitPrice,
      this.limitDay,
      this.couponTitle,
      this.couponDes,
      this.startTime,
      this.endTime,
      this.status,
      this.useStatus,
      this.createTime,
      this.salePoint});

  CouponModelData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    price = json['Price'];
    limitPrice = json['LimitPrice'];
    limitDay = json['LimitDay'];
    couponTitle = json['CouponTitle'];
    couponDes = json['CouponDes'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    status = json['Status'];
    useStatus = json['UseStatus'];
    createTime = json['CreateTime'];
    salePoint = json['SalePoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Price'] = this.price;
    data['LimitPrice'] = this.limitPrice;
    data['LimitDay'] = this.limitDay;
    data['CouponTitle'] = this.couponTitle;
    data['CouponDes'] = this.couponDes;
    data['StartTime'] = this.startTime;
    data['EndTime'] = this.endTime;
    data['Status'] = this.status;
    data['UseStatus'] = this.useStatus;
    data['CreateTime'] = this.createTime;
    data['SalePoint'] = this.salePoint;
    return data;
  }
}