import 'package:todo_app/core/api/api_endpoints.dart';
import 'package:todo_app/core/api/api_services.dart';
import 'package:todo_app/features/tasks/data/models/taskModel.dart';

class HomeRepo {
  ApiServices apiServices;
  HomeRepo(this.apiServices);

  // Get all tasks
  Future<List<Taskmodel>> getTasks() async {
    final response = await apiServices.dio.get(ApiEndpoints.getTasks);
    final List data = response.data['data'];
    return data.map((json) => Taskmodel.fromJson(json)).toList();
  }

  // Create a new task
  Future<Taskmodel> createTask(Taskmodel task) async {
    final response = await apiServices.dio.post(
      ApiEndpoints.addTask,
      data: task.toJson(),
    );
    return Taskmodel.fromJson(response.data['data']);
  }
}
