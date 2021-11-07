import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    _registerCubit = getItInstance<RegisterCubit>();
  }

  @override
  void dispose() {
    _registerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _registerCubit),
      ],
      child: BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
        return RegisterForm(isProcessCompleted: () {
          widget.isProcessCompleted();
        });
      }),
    );
  }
}
