class EvaluationListModel {
  int pageSize;
  int pageIndex;
  int totalCount;
  List<EvaluationListDataModel> data;
  bool isSuccess;
  String code;
  String message;
  bool isCache;
  Object cacheName;
  Object dictionary;

  EvaluationListModel(
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

  EvaluationListModel.fromJson(Map<String, dynamic> json) {
    pageSize = json['PageSize'];
    pageIndex = json['PageIndex'];
    totalCount = json['TotalCount'];
    if (json['Data'] != null) {
      data = new List<EvaluationListDataModel>();
      json['Data'].forEach((v) {
        data.add(new EvaluationListDataModel.fromJson(v));
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

class EvaluationListDataModel {
  int id;
  int userId;
  String userName;
  int score;
  String content;
  int replyId;
  String logoUrl;
  int status;
  String createTime;
  int isTop;
  int isReply;
  List<ReplyList> replyList;

  EvaluationListDataModel(
      {this.id,
      this.userId,
      this.userName,
      this.score,
      this.content,
      this.replyId,
      this.logoUrl,
      this.status,
      this.createTime,
      this.isTop,
      this.isReply,
      this.replyList});

  EvaluationListDataModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userId = json['UserId'];
    userName = json['UserName'];
    score = json['Score'];
    content = json['Content'];
    replyId = json['ReplyId'];
    logoUrl = json['LogoUrl'];
    status = json['Status'];
    createTime = json['CreateTime'];
    isTop = json['IsTop'];
    isReply = json['IsReply'];
    if (json['ReplyList'] != null) {
      replyList = new List<ReplyList>();
      json['ReplyList'].forEach((v) {
        replyList.add(new ReplyList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['Score'] = this.score;
    data['Content'] = this.content;
    data['ReplyId'] = this.replyId;
    data['LogoUrl'] = this.logoUrl;
    data['Status'] = this.status;
    data['CreateTime'] = this.createTime;
    data['IsTop'] = this.isTop;
    data['IsReply'] = this.isReply;
    if (this.replyList != null) {
      data['ReplyList'] = this.replyList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReplyList {
  int id;
  int userId;
  String userName;
  int score;
  String content;
  int replyId;
  String logoUrl;
  int status;
  String createTime;
  int isTop;
  int isReply;
  Object replyList;

  ReplyList(
      {this.id,
      this.userId,
      this.userName,
      this.score,
      this.content,
      this.replyId,
      this.logoUrl,
      this.status,
      this.createTime,
      this.isTop,
      this.isReply,
      this.replyList});

  ReplyList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userId = json['UserId'];
    userName = json['UserName'];
    score = json['Score'];
    content = json['Content'];
    replyId = json['ReplyId'];
    logoUrl = json['LogoUrl'];
    status = json['Status'];
    createTime = json['CreateTime'];
    isTop = json['IsTop'];
    isReply = json['IsReply'];
    replyList = json['ReplyList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['Score'] = this.score;
    data['Content'] = this.content;
    data['ReplyId'] = this.replyId;
    data['LogoUrl'] = this.logoUrl;
    data['Status'] = this.status;
    data['CreateTime'] = this.createTime;
    data['IsTop'] = this.isTop;
    data['IsReply'] = this.isReply;
    data['ReplyList'] = this.replyList;
    return data;
  }
}