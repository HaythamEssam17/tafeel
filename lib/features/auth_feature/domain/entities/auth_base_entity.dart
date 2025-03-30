
class AuthBaseEntity {
  int? id;
  String? name;
  String? userCredential;
  String? email;
  String? phone;
  int? active;
  int? verified;
  String? image;
  String? otp;
  String? gender;
  String? token;

  String? password;
  String? newPassword;
  String? confirmPassword;
  bool? isNotified;
  String? referCode;
  String? balance;

  AuthBaseEntity(
      {this.name,
      this.email,
      this.phone,
      this.userCredential,
      this.active,
      this.verified,
      this.id,
      this.image,
      this.otp,
      this.gender,
      this.token,
      this.confirmPassword,
      this.newPassword,
      this.password,

      this.balance,
      this.isNotified,

      this.referCode});

  @override
  String toString() {
    return 'AuthBaseEntity{id: $id, name: $name, userCredential: $userCredential, email: $email, phone: $phone, active: $active, verified: $verified, image: $image, otp: $otp, gender: $gender, token: $token, password: $password, newPassword: $newPassword, confirmPassword: $confirmPassword, isNotified: $isNotified, referCode: $referCode, balance: $balance}';
  }
}
