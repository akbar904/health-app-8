import 'package:my_app/features/todo/todo_model.dart';
import 'package:my_app/features/todo/todo_service.dart';
import 'package:stacked/stacked.dart';

class TodoViewModel extends BaseViewModel {
  final TodoService _todoService;

  TodoViewModel(this._todoService);

  List<Todo> get todos => _todoService.getAllTodos();

  void addTodo(String title) {
    if (title.trim().isEmpty) return;
    _todoService.addTodo(title);
    notifyListeners();
  }

  void toggleTodoCompletion(String id) {
    _todoService.toggleTodoCompletion(id);
    notifyListeners();
  }

  void deleteTodo(String id) {
    _todoService.deleteTodo(id);
    notifyListeners();
  }
}
