import 'package:equatable/equatable.dart';

class SignInRequest extends Equatable {
  final String username;

  final String password;

  const SignInRequest(this.username, this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [username, password];
}
