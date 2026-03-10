import 'package:equatable/equatable.dart';

class AddUserRequest extends Equatable {
  final String email;
  final String password;
  final String role;
  final DateTime createdAt;
  final String name;
  String uid;
  AddUserRequest({
    required this.password,
    required this.email,
    this.role = 'user',
    required this.createdAt,
    required this.name,
    this.uid = "",
  });

  @override
  List<Object?> get props => [
        email,
        role,
        createdAt,
        name,
        uid,
      ];
}
