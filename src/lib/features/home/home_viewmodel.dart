import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:my_app/services/todo_service.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  bool _sortAscending = true;

  List<TodoModel> get todos {
    final todosList = _todoService.todos;
    if (_sortAscending) {
      todosList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    } else {
      todosList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }
    return todosList;
  }

  void toggleSortOrder() {
    _sortAscending = !_sortAscending;
    notifyListeners();
  }

  Future<void> addTodo() async {
    final response = await _dialogService.showCustomDialog(
      variant: 'todoForm',
      title: 'Add Todo',
    );

    if (response?.confirmed == true && response?.data != null) {
      final Map<String, dynamic> data = response!.data as Map<String, dynamic>;
      final todo = TodoModel(
        id: DateTime.now().toString(),
        title: data['title'] as String,
        description: (data['description'] as String?) ?? '',
        dueDate: data['dueDate'] as DateTime?,
        isCompleted: false,
        createdAt: DateTime.now(),
      );
      _todoService.addTodo(todo);
      notifyListeners();
    }
  }

  Future<void> editTodo(TodoModel todo) async {
    final response = await _dialogService.showCustomDialog(
      variant: 'todoForm',
      title: 'Edit Todo',
      data: {
        'title': todo.title,
        'description': todo.description,
        'dueDate': todo.dueDate,
      },
    );

    if (response?.confirmed == true && response?.data != null) {
      final Map<String, dynamic> data = response!.data as Map<String, dynamic>;
      final updatedTodo = todo.copyWith(
        title: data['title'] as String?,
        description: data['description'] as String?,
        dueDate: data['dueDate'] as DateTime?,
      );
      _todoService.updateTodo(updatedTodo);
      notifyListeners();
    }
  }

  void toggleTodoComplete(bool? isCompleted, TodoModel todo) {
    if (isCompleted != null) {
      final updatedTodo = todo.copyWith(isCompleted: isCompleted);
      _todoService.updateTodo(updatedTodo);
      notifyListeners();
    }
  }

  void deleteTodo(TodoModel todo) {
    _todoService.deleteTodo(todo.id);
    notifyListeners();
  }
}