class CancelSubscriptionParams {
  final String userId;
  final String subscriptionId;

  CancelSubscriptionParams({
    required this.userId,
    required this.subscriptionId,
  });

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'id': subscriptionId,
  };
}
