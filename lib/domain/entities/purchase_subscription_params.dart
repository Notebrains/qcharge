class PurchaseSubscriptionParams {
  final String userId;
  final String transactionId;
  final String amount;
  final String planId;
  final String flag;

  PurchaseSubscriptionParams({
    required this.userId,
    required this.transactionId,
    required this.amount,
    required this.planId,
    required this.flag,
  });

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'transaction_id': transactionId,
    'amount': amount,
    'plan_id': planId,
    'flag': flag,
  };
}
