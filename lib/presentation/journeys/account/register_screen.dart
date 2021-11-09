import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/presentation/blocs/register/car_brand_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/register/car_model_cubit.dart';
import 'package:qcharge_flutter/presentation/blocs/register/register_cubit.dart';
import 'package:qcharge_flutter/presentation/journeys/account/register_form.dart';

import '../../../di/get_it.dart';

class RegisterScreen extends StatefulWidget {
  final Function isProcessCompleted;

  const RegisterScreen({Key? key, required this.isProcessCompleted}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterCubit _registerCubit;
  late CarBrandCubit _carBrandCubit;
  late CarModelCubit _carModelCubit;

  @override
  void initState() {
    super.initState();
    _registerCubit = getItInstance<RegisterCubit>();
    _carModelCubit = getItInstance<CarModelCubit>();
    _carBrandCubit = getItInstance<CarBrandCubit>();
  }

  @override
  void dispose() {
    _registerCubit.close();
    _carBrandCubit.close();
    _carModelCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _registerCubit),
        BlocProvider.value(value: _carBrandCubit),
        BlocProvider.value(value: _carModelCubit),
      ],
      child: BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
        return BlocBuilder<CarBrandCubit, CarBrandState>(builder: (context, state) {
          return RegisterForm(isProcessCompleted: () {
            widget.isProcessCompleted();
          });
        });
      }),
    );
  }
}
