import 'package:my_app/app/app.locator.dart';
import 'package:my_app/features/todo/todo_model.dart';
import 'package:my_app/features/todo/todo_repository.dart';

class TodoService {
  final _repository = locator<TodoRepository>();
  List<Todo> _cachedTodos = [];

  List<Todo> get todos => _cachedTodos;

  Future<List<Todo>> getTodos() async {
    try {
      _cachedTodos = await _repository.getTodos();
      return _cachedTodos;
    } catch (e) {
      throw Exception('Failed to get todos: $e');
    }
  }

  Future<void> saveTodos(List<Todo> todos) async {
    try {
      await _repository.saveTodos(todos);
      _cachedTodos = todos;
    } catch (e) {
      throw Exception('Failed to save todos: $e');
    }
  }

  Future<void> addTodo(Todo todo) async {
    _cachedTodos.add(todo);
    await saveTodos(_cachedTodos);
  }

  Future<void> updateTodo(Todo todo) async {
    final index = _cachedTodos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _cachedTodos[index] = todo;
      await saveTodos(_cachedTodos);
    }
  }

  Future<void> deleteTodo(String id) async {
    _cachedTodos.removeWhere((todo) => todo.id == id);
    await saveTodos(_cachedTodos);
  }
}
