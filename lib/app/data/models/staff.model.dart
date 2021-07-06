import 'dart:convert';
import 'package:meta/meta.dart';

class Staffmodel {
  final String username;
  final String email;
  final String permission;

  Staffmodel({
    @required this.username,
    @required this.email,
    @required this.permission,
  });

  Staffmodel copyWith({
    String username,
    String email,
    String permission,
  }) {
    return Staffmodel(
      username: username ?? this.username,
      email: email ?? this.email,
      permission: permission ?? this.permission,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'permission': permission,
    };
  }

  factory Staffmodel.fromMap(Map<String, dynamic> map) {
    return Staffmodel(
      username: map['username'],
      email: map['email'],
      permission: map['permission'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Staffmodel.fromJson(String source) =>
      Staffmodel.fromMap(json.decode(source));

  @override
  String toString() =>
      'Staffmodel(username: $username, email: $email, permission: $permission)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Staffmodel &&
        other.username == username &&
        other.email == email &&
        other.permission == permission;
  }

  @override
  int get hashCode => username.hashCode ^ email.hashCode ^ permission.hashCode;
}
