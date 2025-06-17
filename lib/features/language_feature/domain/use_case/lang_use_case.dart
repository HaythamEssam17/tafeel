import 'dart:ui';

import 'package:tafeal_demo/core/helpers/l10n/app_localizations.dart';

import '../../../../core/helpers/shared_texts.dart';
import '../interface/lang_interface.dart';

class LangUseCase {
  final LangInterface langInterface;

  LangUseCase(this.langInterface);

  Future<Locale> callSetLang({required String lang}) {
    return langInterface.setLang(lang: lang).then((value) async {
      SharedText.currentLocale = lang;
      await AppLocalizations.delegate.load(Locale(lang));
      return Locale(lang);
    });
  }

  Future<String> callGetLang() {
    return langInterface.getLang().then((value) async {
      if (value == null) {
        callSetLang(lang: 'ar');
        return Future(() => 'ar');
      } else {
        SharedText.currentLocale = value;
        await AppLocalizations.delegate.load(Locale(value));
        return Future(() => value);
      }
    });
  }
}
