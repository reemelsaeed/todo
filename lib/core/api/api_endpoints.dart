class ApiEndpoints {
  static const login = 'login';
  static const register = 'register';
  static const logout = 'logout';
  static const getTasks = 'tasks';
  static const addTask = 'tasks';
  static String updateTask(int id) => 'tasks/$id';
  static String showTask(int id) => 'tasks/$id';
  static const numbers = 'numbers';
}
