import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/common/constants/translation_constants.dart';
import 'package:qcharge_flutter/common/extensions/string_extensions.dart';
import 'package:qcharge_flutter/di/get_it.dart';
import 'package:qcharge_flutter/presentation/blocs/home/stepper_cubit.dart';
import 'package:qcharge_flutter/presentation/widgets/button.dart';

const double MARGIN_NORMAL = 16;
const double CHIP_BORDER_RADIUS = 30;
const double MARGIN_SMALL = 8;
const double PADDING_SMALL = 8;

enum HorizontalStepState { SELECTED, UNSELECTED }

enum Type { TOP, BOTTOM }

class HorizontalStep {
  final String title;
  final Widget widget;
  bool isValid;
  HorizontalStepState state;

  HorizontalStep({
    required this.title,
    required this.widget,
    this.state = HorizontalStepState.UNSELECTED,
    required this.isValid,
  });
}

class HorizontalStepper extends StatefulWidget {
  final List<HorizontalStep> steps;
  final Color selectedColor;
  final double circleRadius;
  final Color unSelectedColor;
  final Color selectedOuterCircleColor;
  final TextStyle textStyle;
  final Color leftBtnColor;
  final Color rightBtnColor;
  final VoidCallback onComplete;
  final Color btnTextColor;

  HorizontalStepper({
    required this.steps,
    required this.selectedColor,
    required this.circleRadius,
    required this.unSelectedColor,
    required this.selectedOuterCircleColor,
    required this.textStyle,
    required this.leftBtnColor,
    required this.rightBtnColor,
    required this.btnTextColor,
    required this.onComplete,
  });

  @override
  State<StatefulWidget> createState() => _HorizontalStepperState(
        steps: this.steps,
        selectedColor: selectedColor,
        unSelectedColor: unSelectedColor,
        circleRadius: circleRadius,
        selectedOuterCircleColor: selectedOuterCircleColor,
        textStyle: textStyle,
        leftBtnColor: leftBtnColor,
        rightBtnColor: rightBtnColor,
        onComplete: onComplete,
        btnTextColor: btnTextColor,
      );
}

class _HorizontalStepperState extends State<StatefulWidget> {
  late StepperCubit cubit;

  final List<HorizontalStep> steps;
  final Color selectedColor;
  final Color unSelectedColor;
  final double circleRadius;
  final TextStyle textStyle;
  final Color leftBtnColor;
  final Color rightBtnColor;
  final VoidCallback onComplete;
  final Color btnTextColor;

  Color selectedOuterCircleColor;
  late PageController _controller;
  int currentStep = 0;

  _HorizontalStepperState({
    required this.steps,
    required this.selectedColor,
    required this.circleRadius,
    required this.unSelectedColor,
    required this.selectedOuterCircleColor,
    required this.textStyle,
    required this.leftBtnColor,
    required this.rightBtnColor,
    required this.onComplete,
    required this.btnTextColor,
  });

