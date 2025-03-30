import 'dart:convert';

import 'package:clean_arch_demo_las_version/core/constants/asset_paths/json_path.dart';
import 'package:clean_arch_demo_las_version/core/features/dynamic_form_feature/data/models/dynamic_form_model.dart';
import 'package:clean_arch_demo_las_version/core/features/dynamic_form_feature/presentation/cubit/dynamic_form_feature_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [DynamicFormFeatureCubit] is a cubit to handle dynamic form values
class DynamicFormFeatureCubit extends Cubit<DynamicFormFeatureState> {
  DynamicFormFeatureCubit() : super(DynamicFormFeatureInitial());

  List<DynamicFormModel> formResponse = [];

  void getFromJson(BuildContext context) async {
    formResponse.clear();
    emit(DynamicFormFeatureLoading());

    final String data = await DefaultAssetBundle.of(
      context,
    ).loadString(JsonPaths.dynaicForm);
    final jsonResult = jsonDecode(data);

    jsonResult.forEach(
      (element) => formResponse.add(DynamicFormModel.fromJson(element)),
    );

    emit(DynamicFormFeatureSccess());
  }
}
