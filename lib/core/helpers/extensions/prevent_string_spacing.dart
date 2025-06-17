extension GetStringWithoutSpacings on String {
  String getStringWithoutSpacings() {
    String firstName = split(" ").first;
    if (firstName.length > 12) {
      firstName = firstName.substring(0, 10);
      return firstName[0].toUpperCase() + firstName.substring(1);
    } else {
      return firstName[0].toUpperCase() + firstName.substring(1);
    }
  }

  String hidePhoneNumberData() {
    return "${substring(0, 4)}xxxxxxx${substring(length - 1)}";
  }

  String hideEmail() {
    final int emailIndex = indexOf("@");

    return "${substring(0, 2)}xxxxxxx${substring(emailIndex)}";
  }

  String convertStringToSplitChar() {
    final listOfChar = split('');
    var outPut = "";
    for (var element in listOfChar) {
      outPut = "$outPut $element";
    }
    return outPut;
  }

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  String replaceArabNumber() {
    final Map<String, String> numbers = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };
    String result = '';

    for (int i = 0; i < length; i++) {
      result = result + (numbers[this[i]] ?? this[i]);
    }

    return result;
  }
}
