part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUploading extends SignUpState {}

final class SignUpsuccess extends SignUpState {
  final Usermodel user;
  SignUpsuccess(this.user);
}

class SignUpFailure extends SignUpState {
  final String message;
  SignUpFailure(this.message);
}
