import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants/enums/reason_key_enum.dart';

class RouteArgument {
  String? id;
  String? sourcePage;
  String? imagePath;
  String? userCredential;
  ReasonKey? reasonsKey;

  Widget? mainBody;
  PreferredSizeWidget? appBar;

  /// Appbar
  bool? withBack;
  bool? withActions;
  bool? withAppBar;
  Widget? titleWidget;

  /// Functions
  Function()? onTap;
  String? otp;

  LatLng? location;

  ///Terms
  String? screenName;
  String? endPoint;

  RouteArgument({
    this.id,
    this.sourcePage = '',
    this.appBar = const PreferredSize(preferredSize: Size.fromHeight(0), child: SizedBox()),
    this.mainBody,
    this.titleWidget,
    this.withBack = false,
    this.withActions = false,
    this.withAppBar = false,
    // this.doctorModel,
    this.imagePath,
    this.userCredential,
    this.onTap,
    this.otp,
    this.reasonsKey,
    this.location,
    this.screenName,
    this.endPoint,
  });
}
