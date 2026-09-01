import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/features/Authentication/data/models/userModel.dart';
import 'package:todo_app/features/Authentication/data/repo/signUp_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.signupRepo) : super(SignUpInitial());

  final SignupRepo signupRepo;

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String confirmPassword,
  }) async {
    emit(SignUploading());
    try {
      final user = await signupRepo.signUp(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      emit(SignUpsuccess(user));
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}
