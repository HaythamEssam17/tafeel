import 'package:clean_arch_demo_las_version/core/app/app_scaffold_page.dart';
import 'package:clean_arch_demo_las_version/core/factories/switch_factory.dart';
import 'package:clean_arch_demo_las_version/core/features/dynamic_form_feature/data/models/dynamic_form_model.dart';
import 'package:clean_arch_demo_las_version/core/features/dynamic_form_feature/presentation/cubit/dynamic_form_feature_cubit.dart';
import 'package:clean_arch_demo_las_version/core/features/dynamic_form_feature/presentation/cubit/dynamic_form_feature_state.dart';
import 'package:clean_arch_demo_las_version/core/presentation/widgets/common_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DynamicFormHomePage extends StatefulWidget {
  const DynamicFormHomePage({super.key});

  @override
  State<DynamicFormHomePage> createState() => _DynamicFormHomePageState();
}

class _DynamicFormHomePageState extends State<DynamicFormHomePage> {
  late DynamicFormFeatureCubit _dynamicFormFeatureCubit;

  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  dynamic dropdownvalue;

  @override
  void initState() {
    super.initState();
    _dynamicFormFeatureCubit = BlocProvider.of<DynamicFormFeatureCubit>(
      context,
    );
    _dynamicFormFeatureCubit.getFromJson(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldPage(
      body: BlocConsumer<DynamicFormFeatureCubit, DynamicFormFeatureState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is DynamicFormFeatureLoading) {
            return const CommonLoadingWidget();
          } else if (state is DynamicFormFeatureSccess) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: _dynamicFormFeatureCubit.formResponse.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _dynamicFormFeatureCubit.formResponse[index].title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      myFormType(
                        _dynamicFormFeatureCubit.formResponse[index].fields,
                      ),
                    ],
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  ListView myFormType(List<DynamicFormFieldModel> dynamicFormFieldsList) {
    return ListView.separated(
      itemCount: dynamicFormFieldsList.length,
      shrinkWrap: true,
      itemBuilder: (context, innerIndex) {
        switch (dynamicFormFieldsList[innerIndex].fieldType) {
          case 'DatetimePicker':
            return myDatePicker();

          case 'TextInput':
            return TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: dynamicFormFieldsList[innerIndex].label,
              ),
            );

          case 'SelectList':
            return dropDownWidget(dynamicFormFieldsList[innerIndex].options);

          case 'SwitchInput':
            return PlatformSwitch.buildSwitch(
              context: context,
              value: true,
              onChanged: (value) {},
            );

          default:
            return const Text("Other type");
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 10);
      },
    );
  }

  Widget myDatePicker() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        _selectDate(context);
      },
      child: AbsorbPointer(
        child: TextFormField(
          onChanged: (value) {},
          controller: dateController,
          obscureText: false,
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14.0,
          ),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Theme.of(context).primaryColor),
            focusColor: Theme.of(context).primaryColor,
            filled: true,
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            labelText: "Date select",
            prefixIcon: const Icon(Icons.calendar_today, size: 18),
          ),
        ),
      ),
    );
  }

  Future _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        final date = DateTime.parse(picked.toString());
        final formatted = "${date.year}-${date.month}-${date.day}";
        dateController = TextEditingController();
        dateController = TextEditingController(text: formatted);
      });
    }
  }

  DropdownButtonFormField<DynamicFormOptionModel> dropDownWidget(
    List<DynamicFormOptionModel>? items,
  ) {
    return DropdownButtonFormField<DynamicFormOptionModel>(
      // Initial Value
      value: dropdownvalue,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[800]),
        hintText: items!.first.optionLabel,
      ),
      borderRadius: BorderRadius.circular(10),

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items:
          items.map((DynamicFormOptionModel items) {
            return DropdownMenuItem<DynamicFormOptionModel>(
              value: items,
              child: Text(items.optionValue),
            );
          }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
      },
    );
  }
}
