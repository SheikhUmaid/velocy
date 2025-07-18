class CashLimitModel {
  final double limit;
  final bool? isOnline;

  CashLimitModel({required this.limit, this.isOnline});

  factory CashLimitModel.fromJson(Map<String, dynamic> json) {
    final dynamic rawLimit = json['cash_payments_left'];
    final dynamic rawIsOnline = json['is_online'];
    double parsedLimit = 0.0;

    if (rawLimit is int) {
      parsedLimit = rawLimit.toDouble();
    } else if (rawLimit is double) {
      parsedLimit = rawLimit;
    } else if (rawLimit is String) {
      parsedLimit = double.tryParse(rawLimit) ?? 0.0;
    }

    return CashLimitModel(
      limit: parsedLimit,
      isOnline: rawIsOnline is bool ? rawIsOnline : null,
    );
  }
}
