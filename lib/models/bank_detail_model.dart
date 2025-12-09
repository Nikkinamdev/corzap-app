class BankDetailsModel {
  bool? success;
  String? message;
  int? count;
  List<Data>? data;

  BankDetailsModel({this.success, this.message, this.count, this.data});

  BankDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  DriverId? driverId;
  String? bankName;
  String? accountNumber;
  String? ifscCode;
  String? accountHolderName;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.driverId,
        this.bankName,
        this.accountNumber,
        this.ifscCode,
        this.accountHolderName,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    driverId = json['driverId'] != null
        ? new DriverId.fromJson(json['driverId'])
        : null;
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    ifscCode = json['ifscCode'];
    accountHolderName = json['accountHolderName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.driverId != null) {
      data['driverId'] = this.driverId!.toJson();
    }
    data['bankName'] = this.bankName;
    data['accountNumber'] = this.accountNumber;
    data['ifscCode'] = this.ifscCode;
    data['accountHolderName'] = this.accountHolderName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class DriverId {
  String? sId;
  String? name;
  String? phone;

  DriverId({this.sId, this.name, this.phone});

  DriverId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}
