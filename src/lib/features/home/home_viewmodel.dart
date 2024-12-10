import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/services/todo_service.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();

  bool _showCompleted = false;
  bool get showCompleted => _showCompleted;

  List<Todo> get filteredTodos {
    return _todoService.getTodosByCompletion(_showCompleted);
  }

  void setShowCompleted(bool value) {
    _showCompleted = value;
    notifyListeners();
  }

  void toggleFilter() {
    _showCompleted = !_showCompleted;
    notifyListeners();
  }

  Future<void> showAddDialog() async {
    final response = await _dialogService.showCustomDialog(
      variant: 'addTodo',
    );

    if (response?.confirmed ?? false) {
      final data = response?.data as Map<String, dynamic>;
      final todo = Todo(
        id: DateTime.now().toString(),
        title: data['title'],
        description: data['description'],
        createdAt: DateTime.now(),
      );
      _todoService.addTodo(todo);
      notifyListeners();
    }
  }

  Future<void> showEditDialog(String todoId) async {
    final todo = _todoService.todos.firstWhere((t) => t.id == todoId);

    final response = await _dialogService.showCustomDialog(
      variant: 'editTodo',
      data: todo,
    );

    if (response?.confirmed ?? false) {
      final data = response?.data as Map<String, dynamic>;
      final updatedTodo = todo.copyWith(
        title: data['title'],
        description: data['description'],
      );
      _todoService.updateTodo(updatedTodo);
      notifyListeners();
    }
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
