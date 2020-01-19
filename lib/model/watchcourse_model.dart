class WatchcourseModel {
  Data data;
  bool isSuccess;
  String code;
  String message;
  bool isCache;
  Object cacheName;
  Object dictionary;

  WatchcourseModel(
      {this.data,
      this.isSuccess,
      this.code,
      this.message,
      this.isCache,
      this.cacheName,
      this.dictionary});

  WatchcourseModel.fromJson(Map<String, dynamic> json) {
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
  int evaluateCount;
  bool isCollect;
  OrderSatus orderSatus;
  Object extendInfo;
  int studyNow;
  int lastStudyClass;
  List<CollegeClass> collegeClass;
  TeacherInfo teacherInfo;
  Object relCollege;
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
  String collegeContent;
  int commission;
  int isGroupBooking;
  int groupBookingPrice;
  int groupBookingCount;
  int hot;
  String onlineTime;
  int bookCount;
  int shareCount;
  int collectCount;

  Data(
      {this.evaluateCount,
      this.isCollect,
      this.orderSatus,
      this.extendInfo,
      this.studyNow,
      this.lastStudyClass,
      this.collegeClass,
      this.teacherInfo,
      this.relCollege,
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
      this.shareCount,
      this.collectCount});

  Data.fromJson(Map<String, dynamic> json) {
    evaluateCount = json['EvaluateCount'];
    isCollect = json['IsCollect'];
    orderSatus = json['OrderSatus'] != null
        ? new OrderSatus.fromJson(json['OrderSatus'])
        : null;
    extendInfo = json['ExtendInfo'];
    studyNow = json['StudyNow'];
    lastStudyClass = json['LastStudyClass'];
    if (json['CollegeClass'] != null) {
      collegeClass = new List<CollegeClass>();
      json['CollegeClass'].forEach((v) {
        collegeClass.add(new CollegeClass.fromJson(v));
      });
    }
    teacherInfo = json['TeacherInfo'] != null
        ? new TeacherInfo.fromJson(json['TeacherInfo'])
        : null;
    relCollege = json['RelCollege'];
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
    data['IsCollect'] = this.isCollect;
    if (this.orderSatus != null) {
      data['OrderSatus'] = this.orderSatus.toJson();
    }
    data['ExtendInfo'] = this.extendInfo;
    data['StudyNow'] = this.studyNow;
    data['LastStudyClass'] = this.lastStudyClass;
    if (this.collegeClass != null) {
      data['CollegeClass'] = this.collegeClass.map((v) => v.toJson()).toList();
    }
    if (this.teacherInfo != null) {
      data['TeacherInfo'] = this.teacherInfo.toJson();
    }
    data['RelCollege'] = this.relCollege;
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

class OrderSatus {
  int orderStatus;
  String orderStatusMsg;
  int groupBookingId;
  String groupBookingCountDown;
  String groupBookingWaitOtherPayTime;
  int goodsType;
  int goodsId;

  OrderSatus(
      {this.orderStatus,
      this.orderStatusMsg,
      this.groupBookingId,
      this.groupBookingCountDown,
      this.groupBookingWaitOtherPayTime,
      this.goodsType,
      this.goodsId});

  OrderSatus.fromJson(Map<String, dynamic> json) {
    orderStatus = json['OrderStatus'];
    orderStatusMsg = json['OrderStatusMsg'];
    groupBookingId = json['GroupBookingId'];
    groupBookingCountDown = json['GroupBookingCountDown'];
    groupBookingWaitOtherPayTime = json['GroupBookingWaitOtherPayTime'];
    goodsType = json['GoodsType'];
    goodsId = json['GoodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrderStatus'] = this.orderStatus;
    data['OrderStatusMsg'] = this.orderStatusMsg;
    data['GroupBookingId'] = this.groupBookingId;
    data['GroupBookingCountDown'] = this.groupBookingCountDown;
    data['GroupBookingWaitOtherPayTime'] = this.groupBookingWaitOtherPayTime;
    data['GoodsType'] = this.goodsType;
    data['GoodsId'] = this.goodsId;
    return data;
  }
}

class CollegeClass {
  int classId;
  String className;
  String classDetail;
  String videoUrl;
  List<VideoUrlList> videoUrlList;
  bool isFree;
  String soundUrl;
  String videoId;
  bool isEn;
  int sort;
  String classTimeLong;

  CollegeClass(
      {this.classId,
      this.className,
      this.classDetail,
      this.videoUrl,
      this.videoUrlList,
      this.isFree,
      this.soundUrl,
      this.videoId,
      this.isEn,
      this.sort,
      this.classTimeLong});

  CollegeClass.fromJson(Map<String, dynamic> json) {
    classId = json['ClassId'];
    className = json['ClassName'];
    classDetail = json['ClassDetail'];
    videoUrl = json['VideoUrl'];
    if (json['VideoUrlList'] != null) {
      videoUrlList = new List<VideoUrlList>();
      json['VideoUrlList'].forEach((v) {
        videoUrlList.add(new VideoUrlList.fromJson(v));
      });
    }
    isFree = json['IsFree'];
    soundUrl = json['SoundUrl'];
    videoId = json['VideoId'];
    isEn = json['IsEn'];
    sort = json['Sort'];
    classTimeLong = json['ClassTimeLong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassId'] = this.classId;
    data['ClassName'] = this.className;
    data['ClassDetail'] = this.classDetail;
    data['VideoUrl'] = this.videoUrl;
    if (this.videoUrlList != null) {
      data['VideoUrlList'] = this.videoUrlList.map((v) => v.toJson()).toList();
    }
    data['IsFree'] = this.isFree;
    data['SoundUrl'] = this.soundUrl;
    data['VideoId'] = this.videoId;
    data['IsEn'] = this.isEn;
    data['Sort'] = this.sort;
    data['ClassTimeLong'] = this.classTimeLong;
    return data;
  }
}

class VideoUrlList {
  String url;
  String typeName;
  String timeLong;

  VideoUrlList({this.url, this.typeName, this.timeLong});

  VideoUrlList.fromJson(Map<String, dynamic> json) {
    url = json['Url'];
    typeName = json['TypeName'];
    timeLong = json['TimeLong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Url'] = this.url;
    data['TypeName'] = this.typeName;
    data['TimeLong'] = this.timeLong;
    return data;
  }
}

class TeacherInfo {
  String logoUrl;
  String name;
  String title;
  String tags;
  int targetType;

  TeacherInfo(
      {this.logoUrl, this.name, this.title, this.tags, this.targetType});

  TeacherInfo.fromJson(Map<String, dynamic> json) {
    logoUrl = json['LogoUrl'];
    name = json['Name'];
    title = json['Title'];
    tags = json['Tags'];
    targetType = json['TargetType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LogoUrl'] = this.logoUrl;
    data['Name'] = this.name;
    data['Title'] = this.title;
    data['Tags'] = this.tags;
    data['TargetType'] = this.targetType;
    return data;
  }
}