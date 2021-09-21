import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:qcharge_flutter/data/models/car_brand_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/app_error.dart';
import 'package:qcharge_flutter/domain/entities/car_brand_entity.dart';
import 'package:qcharge_flutter/domain/entities/no_params.dart';
import 'package:qcharge_flutter/domain/usecases/get_car_brand.dart';
import 'package:qcharge_flutter/presentation/blocs/loading/loading_cubit.dart';

part 'car_brand_state.dart';

class CarBrandCubit extends Cubit<CarBrandState> {
  final CarBrand carBrand;
  final LoadingCubit loadingCubit;

  CarBrandCubit({
    required this.carBrand,
    required this.loadingCubit,
  }) : super(CarBrandInitial());

  void loadCarBrand() async {
    loadingCubit.show();
    final Either<AppError, List<CarBrandEntity>> eitherResponse = await carBrand(NoParams());

    emit(eitherResponse.fold(
          (l) => CarBrandError(),
          (r) => CarBrandLoaded(r),
    ));

    loadingCubit.hide();
  }
}
