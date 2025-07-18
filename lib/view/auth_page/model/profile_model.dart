// lib/view/auth_page/model/profile_model.dart

class ProfileModel {
  final String message;
  final ProfileUser user;

  ProfileModel({required this.message, required this.user});

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      message: map['message'] ?? '',
      user: ProfileUser.fromMap(map['user'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {'message': message, 'user': user.toMap()};
  }

  static fromJson(response) {}
}

class ProfileUser {
  final String profile;
  final String username;
  final String gender;
  final String street;
  final String area;
  final String aadharCard;
  final String addressType;

  ProfileUser({
    required this.profile,
    required this.username,
    required this.gender,
    required this.street,
    required this.area,
    required this.aadharCard,
    required this.addressType,
  });

  factory ProfileUser.fromMap(Map<String, dynamic> map) {
    return ProfileUser(
      profile: map['profile'] ?? '',
      username: map['username'] ?? '',
      gender: map['gender'] ?? '',
      street: map['street'] ?? '',
      area: map['area'] ?? '',
      aadharCard: map['aadhar_card'] ?? '',
      addressType: map['address_type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profile': profile,
      'username': username,
      'gender': gender,
      'street': street,
      'area': area,
      'aadhar_card': aadharCard,
      'address_type': addressType,
    };
  }
}
