// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  final String message;
  final User user;

  UserModel({
    required this.message,
    required this.user,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      message: map['message'] ?? '',
      user: User.fromMap(map['user'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'user': user.toMap(),
    };
  }

  @override
  String toString() => 'UserModel(message: $message, user: $user)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.message == message &&
        other.user == user;
  }

  @override
  int get hashCode => message.hashCode ^ user.hashCode;
}

class User {
  final String phoneNumber;
  final String role;
  final int userId;

  User({
    required this.phoneNumber,
    required this.role,
    required this.userId,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      phoneNumber: map['phone_number'] ?? '',
      role: map['role'] ?? '',
      userId: map['user_id'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone_number': phoneNumber,
      'role': role,
      'user_id': userId,
    };
  }

  @override
  String toString() =>
      'User(phoneNumber: $phoneNumber, role: $role, userId: $userId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.phoneNumber == phoneNumber &&
        other.role == role &&
        other.userId == userId;
  }

  @override
  int get hashCode => phoneNumber.hashCode ^ role.hashCode ^ userId.hashCode;
}

