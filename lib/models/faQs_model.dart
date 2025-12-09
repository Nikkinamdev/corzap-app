class FAQsResponse {
  bool? success;
  String? message;
  int? count;
  List<FaqData>? data;

  FAQsResponse({this.success, this.message, this.count, this.data});

  FAQsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    count = json['count'];

    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(FaqData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    map['count'] = count;

    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }

    return map;
  }
}

class FaqData {
  String? id;
  String? category;
  String? question;
  String? answer;
  int? v;
  int? totalYes;

  FaqData({
    this.id,
    this.category,
    this.question,
    this.answer,
    this.v,
    this.totalYes,
  });

  FaqData.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    category = json["category"];
    question = json["question"];
    answer = json["answer"];
    v = json["__v"];
    totalYes = json["totalYes"]; // optional
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};

    map["_id"] = id;
    map["category"] = category;
    map["question"] = question;
    map["answer"] = answer;
    map["__v"] = v;

    if (totalYes != null) {
      map["totalYes"] = totalYes;
    }

    return map;
  }
}
