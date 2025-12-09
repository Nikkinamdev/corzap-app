class GetCompanyModel {
  bool? success;
  String? message;
  Data? data;

  GetCompanyModel({this.success, this.message, this.data});

  GetCompanyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? companyName;
  String? address;
  String? contactNumber;
  String? whatsappNumber;
  String? privacyPolicy;
  String? termAndCondition;
  String? helpandSupport;
  String? aboutUs;
  String? supportEmail;
  String? description;
  String? logo;
  String? favIcon;
  String? website;
  String? timing;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? role;

  Data(
      {this.sId,
        this.companyName,
        this.address,
        this.contactNumber,
        this.whatsappNumber,
        this.privacyPolicy,
        this.termAndCondition,
        this.helpandSupport,
        this.aboutUs,
        this.supportEmail,
        this.description,
        this.logo,
        this.favIcon,
        this.website,
        this.timing,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.role});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    companyName = json['companyName'];
    address = json['address'];
    contactNumber = json['contactNumber'];
    whatsappNumber = json['whatsappNumber'];
    privacyPolicy = json['privacyPolicy'];
    termAndCondition = json['termAndCondition'];
    helpandSupport = json['helpandSupport'];
    aboutUs = json['aboutUs'];
    supportEmail = json['supportEmail'];
    description = json['description'];
    logo = json['logo'];
    favIcon = json['favIcon'];
    website = json['website'];
    timing = json['timing'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['companyName'] = this.companyName;
    data['address'] = this.address;
    data['contactNumber'] = this.contactNumber;
    data['whatsappNumber'] = this.whatsappNumber;
    data['privacyPolicy'] = this.privacyPolicy;
    data['termAndCondition'] = this.termAndCondition;
    data['helpandSupport'] = this.helpandSupport;
    data['aboutUs'] = this.aboutUs;
    data['supportEmail'] = this.supportEmail;
    data['description'] = this.description;
    data['logo'] = this.logo;
    data['favIcon'] = this.favIcon;
    data['website'] = this.website;
    data['timing'] = this.timing;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['role'] = this.role;
    return data;
  }
}
