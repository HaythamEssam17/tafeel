import 'user_model.dart';

class UsersResponseModel {
  final int? page;
  final int? perPage;
  final int? total;
  final int? totalPages;
  final List<UserModel>? users;

  UsersResponseModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.users,
  });

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) {
    return UsersResponseModel(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      users:
          (json['data'] as List)
              .map((userJson) => UserModel.fromJson(userJson))
              .toList(),
    );
  }
}
