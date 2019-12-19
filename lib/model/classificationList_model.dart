class ClassificationListModel {
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

  ClassificationListModel(
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

  ClassificationListModel.fromJson(Map<String, dynamic> json) {
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
  int evaluateCount;
  bool isHaveFree;
  int id;
  int categoryId;
  int categoryId2;
  int categoryIdr;
  int categoryIdr2;
  int categoryIdAPP;
  String categoryIdrStr;
  String categoryIdr2Str;
  int goodsType;
  int collegeId;
  String title;
  String smallImageUrl;
  String description;
  int comEvaluate;
  int collegeType;
  int classCount;
  int viewCount;
  int collegePrice;
  int salePrice;
  int sort;
  int teacherId;
  String teacherName;
  String teacherTitle;
  String teacherImg;
  int isExcellentCollege;
  int status;
  Object collegeContent;
  int commission;
  int isGroupBooking;
  int groupBookingPrice;
  int groupBookingCount;
  int hot;
  String onlineTime;
  int bookCount;
  int collectCount;
  int shareCount;

  Data(
      {this.evaluateCount,
      this.isHaveFree,
      this.id,
      this.categoryId,
      this.categoryId2,
      this.categoryIdr,
      this.categoryIdr2,
      this.categoryIdAPP,
      this.categoryIdrStr,
      this.categoryIdr2Str,
      this.goodsType,
      this.collegeId,
      this.title,
      this.smallImageUrl,
      this.description,
      this.comEvaluate,
      this.collegeType,
      this.classCount,
      this.viewCount,
      this.collegePrice,
      this.salePrice,
      this.sort,
      this.teacherId,
      this.teacherName,
      this.teacherTitle,
      this.teacherImg,
      this.isExcellentCollege,
      this.status,
      this.collegeContent,
      this.commission,
      this.isGroupBooking,
      this.groupBookingPrice,
      this.groupBookingCount,
      this.hot,
      this.onlineTime,
      this.bookCount,
      this.collectCount,
      this.shareCount});

  Data.fromJson(Map<String, dynamic> json) {
    evaluateCount = json['EvaluateCount'];
    isHaveFree = json['IsHaveFree'];
    id = json['Id'];
    categoryId = json['CategoryId'];
    categoryId2 = json['CategoryId2'];
    categoryIdr = json['CategoryIdr'];
    categoryIdr2 = json['CategoryIdr2'];
    categoryIdAPP = json['CategoryIdAPP'];
    categoryIdrStr = json['CategoryIdrStr'];
    categoryIdr2Str = json['CategoryIdr2Str'];
    goodsType = json['GoodsType'];
    collegeId = json['CollegeId'];
    title = json['Title'];
    smallImageUrl = json['SmallImageUrl'];
    description = json['Description'];
    comEvaluate = json['ComEvaluate'];
    collegeType = json['CollegeType'];
    classCount = json['ClassCount'];
    viewCount = json['ViewCount'];
    collegePrice = json['CollegePrice'];
    salePrice = json['SalePrice'];
    sort = json['Sort'];
    teacherId = json['TeacherId'];
    teacherName = json['TeacherName'];
    teacherTitle = json['TeacherTitle'];
    teacherImg = json['TeacherImg'];
    isExcellentCollege = json['IsExcellentCollege'];
    status = json['Status'];
    collegeContent = json['CollegeContent'];
    commission = json['Commission'];
    isGroupBooking = json['IsGroupBooking'];
    groupBookingPrice = json['GroupBookingPrice'];
    groupBookingCount = json['GroupBookingCount'];
    hot = json['Hot'];
    onlineTime = json['OnlineTime'];
    bookCount = json['BookCount'];
    shareCount = json['ShareCount'];
    collectCount = json['CollectCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EvaluateCount'] = this.evaluateCount;
    data['IsHaveFree'] = this.isHaveFree;
    data['Id'] = this.id;
    data['CategoryId'] = this.categoryId;
    data['CategoryId2'] = this.categoryId2;
    data['CategoryIdr'] = this.categoryIdr;
    data['CategoryIdr2'] = this.categoryIdr2;
    data['CategoryIdAPP'] = this.categoryIdAPP;
    data['CategoryIdrStr'] = this.categoryIdrStr;
    data['CategoryIdr2Str'] = this.categoryIdr2Str;
    data['GoodsType'] = this.goodsType;
    data['CollegeId'] = this.collegeId;
    data['Title'] = this.title;
    data['SmallImageUrl'] = this.smallImageUrl;
    data['Description'] = this.description;
    data['ComEvaluate'] = this.comEvaluate;
    data['CollegeType'] = this.collegeType;
    data['ClassCount'] = this.classCount;
    data['ViewCount'] = this.viewCount;
    data['CollegePrice'] = this.collegePrice;
    data['SalePrice'] = this.salePrice;
    data['Sort'] = this.sort;
    data['TeacherId'] = this.teacherId;
    data['TeacherName'] = this.teacherName;
    data['TeacherTitle'] = this.teacherTitle;
    data['TeacherImg'] = this.teacherImg;
    data['IsExcellentCollege'] = this.isExcellentCollege;
    data['Status'] = this.status;
    data['CollegeContent'] = this.collegeContent;
    data['Commission'] = this.commission;
    data['IsGroupBooking'] = this.isGroupBooking;
    data['GroupBookingPrice'] = this.groupBookingPrice;
    data['GroupBookingCount'] = this.groupBookingCount;
    data['Hot'] = this.hot;
    data['OnlineTime'] = this.onlineTime;
    data['BookCount'] = this.bookCount;
    data['ShareCount'] = this.shareCount;
    data['CollectCount'] = this.collectCount;
    return data;
  }
}