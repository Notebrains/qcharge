class WalletRechargeParams {
  final String userId;
  final String transactionId;
  final String amount;

  WalletRechargeParams({
    required this.userId,
    required this.transactionId,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'transaction_id': transactionId,
    'amount': amount,
  };
}
