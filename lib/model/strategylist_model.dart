class StrategylistModel {
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

  StrategylistModel(
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

  StrategylistModel.fromJson(Map<String, dynamic> json) {
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
  int id;
  String smallImageUrl;
  String title;
  String source;
  String briefContent;
  String createTime;
  int viewCount;
  int replyCount;
  int likeCount;
  int collectCount;
  int categoryId;
  int categoryId2;
  Object categoryId2Str;

  Data(
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
      this.categoryId2,
      this.categoryId2Str});

  Data.fromJson(Map<String, dynamic> json) {
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