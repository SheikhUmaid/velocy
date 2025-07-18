import 'package:velocy_user_app/helper/safe_parser.dart';

class TodaysEarningResponse {
  final TodaysEarningModel? data;
  final String? message;
  final bool? status;

  TodaysEarningResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory TodaysEarningResponse.fromJson(Map<String, dynamic> json) {
    return TodaysEarningResponse(
      data:
          json['data'] != null
              ? TodaysEarningModel.fromJson(json['data'])
              : null,
      message: json['message'],
      status: json['status'],
    );
  }
}

class TodaysEarningModel {
  final double todayEarnings;
  final int todayRideCount;
  final double averageRating;

  TodaysEarningModel({
    required this.todayEarnings,
    required this.todayRideCount,
    required this.averageRating,
  });

  factory TodaysEarningModel.fromJson(Map<String, dynamic> json) {
    return TodaysEarningModel(
      todayEarnings: safeParser(json['today_earnings'], 'today_earnings'),
      todayRideCount: safeParser(json['today_ride_count'], 'today_ride_count'),
      averageRating: safeParser(json['average_rating'], 'average_rating'),
    );
  }
}
