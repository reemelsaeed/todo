part of 'dashboard_cubit_cubit.dart';

@immutable
sealed class DashboardCubitState {}

final class DashboardCubitInitial extends DashboardCubitState {}

final class DashboardCubitILoading extends DashboardCubitState {}

final class DashboardCubitSuccess extends DashboardCubitState {
  final List<Taskmodel> tasks;
  DashboardCubitSuccess(this.tasks);
}

final class DashboardCubitFailuer extends DashboardCubitState {
  final String message;
  DashboardCubitFailuer(this.message);
}
