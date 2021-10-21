import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stepper_state.dart';

class StepperCubit extends Cubit<StepperState> {
  StepperCubit(StepperState initialState) : super(initialState);

  void initiateStepper() {
    emit(StepperOnNext());
  }
}
