class ChargingCalculationParams {
  final String userId;
  final String chargingDispute;

  ChargingCalculationParams({
    required this.userId,
    required this.chargingDispute,
  });

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'charging_dispute': chargingDispute,
  };
}
