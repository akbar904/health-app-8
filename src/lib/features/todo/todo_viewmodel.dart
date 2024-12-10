import 'package:my_app/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/models/todo.dart';

class TodoViewModel extends BaseViewModel {
  final TodoService _todoService;
  
  TodoViewModel(this._todoService);
  
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  Future<void> addTodo(String title) async {
    await _todoService.addTodo(title);
    notifyListeners();
  }

  Future<void> toggleTodoCompletion(String id) async {
    await _todoService.toggleTodo(id);
    notifyListeners();
  }

  Future<void> deleteTodo(String id) async {
    await _todoService.deleteTodo(id);
    notifyListeners();
  }
}