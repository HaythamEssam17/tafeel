class SignUpEntity {
  String username;
  String email;
  String phone;
  String password;
  String confirmPassword;
  String? token;

  SignUpEntity({
    required this.username,
    required this.email,
    required this.phone,
    required this.confirmPassword,
    required this.password,
    this.token,
  });
}
