part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInError extends SignInState {
  final String message;
  const SignInError(this.message);

  @override
  List<Object> get props => [message];
}

class SignInSuccess extends SignInState {}

class SignInNotVerified extends SignInState {}

class SignInEmailSending extends SignInState {}

class SignInEmailSent extends SignInState {}

class SignInEmailSentFailed extends SignInState {
  final String message;
  const SignInEmailSentFailed(this.message);

  @override
  List<Object> get props => [message];
}

class SignInLoading extends SignInState {}
