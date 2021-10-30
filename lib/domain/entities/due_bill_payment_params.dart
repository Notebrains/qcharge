
class DueBillPayParams {
  final String userId;
  final String transactionId;
  final String dueBilling;
  final String flag;

  DueBillPayParams({
    required this.userId,
    required this.transactionId,
    required this.dueBilling,
    required this.flag,
  });

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'transaction_id': transactionId,
    'due_billing': dueBilling,
    'flag': flag,
  };
}
