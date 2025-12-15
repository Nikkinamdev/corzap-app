import 'dart:convert';

RideHistoryModel rideHistoryModelFromJson(String str) =>
    RideHistoryModel.fromJson(json.decode(str));

String rideHistoryModelToJson(RideHistoryModel data) =>
    json.encode(data.toJson());

class RideHistoryModel {
  bool? status;
  String? message;
  List<RideData>? data;

  RideHistoryModel({
    this.status,
    this.message,
    this.data,
  });

  factory RideHistoryModel.fromJson(Map<String, dynamic> json) =>
      RideHistoryModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<RideData>.from(
            json["data"].map((x) => RideData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class RideData {
  String? id;
  String? userName;
  String? userPhone;
  String? pickup;
  String? drop;
  String? distance;
  String? amount;
  String? paymentMethod;
  String? status;
  String? date;

  RideData({
    this.id,
    this.userName,
    this.userPhone,
    this.pickup,
    this.drop,
    this.distance,
    this.amount,
    this.paymentMethod,
    this.status,
    this.date,
  });

  factory RideData.fromJson(Map<String, dynamic> json) => RideData(
    id: json["_id"].toString(),
    userName: json["userName"] ?? "",
    userPhone: json["userPhone"] ?? "",
    pickup: json["pickupAddress"] ?? "",
    drop: json["dropAddress"] ?? "",
    distance: json["distance"].toString(),
    amount: json["amount"].toString(),
    paymentMethod: json["paymentMethod"] ?? "",
    status: json["status"] ?? "",
    date: json["createdAt"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userName": userName,
    "userPhone": userPhone,
    "pickupAddress": pickup,
    "dropAddress": drop,
    "distance": distance,
    "amount": amount,
    "paymentMethod": paymentMethod,
    "status": status,
    "createdAt": date,
  };
}
