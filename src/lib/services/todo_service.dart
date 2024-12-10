import 'package:my_app/repositories/todo_repository.dart';
import 'package:my_app/app/app.locator.dart';

class TodoService {
  final _repository = locator<TodoRepository>();
  
  TodoService();
  
  Future<void> addTodo(String title) async {
    // Implementation
  }
  
  Future<void> toggleTodo(String id) async {
    // Implementation
  }
  
  Future<void> deleteTodo(String id) async {
    // Implementation
  }
}