import 'package:jhd/features/sign_in/domain/entities/sign_in_request.dart';

class SignInDataModel extends SignInRequest {
  const SignInDataModel(super.username, super.password);

  // factory SignInDataModel.fromJson(Map<String, dynamic> json) {
    // return SignInDataModel(json['username'], json['password']);
  // }
}
