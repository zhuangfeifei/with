class HomeModel {
  Data data;
  bool isSuccess;
  String code;
  String message;
  bool isCache;
  String cacheName;
  Object dictionary;

  HomeModel(
      {this.data,
      this.isSuccess,
      this.code,
      this.message,
      this.isCache,
      this.cacheName,
      this.dictionary});

  HomeModel.fromJson(Map<String, dynamic> json) {
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
  List<BannerList> bannerList;
  List<BookCollegeList> latestCollegeList;
  List<BookCollegeList> bookCollegeList;
  List<BookLsRoomList> bookLsRoomList;
  List<HotCollegeList> hotCollegeList;
  List<KJGLList> kJGLList;

  Data(
      {this.bannerList,
      this.latestCollegeList,
      this.bookCollegeList,
      this.bookLsRoomList,
      this.hotCollegeList,
      this.kJGLList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['BannerList'] != null) {
      bannerList = new List<BannerList>();
      json['BannerList'].forEach((v) {
        bannerList.add(new BannerList.fromJson(v));
      });
    }
    if (json['LatestCollegeList'] != null) {
      latestCollegeList = new List<BookCollegeList>();
      json['LatestCollegeList'].forEach((v) {
        latestCollegeList.add(new BookCollegeList.fromJson(v));
      });
    }
    if (json['BookCollegeList'] != null) {
      bookCollegeList = new List<BookCollegeList>();
      json['BookCollegeList'].forEach((v) {
        bookCollegeList.add(new BookCollegeList.fromJson(v));
      });
    }
    if (json['BookLsRoomList'] != null) {
      bookLsRoomList = new List<BookLsRoomList>();
      json['BookLsRoomList'].forEach((v) {
        bookLsRoomList.add(new BookLsRoomList.fromJson(v));
      });
    }
    if (json['HotCollegeList'] != null) {
      hotCollegeList = new List<HotCollegeList>();
      json['HotCollegeList'].forEach((v) {
        hotCollegeList.add(new HotCollegeList.fromJson(v));
      });
    }
    if (json['KJGLList'] != null) {
      kJGLList = new List<KJGLList>();
      json['KJGLList'].forEach((v) {
        kJGLList.add(new KJGLList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bannerList != null) {
      data['BannerList'] = this.bannerList.map((v) => v.toJson()).toList();
    }
    if (this.latestCollegeList != null) {
      data['LatestCollegeList'] =
          this.latestCollegeList.map((v) => v.toJson()).toList();
    }
    if (this.bookCollegeList != null) {
      data['BookCollegeList'] =
          this.bookCollegeList.map((v) => v.toJson()).toList();
    }
    if (this.bookLsRoomList != null) {
      data['BookLsRoomList'] =
          this.bookLsRoomList.map((v) => v.toJson()).toList();
    }
    if (this.hotCollegeList != null) {
      data['HotCollegeList'] =
          this.hotCollegeList.map((v) => v.toJson()).toList();
    }
    if (this.kJGLList != null) {
      data['KJGLList'] = this.kJGLList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerList {
  String imageUrl;
  int sort;
  String jumpInfo;

  BannerList({this.imageUrl, this.sort, this.jumpInfo});

  BannerList.fromJson(Map<String, dynamic> json) {
    imageUrl = json['ImageUrl'];
    sort = json['Sort'];
    jumpInfo = json['JumpInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ImageUrl'] = this.imageUrl;
    data['Sort'] = this.sort;
    data['JumpInfo'] = this.jumpInfo;
    return data;
  }
}

class BookCollegeList {
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
  int shareCount;

  BookCollegeList(
      {this.id,
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
      this.shareCount});

  BookCollegeList.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    return data;
  }
}

class BookLsRoomList {
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

  BookLsRoomList(
      {this.id,
      this.title,
      this.teacherId,
      this.teacherName,
      this.teacherImg,
      this.introduction,
      this.onlineTime,
      this.bookCount,
      this.status,
      this.hot,
      this.isBook,
      this.img});

  BookLsRoomList.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    return data;
  }
}

class KJGLList {
  int id;
  String smallImageUrl;
  String title;
  String source;
  String briefContent;
  String createTime;
  String categoryId2Str;
  int viewCount;
  int replyCount;
  int likeCount;
  int collectCount;
  int categoryId;
  int categoryId2;

  KJGLList(
      {this.id,
      this.smallImageUrl,
      this.title,
      this.source,
      this.briefContent,
      this.createTime,
      this.viewCount,
      this.replyCount,
      this.likeCount,
      this.collectCount,
      this.categoryId,
      this.categoryId2Str,
      this.categoryId2});

  KJGLList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    smallImageUrl = json['SmallImageUrl'];
    title = json['Title'];
    source = json['Source'];
    briefContent = json['BriefContent'];
    createTime = json['CreateTime'];
    viewCount = json['ViewCount'];
    replyCount = json['ReplyCount'];
    likeCount = json['LikeCount'];
    collectCount = json['CollectCount'];
    categoryId = json['CategoryId'];
    categoryId2 = json['CategoryId2'];
    categoryId2Str = json['CategoryId2Str'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['SmallImageUrl'] = this.smallImageUrl;
    data['Title'] = this.title;
    data['Source'] = this.source;
    data['BriefContent'] = this.briefContent;
    data['CreateTime'] = this.createTime;
    data['ViewCount'] = this.viewCount;
    data['ReplyCount'] = this.replyCount;
    data['LikeCount'] = this.likeCount;
    data['CollectCount'] = this.collectCount;
    data['CategoryId'] = this.categoryId;
    data['CategoryId2'] = this.categoryId2;
    data['CategoryId2Str'] = this.categoryId2Str;
    return data;
  }
}


class HotCollegeList {
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

  HotCollegeList(
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

  HotCollegeList.fromJson(Map<String, dynamic> json) {
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
