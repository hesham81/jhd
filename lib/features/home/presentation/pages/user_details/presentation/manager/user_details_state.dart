part of 'user_details_cubit.dart';

@immutable
sealed class UserDetailsState {}

final class UserDetailsInitial extends UserDetailsState {}

final class UserDetailsError extends UserDetailsState {
  final String errorMessage;

  UserDetailsError({
    required this.errorMessage,
  });
}

final class UserDetailsSuccess extends UserDetailsState {}
