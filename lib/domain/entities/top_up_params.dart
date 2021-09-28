
class TopUpParams {
  final String userId;
  final String date;

  TopUpParams({
    required this.userId,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'filter_date': date,
  };
}
