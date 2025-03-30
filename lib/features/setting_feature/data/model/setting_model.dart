List<String> stringListFromJson(List str) =>
    List<String>.from(str.map((x) => x['phone']));

class SettingModel {
  String? sitePhone;
  String? siteLogo;
  String? siteDesc;

  String? siteName;
  String? siteEmail;
  List<String>? phoneList;

  SettingModel(
      {this.sitePhone,
      this.siteLogo,
      this.siteDesc,
      this.siteName,
        this.phoneList,
      this.siteEmail});

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
      sitePhone: json["site_phone"],
      siteLogo: json["site_logo"],
      siteDesc: json["site_description"],
      siteEmail: json["site_email"],
      phoneList: stringListFromJson(json["phones"] ?? []) ,
      siteName: json["site_name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "site_phone": sitePhone,
        "site_logo": siteLogo,
        "site_description": siteDesc,
        "site_email": siteEmail,
        "site_name": siteName,
      };
}
