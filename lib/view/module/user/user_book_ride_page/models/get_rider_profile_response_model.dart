import 'dart:convert';

import 'package:velocy_user_app/helper/safe_parser.dart';

class GetRiderProfileResponseModel {
  final String? id;
  final String? username;
  final String? profile;
  GetRiderProfileResponseModel({this.id, this.username, this.profile});

  GetRiderProfileResponseModel copyWith({
    String? id,
    String? username,
    String? profile,
  }) {
    return GetRiderProfileResponseModel(
      id: id ?? this.id,
      username: username ?? this.username,
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'profile': profile,
    };
  }

  factory GetRiderProfileResponseModel.fromMap(Map<String, dynamic> map) {
    return GetRiderProfileResponseModel(
      id: safeParser(map['id'], 'id'),
      username: safeParser(map['username'], 'username'),
      profile: safeParser(map['profile'], 'profile'),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetRiderProfileResponseModel.fromJson(String source) =>
      GetRiderProfileResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'GetRiderProfileResponseModel(id: $id, username: $username, profile: $profile)';

  @override
  bool operator ==(covariant GetRiderProfileResponseModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.profile == profile;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ profile.hashCode;
}
