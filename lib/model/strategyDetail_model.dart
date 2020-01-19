class StrategyDetailModel {
  Data data;
  bool isSuccess;
  String code;
  String message;
  bool isCache;
  Object cacheName;
  Dictionary dictionary;

  StrategyDetailModel(
      {this.data,
      this.isSuccess,
      this.code,
      this.message,
      this.isCache,
      this.cacheName,
      this.dictionary});

  StrategyDetailModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
    isSuccess = json['IsSuccess'];
    code = json['Code'];
    message = json['Message'];
    isCache = json['IsCache'];
    cacheName = json['CacheName'];
    dictionary = json['Dictionary'] != null
        ? new Dictionary.fromJson(json['Dictionary'])
        : null;
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
    if (this.dictionary != null) {
      data['Dictionary'] = this.dictionary.toJson();
    }
    return data;
  }
}

class Data {
  String content;
  int id;
  String smallImageUrl;
  String title;
  String source;
  Object briefContent;
  String createTime;
  int viewCount;
  int replyCount;
  int likeCount;
  int collectCount;
  int categoryId;
  int categoryId2;
  Object categoryId2Str;

  Data(
      {this.content,
      this.id,
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
      this.categoryId2,
      this.categoryId2Str});

  Data.fromJson(Map<String, dynamic> json) {
    content = json['Content'];
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
    data['Content'] = this.content;
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

class Dictionary {
  Point point;

  Dictionary({this.point});

  Dictionary.fromJson(Map<String, dynamic> json) {
    point = json['Point'] != null ? new Point.fromJson(json['Point']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.point != null) {
      data['Point'] = this.point.toJson();
    }
    return data;
  }
}

class Point {
  bool result;
  int point;
  int cB;
  String description;

  Point({this.result, this.point, this.cB, this.description});

  Point.fromJson(Map<String, dynamic> json) {
    result = json['Result'];
    point = json['Point'];
    cB = json['CB'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Result'] = this.result;
    data['Point'] = this.point;
    data['CB'] = this.cB;
    data['Description'] = this.description;
    return data;
  }
}