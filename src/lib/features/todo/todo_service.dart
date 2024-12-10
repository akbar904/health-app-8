import 'package:my_app/features/todo/todo_model.dart';

class TodoService {
  final List<Todo> _todos = [];

  List<Todo> get todos => List.unmodifiable(_todos);

  void addTodo(String title) {
    final todo = Todo(
      id: DateTime.now().toIso8601String(),
      title: title,
      createdAt: DateTime.now(),
    );
    _todos.add(todo);
  }

  void toggleTodo(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = todo.copyWith(isCompleted: !todo.isCompleted);
    }
  }

  void updateTodo(String id, String title) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(title: title);
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }

  void clearCompletedTodos() {
    _todos.removeWhere((todo) => todo.isCompleted);
  }
}
