class AppSecurityModel {
  AppSecurityModel({
    this.canMockLocation = false,
    this.isEmulated = false,
    this.isRooted = false,
    this.onDevMode = false,
    this.onExternalStorage = false,
  });

  bool isEmulated;
  bool canMockLocation;
  bool onExternalStorage;
  bool isRooted;
  bool onDevMode;
}
