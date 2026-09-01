import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/features/dashboard/data/repo/home_repo.dart';
import 'package:todo_app/features/tasks/data/models/taskModel.dart';

part 'dashboard_cubit_state.dart';

class DashboardCubitCubit extends Cubit<DashboardCubitState> {
  DashboardCubitCubit(this.homeRepo) : super(DashboardCubitInitial());

  HomeRepo homeRepo;

  Future<void> getTasks() async {
    emit(DashboardCubitILoading());
    try {
      final tasks = await homeRepo.getTasks();
      emit(DashboardCubitSuccess(tasks));
    } catch (e) {
      emit(DashboardCubitFailuer(e.toString()));
    }
  }
}
