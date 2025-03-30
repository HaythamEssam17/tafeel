class ApiKeys {
  /// user type key
  static const String userTypeKey = "/customer";
  static const String notificationKey = "/notifications";
  static const String generalKey = "/general";

  ///Auth Keys
  static const String loginKey = "$userTypeKey/login";
  static const String singUpKey = "$userTypeKey/register";
  static const String logOutKey = "$userTypeKey/logout";

  ///profile keys
  static const String profileKey = "$userTypeKey/profile";
  static const String updateProfileKey = "$profileKey/update";
  static const String deleteProfileKey = "$userTypeKey/delete";
  static const String deletePhotoProfileKey = "$userTypeKey/delete-image";

  ///Password keys
  static const String changePasswordKey = "$userTypeKey/changePassword";
  static const String forgetPasswordKey = "$userTypeKey/forgetPassword";
  static const String resetPasswordKey = "$userTypeKey/resetPassword";
  static const String checkPasswordKey = "$userTypeKey/profile/checkPassword";

  ///Otp Keys
  static const String checkAndVerifyKey = "$userTypeKey/checkOtpAndActivate";
  static const String sendOtpKey = "$userTypeKey/sendOtp";
  static const String checkOtpKey = "$userTypeKey/checkOtp";
  static const String reSendOtpKey = "$userTypeKey/resend-otp";

  ///notification keys
  static const String clearNotificationKey = "$notificationKey/clear";
  static const String toggleNotificationKey = "$notificationKey/toggle";
  static const String readNotificationKey = "/read";

  ///Setting keys
  static const String questionKey = "$generalKey/question/index";
  static const String answerKey = "$generalKey/answer/index";

  ///Setting
  static const String settingKey = "$generalKey/settings";

  /// Reasons
  static const String reasonsKey = '/status/show';

  /// Phone
  static const String changePhoneKey = '$userTypeKey/profile/changePhone';

  ///Terms and conditions
  static const String termsAndConditionsKey = "/blocks/terms";
  static const String refundPolicyKey = "/blocks/refund";
  static const String privacyPolicyKey = "/blocks/privacy";
}
