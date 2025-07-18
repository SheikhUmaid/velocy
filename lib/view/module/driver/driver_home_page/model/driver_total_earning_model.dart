class TotalEarningResponseModel {
  final double todayEarnings;
  final double yesterdayEarnings;
  final double thisWeekEarnings;
  final double thisMonthEarnings;
  final double totalEarnings;
  final int remainingCashLimit;

  TotalEarningResponseModel({
    required this.todayEarnings,
    required this.yesterdayEarnings,
    required this.thisWeekEarnings,
    required this.thisMonthEarnings,
    required this.totalEarnings,
    required this.remainingCashLimit,
  });

  factory TotalEarningResponseModel.fromJson(Map<String, dynamic> json) {
    return TotalEarningResponseModel(
      todayEarnings: (json['today_earnings'] ?? 0).toDouble(),
      yesterdayEarnings: (json['yesterday_earnings'] ?? 0).toDouble(),
      thisWeekEarnings: (json['this_week_earnings'] ?? 0).toDouble(),
      thisMonthEarnings: (json['this_month_earnings'] ?? 0).toDouble(),
      totalEarnings: (json['total_earnings'] ?? 0).toDouble(),
      remainingCashLimit: (json['remaining_cash_limit'] ?? 0),
    );
  }
}
