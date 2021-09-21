import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:qcharge_flutter/domain/entities/app_error.dart';
import 'package:qcharge_flutter/domain/entities/car_brand_entity.dart';
import 'package:qcharge_flutter/domain/usecases/get_car_model.dart';
import 'package:qcharge_flutter/presentation/blocs/loading/loading_cubit.dart';

part 'car_model_state.dart';

class CarModelCubit extends Cubit<CarModelState> {
  final CarModel carModel;
  final LoadingCubit loadingCubit;

  CarModelCubit({
    required this.carModel,
    required this.loadingCubit,
  }) : super(CarModelInitial());

  void loadCarModel(String brandId) async {
    loadingCubit.show();
    final Either<AppError, List<CarBrandEntity>> eitherResponse = await carModel(brandId);

    emit(eitherResponse.fold(
          (l) => CarModelError(),
          (r) => CarModelLoaded(r),
    ));

    loadingCubit.hide();
  }
}
