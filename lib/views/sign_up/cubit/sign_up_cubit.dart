import 'package:classconnect/services/auth.dart';
import 'package:classconnect/utilities/response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthService _authService;
  SignUpCubit(this._authService) : super(SignUpInitial());

  Future<void> createAccount(
      {required String email,
      required String password,
      required String fname,
      String? lname}) async {
    emit(SignUpLoading());
    Response res = await _authService.signUp(
        fname: fname, email: email, password: password, lname: lname);
    if (res.status == ResponseType.success) {
      emit(SignUpSuccess());
    } else {
      emit(SignUpError(
          res.message ?? 'Unknown error occured , Please try again .'));
    }
  }
}
