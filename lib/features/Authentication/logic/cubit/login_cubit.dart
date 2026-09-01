import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/features/Authentication/data/models/userModel.dart';
import 'package:todo_app/features/Authentication/data/repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;

  LoginCubit(this.loginRepo) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final user = await loginRepo.login(email: email, password: password);
      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginFailure('Error try again'));
    }
  }
}
