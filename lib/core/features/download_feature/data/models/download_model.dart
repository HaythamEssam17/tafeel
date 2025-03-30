import 'package:flutter_downloader/flutter_downloader.dart';

List<DownloadModel> downloadListFromJson(List str) =>
    List<DownloadModel>.from(str.map((x) => DownloadModel.fromJson(x)));

class DownloadModel {
  DownloadModel({this.id, this.title, this.url, this.description, this.user});

  String? url;
  String? id;
  String? title;
  int? user;
  String? description;

  int? progress = 0;
  DownloadTaskStatus status = DownloadTaskStatus.undefined;

  DownloadTaskStatus setStatus(DownloadTaskStatus downloadTaskStatus) {
    return status = downloadTaskStatus;
  }

  DownloadTaskStatus get getStatus => status;

  factory DownloadModel.fromJson(Map<String, dynamic> json) {
    return DownloadModel(
      title: json['title'] ?? 'download file title',
      url: json['url'] ?? '',
      user: json["user"] ?? 0,
      description: json["description"] ?? 'download file description',
      id: json['id'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "title": title,
        "user": user,
        "description": description,
        "id": id,
      };
}
