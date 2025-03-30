import 'package:clean_arch_demo_las_version/core/features/horizontal_stepper_feature/presentation/logic/horizontal_stepper_cubit.dart';
import 'package:clean_arch_demo_las_version/core/features/horizontal_stepper_feature/presentation/logic/horizontal_stepper_states.dart';
import 'package:clean_arch_demo_las_version/core/features/horizontal_stepper_feature/presentation/widgets/inner_item_widget.dart';
import 'package:clean_arch_demo_las_version/core/features/horizontal_stepper_feature/presentation/widgets/step_title_widget.dart';
import 'package:clean_arch_demo_las_version/core/helpers/extensions/color_extension.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared.dart';
import 'package:clean_arch_demo_las_version/core/helpers/shared_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HorizontalStepperHomePage extends StatefulWidget {
  const HorizontalStepperHomePage({super.key});

  @override
  State<HorizontalStepperHomePage> createState() =>
      _HorizontalStepperHomePageState();
}

class _HorizontalStepperHomePageState extends State<HorizontalStepperHomePage> {
  late HorizontalStepperCubit _horizontalStepperCubit;

  @override
  void initState() {
    super.initState();
    _horizontalStepperCubit = BlocProvider.of<HorizontalStepperCubit>(context);
    _horizontalStepperCubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HorizontalStepperCubit, HorizontalStepperStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              getSpaceHeight(120),

              /// Stepper
              Center(
                child: SizedBox(
                  width: SharedText.screenWidth,
                  height: getWidgetHeight(50),
                  child: Column(
                    children: [
                      SizedBox(
                        width: SharedText.screenWidth * 0.75,
                        child: Row(children: steps()),
                      ),
                      const Row(
                        children: [
                          StepTitleWidget(title: 'إدخال الهوية'),
                          StepTitleWidget(title: 'إنشاء حساب'),
                          StepTitleWidget(title: 'تعيين كلمة المرور'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              /// Body
              Expanded(
                child:
                    _horizontalStepperCubit
                        .steppers[_horizontalStepperCubit.currentStep - 1],
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => _horizontalStepperCubit.back(),
              child: const Text('Back'),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _horizontalStepperCubit.next(),
              child: Text(
                _horizontalStepperCubit.currentStep ==
                        _horizontalStepperCubit.totalSteps
                    ? 'Finish'
                    : 'Next',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> steps() {
    _horizontalStepperCubit.stepsList.clear();

    for (int i = 0; i < _horizontalStepperCubit.totalSteps; i++) {
      // step circles
      _horizontalStepperCubit.stepsList.add(
        Container(
          width: getWidgetWidth(20),
          height: getWidgetHeight(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.getStepperCircleColor(
              i,
              _horizontalStepperCubit.currentStep,
            ),
            border: Border.all(
              color: Theme.of(context).colorScheme.getStepperBorderColor(
                i,
                _horizontalStepperCubit.currentStep,
              ),
              width: 1.0,
            ),
          ),
          child: InnerStepperItemWidget(
            index: i,
            curStep: _horizontalStepperCubit.currentStep,
          ),
        ),
      );
      // line between step circles
      if (i != (_horizontalStepperCubit.totalSteps - 1)) {
        _horizontalStepperCubit.stepsList.add(
          Expanded(
            child: Center(
              child: Container(
                height: getWidgetHeight(2),
                color: Theme.of(context).colorScheme.getStepperLineColor(
                  i,
                  _horizontalStepperCubit.currentStep,
                ),
              ),
            ),
          ),
        );
      }
    }

    return _horizontalStepperCubit.stepsList;
  }
}
