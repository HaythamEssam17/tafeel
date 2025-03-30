import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/shared_texts.dart';
import '../../domain/use_case/lang_use_case.dart';
import 'language_states.dart';

class LangCubit extends Cubit<LangState> {
  final LangUseCase useCase;
  Locale appLocal = const Locale('ar');

  LangCubit(this.useCase) : super(AppInitialLangState());

  static LangCubit get(BuildContext context) => BlocProvider.of(context);

  /// change lang with the new lang selected
  Future<void> changeLang(String newLang) async {
    ///update current lang
    devLog('old lang is: ${SharedText.currentLocale}');
    appLocal = await useCase.callSetLang(lang: newLang);
    devLog('new lang is: ${SharedText.currentLocale}');
    emit(UpdateNewLangState());
  }

  ///get saved lang (called when app is opening)
  Future<void> getLang() async {
    emit(GetLangState());
    useCase.callGetLang().then((value) {
      appLocal = Locale(value);
      SharedText.currentLocale = appLocal.languageCode;
      emit(UpdateLangState());
    });
    emit(UpdateLangState());
  }
}
