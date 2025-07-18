import 'dart:convert';

import 'package:velocy_user_app/helper/safe_parser.dart';

class GetLiveOfferResponseModel {
  final String? message;
  final bool? status;
  final List<LiveOffer>? liveOffers;

  GetLiveOfferResponseModel({this.message, this.status, this.liveOffers});

  factory GetLiveOfferResponseModel.fromJson(Map<String, dynamic> json) {
    return GetLiveOfferResponseModel(
      message: safeParser(json['message'], 'message'),
      status: safeParser(json['status'], 'status'),
      liveOffers:
          (json['data'] as List<dynamic>)
              .map((e) => LiveOffer.fromMap(e))
              .toList(),
    );
  }
}

class LiveOffer {
  final String? code;
  final String? description;
  LiveOffer({this.code, this.description});

  LiveOffer copyWith({String? code, String? description}) {
    return LiveOffer(
      code: code ?? this.code,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'code': code, 'description': description};
  }

  factory LiveOffer.fromMap(Map<String, dynamic> map) {
    return LiveOffer(
      code: safeParser(map['code'], 'code'),
      description: safeParser(map['description'], 'description'),
    );
  }

  String toJson() => json.encode(toMap());

  factory LiveOffer.fromJson(String source) =>
      LiveOffer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LiveOffer(code: $code, description: $description)';

  @override
  bool operator ==(covariant LiveOffer other) {
    if (identical(this, other)) return true;

    return other.code == code && other.description == description;
  }

  @override
  int get hashCode => code.hashCode ^ description.hashCode;
}
