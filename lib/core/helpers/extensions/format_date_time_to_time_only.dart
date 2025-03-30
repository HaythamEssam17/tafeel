import 'package:intl/intl.dart';

import '../shared_texts.dart';

extension FormatDateTimeToFullFormat on DateTime {
  String formatDateTimeToFullFormat() {
    final DateFormat dt = DateFormat('EE dd MMM HH:mm ', SharedText.currentLocale);

    return dt.format(this);
  }

  String formatDateTimeToBeUserFriendly() {
    final DateFormat dt = DateFormat('dd-MM-yyyy');

    return dt.format(this);
  }

  String formatDateTimeToShowDayName() {
    final DateFormat dt = DateFormat('EE dd MMM', SharedText.currentLocale);

    return dt.format(this);
  }

  String formatDateTimeToChat() {
    String dateFormat = "";
    final DateFormat shortTime = DateFormat('hh:mm a', SharedText.currentLocale);
    final DateFormat longTime = DateFormat('dd / MM /yyyy ', SharedText.currentLocale);
    if (longTime.format(this) == longTime.format(DateTime.now())) {
      dateFormat = shortTime.format(this);
    } else {
      dateFormat = longTime.format(this);
    }

    return dateFormat;
  }

  String formatDateTimeToWalletFormat() {
    final DateFormat dt = DateFormat('HH:mm a, dd MMM, yyyy', SharedText.currentLocale);

    return dt.format(this);
  }
}
