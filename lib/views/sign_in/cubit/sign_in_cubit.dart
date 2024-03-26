import 'package:classconnect/services/auth.dart';
import 'package:classconnect/utilities/response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthService _authService;
  SignInCubit(this._authService) : super(SignInInitial());

  Future<void> signIn(String email, String password) async {
    emit(SignInLoading());

    final Response response =
        await _authService.signIn(email: email, password: password);
    if (response.status == ResponseType.success) {
      emit(SignInSuccess());
    } else {
      emit(SignInError(response.message ?? "An unknown error occurred."));
    }
  }
}
