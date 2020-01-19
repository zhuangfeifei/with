class MyConsumptionModel {
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

  MyConsumptionModel(
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

  MyConsumptionModel.fromJson(Map<String, dynamic> json) {
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
  String title;
  String dateTime;
  String dateTime2;
  int cB;
  int goodsId;
  int goodsType;
  String goodsName;
  String description;
  int couponId;
  int couponPrice;
  int price;
  int salePrice;
  int payAmount;
  int orderStatus;
  int groupBookingStatus;
  Object extendInfo;

  Data(
      {this.title,
      this.dateTime,
      this.dateTime2,
      this.cB,
      this.goodsId,
      this.goodsType,
      this.goodsName,
      this.description,
      this.couponId,
      this.couponPrice,
      this.price,
      this.salePrice,
      this.payAmount,
      this.orderStatus,
      this.groupBookingStatus,
      this.extendInfo});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    dateTime = json['DateTime'];
    dateTime2 = json['DateTime2'];
    cB = json['CB'];
    goodsId = json['GoodsId'];
    goodsType = json['GoodsType'];
    goodsName = json['GoodsName'];
    description = json['Description'];
    couponId = json['CouponId'];
    couponPrice = json['CouponPrice'];
    price = json['Price'];
    salePrice = json['SalePrice'];
    payAmount = json['PayAmount'];
    orderStatus = json['OrderStatus'];
    groupBookingStatus = json['GroupBookingStatus'];
    extendInfo = json['ExtendInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['DateTime'] = this.dateTime;
    data['DateTime2'] = this.dateTime2;
    data['CB'] = this.cB;
    data['GoodsId'] = this.goodsId;
    data['GoodsType'] = this.goodsType;
    data['GoodsName'] = this.goodsName;
    data['Description'] = this.description;
    data['CouponId'] = this.couponId;
    data['CouponPrice'] = this.couponPrice;
    data['Price'] = this.price;
    data['SalePrice'] = this.salePrice;
    data['PayAmount'] = this.payAmount;
    data['OrderStatus'] = this.orderStatus;
    data['GroupBookingStatus'] = this.groupBookingStatus;
    data['ExtendInfo'] = this.extendInfo;
    return data;
  }
}