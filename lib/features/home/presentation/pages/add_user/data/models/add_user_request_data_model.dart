import 'package:jhd/features/home/presentation/pages/add_user/domain/entities/add_user_request.dart';

class AddUserRequestDataModel extends AddUserRequest {
  AddUserRequestDataModel({
    required super.email,
    required super.createdAt,
    required super.name,
    super.role,
    super.uid,
    required super.password,
  });

  factory AddUserRequestDataModel.fromJson(Map<String, dynamic> data) =>
      AddUserRequestDataModel(
        email: data['email'] as String,
        createdAt:
            DateTime.fromMillisecondsSinceEpoch(data['createdAt'] as int),
        name: data['name'] as String,
        role: data['role'] as String,
        uid: data['uid'] as String,
        password: data['password'] as String,
      );

  Map<String, dynamic> toMap() {
    return {
      'role': this.role,
      'email': this.email,
      'name': this.name,
      'uid': this.uid,
      'password': this.password,
      'createdAt': this.createdAt.millisecondsSinceEpoch
    };
  }
}
