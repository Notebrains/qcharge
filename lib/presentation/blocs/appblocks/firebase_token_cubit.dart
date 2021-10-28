import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/domain/entities/firebase_token_params.dart';
import 'package:qcharge_flutter/domain/usecases/firebase_token_usecase.dart';


part 'firebase_token_state.dart';

class FirebaseTokenCubit extends Cubit<FirebaseTokenState> {
  final FirebaseTokenUsecase usecase;

  FirebaseTokenCubit({
    required this.usecase,
  }) : super(FirebaseTokenInitial());
  void initiateFirebaseToken(String userId,) async {
    await FirebaseMessaging.instance.getToken().then((deviceToken) async {
      print('----deviceToken : $deviceToken');
      await usecase(
          FirebaseTokenParams(
            deviceToken: deviceToken!,
            userId: userId,
          ),
      );

    } );




  }
}
