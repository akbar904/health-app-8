import 'package:stacked/stacked.dart';
import 'package:my_app/features/todo/todo_model.dart';
import 'package:my_app/features/todo/todo_service.dart';

class TodoViewModel extends BaseViewModel {
  final TodoService _todoService;

  TodoViewModel(this._todoService);

  List<TodoModel> get todos => _todoService.getTodos();

  void addTodo(String title) {
    if (title.trim().isEmpty) return;

    final todo = TodoModel(
      id: DateTime.now().toString(),
      title: title,
      createdAt: DateTime.now(),
    );
    _todoService.addTodo(todo);
    notifyListeners();
  }

  void toggleTodo(String id) {
    _todoService.toggleTodo(id);
    notifyListeners();
  }

  void deleteTodo(String id) {
    _todoService.deleteTodo(id);
    notifyListeners();
  }
}
