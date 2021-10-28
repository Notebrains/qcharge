import 'package:dartz/dartz.dart';
import 'package:qcharge_flutter/data/models/status_message_api_res_model.dart';
import 'package:qcharge_flutter/data/models/wallet_recharge_api_res.dart';
import 'package:qcharge_flutter/domain/entities/update_profile_params.dart';
import 'package:qcharge_flutter/domain/entities/wallet_recharge_params.dart';

import '../entities/app_error.dart';
import '../repositories/authentication_repository.dart';
import 'usecase.dart';

class WalletRechargeUsecase extends UseCase<WalletRechargeApiRes, WalletRechargeParams> {
  final AuthenticationRepository _authenticationRepository;

  WalletRechargeUsecase(this._authenticationRepository);

  @override
  Future<Either<AppError, WalletRechargeApiRes>> call(WalletRechargeParams params) async =>
      _authenticationRepository.walletRecharge(params.toJson());
}