  @override
  void initState() {
    super.initState();

    cubit = getItInstance<StepperCubit>();

    _controller = PageController();
    _controller.addListener(() {
      if (!steps[currentStep].isValid) {
        _controller.jumpToPage(currentStep);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    cubit.close();
  }

  void changeStatus(int index) {
    if (isForward(index)) {
      markAsCompletedForPrecedingSteps();
    } else {
      markAsUnselectedToSucceedingSteps();
    }
    setState(() {
      currentStep = index;
      steps[index].state = HorizontalStepState.SELECTED;
    });
  }

  void markAsUnselectedToSucceedingSteps() {
    for (int i = steps.length - 1; i >= currentStep; i--) {
      steps[i].state = HorizontalStepState.UNSELECTED;
    }
  }

  void markAsCompletedForPrecedingSteps() {
    for (int i = 0; i <= currentStep; i++) {
      steps[i].state = HorizontalStepState.SELECTED;
    }
  }

  bool _isLast(int index) {
    return steps.length - 1 == index;
  }

  void goToNextPage() {
    if (_isLast(currentStep)) {
      onComplete.call();
    }
    if (currentStep < steps.length - 1) {
      currentStep++;
      setState(() {});
      _controller.jumpToPage(currentStep);
    }
  }

  void _goToPreviousPage() {
    if (currentStep > 0) {
      currentStep--;
      _controller.jumpToPage(currentStep);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<StepperCubit, StepperState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is StepperOnNext) {
            //print('---- : next called 3');
          }
          return Column(
            children: _getTopTypeWidget(width),
          );
        });

  }


  Widget _getPageWidgets() {
    return Expanded(
      child: PageView(
        controller: _controller,
        onPageChanged: (index) => setState(() {
          changeStatus(index);
        }),
        children: _getPages(),
      ),
    );
  }

  Widget _getTitleWidgets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: getTitles(),
    );
  }

  Widget _getIndicatorWidgets(double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(
        left: 36,
        right: 36,
        top: PADDING_SMALL,
      ),
      child: Row(
        children: _getStepCircles(),
      ),
    );
  }

  List<Widget> _getTopTypeWidget(double width) {
    return [
      _getIndicatorWidgets(width),
      SizedBox(
        height: MARGIN_SMALL,
      ),
      _getTitleWidgets(),
      _getPageWidgets(),
      _getButtons(),

      BlocConsumer<StepperCubit, StepperState>(
        builder: (context, state) {
          return const SizedBox.shrink();
        },
        listenWhen: (previous, current) => current is StepperOnNext,
        listener: (context, state) {
          //'Password has send to your email. Please get your new password from email and login.',
          //Navigator.of(context).pushNamedAndRemoveUntil(RouteList.initial,(route) => false,);
          if (state is StepperOnNext) {
            //print('---- : next called 2 ');
            //edgeAlert(context, title: 'Note', description: 'On Next Called', gravity: Gravity.top);
            goToNextPage();
          }
        },
      ),

    ];
  }

  Widget _getButtons() {
    return Visibility(
      visible: steps[currentStep].title == TranslationConstants.success.t(context),
      child: Padding(
        padding: const EdgeInsets.only(left: 34, right: 34, bottom: 100),
        child: Button(text: TranslationConstants.getStarted.t(context),
          bgColor: [Color(0xFFEFE07D), Color(0xFFB49839)],
          onPressed: () {
            goToNextPage();
          },
        ),
      ),
    );
  }

  List<Widget> getTitles() {
    return steps
        .map((e) => Expanded(
              flex: 1,
              child: Text(
                e.title,
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ))
        .toList();
  }

  List<Widget> _getStepCircles() {
    List<Widget> widgets = [];
    steps.asMap().forEach((key, value) {
      widgets.add(_StepCircle(value, circleRadius, selectedColor, unSelectedColor, selectedOuterCircleColor));
      if (key != steps.length - 1) {
        widgets.add(_StepLine(
          steps[key + 1],
          selectedColor,
          unSelectedColor,
        ));
      }
    });
    return widgets;
  }

  List<Widget> _getPages() {
    return steps.map((e) => e.widget).toList();
  }

  bool isForward(int index) {
    return index > currentStep;
  }
}

class _StepLine extends StatelessWidget {
  final HorizontalStep step;
  final Color selectedColor;
  final Color unSelectedColor;

  _StepLine(
    this.step,
    this.selectedColor,
    this.unSelectedColor,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          margin: const EdgeInsets.only(
            left: 4,
            right: 4,
          ),
          height: 2,
          color: step.state == HorizontalStepState.SELECTED ? selectedColor : unSelectedColor,
        ),
      );
  }
}

class _StepCircle extends StatelessWidget {
  final HorizontalStep step;
  final double circleRadius;
  final Color selectedColor;
  final Color unSelectedColor;
  final Color selectedOuterCircleColor;

  _StepCircle(
    this.step,
    this.circleRadius,
    this.selectedColor,
    this.unSelectedColor,
    this.selectedOuterCircleColor,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: circleRadius,
      width: circleRadius,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: _getColor(),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(circleRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          4,
        ),
        child: Container(
            decoration: BoxDecoration(
          color: step.state == HorizontalStepState.SELECTED ? selectedColor : unSelectedColor,
          borderRadius: BorderRadius.all(
            Radius.circular(
              circleRadius,
            ),
          ),
        )),
      ),
    );
  }

  Color _getColor() {
    if (step.state == HorizontalStepState.SELECTED) {
      if (selectedOuterCircleColor != null) {
        return selectedOuterCircleColor;
      } else {
        return selectedColor;
      }
    }
    return unSelectedColor;
  }
}
