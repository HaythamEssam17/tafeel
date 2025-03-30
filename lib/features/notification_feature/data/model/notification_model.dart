import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';

List<NotificationModel> notificationListFromJson(List str) =>
    List<NotificationModel>.from(str.map((x) => NotificationModel.fromJson(x)));

class NotificationModel {
  int? id;
  String? title;
  String? description;
  String? icon;
  bool? isRead;
  String? createdAt;

  NotificationModel({
    this.createdAt,
    this.id,
    this.isRead,
    this.icon,
    this.title,
    this.description,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    try {
      return NotificationModel(
        id: json["id"],
        title: json["title"] ?? '',
        description: json["description"] ?? '--',
        icon: json["url"] ?? "",
        isRead: json["is_read"] == 1 ? true : false,
        createdAt: json["date"] ?? DateTime.now().toString(),
      );
    } catch (e) {
      devLog("error when parsing review model $e");
      return NotificationModel();
    }
  }
}
