import 'package:my_app/models/todo_model.dart';
import 'package:my_app/services/todo_repository.dart';
import 'package:uuid/uuid.dart';

class TodoService {
  final TodoRepository _repository;
  final _uuid = const Uuid();

  TodoService(this._repository);

  Future<List<TodoModel>> getTodos() async {
    return _repository.getTodos();
  }

  Future<void> addTodo(String title) async {
    final todo = TodoModel(
      id: _uuid.v4(),
      title: title,
    );
    await _repository.addTodo(todo);
  }

  Future<void> toggleTodoStatus(TodoModel todo) async {
    final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
    await _repository.updateTodo(updatedTodo);
  }

  Future<void> deleteTodo(String id) async {
    await _repository.deleteTodo(id);
  }

  Future<void> updateTodoTitle(String id, String newTitle) async {
    final todos = await _repository.getTodos();
    final todo = todos.firstWhere((t) => t.id == id);
    final updatedTodo = todo.copyWith(title: newTitle);
    await _repository.updateTodo(updatedTodo);
  }
}