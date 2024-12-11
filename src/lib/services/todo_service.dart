import 'package:my_app/models/todo.dart';
import 'package:my_app/features/todo/todo_repository.dart';

class TodoService {
  final TodoRepository _repository;

  TodoService(this._repository);

  Future<List<Todo>> getTodos() async {
    return await _repository.getTodos();
  }

  Future<void> addTodo(Todo todo) async {
    await _repository.addTodo(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await _repository.updateTodo(todo);
  }

  Future<void> deleteTodo(String id) async {
    await _repository.deleteTodo(id);
  }

  Future<void> toggleTodoCompletion(Todo todo) async {
    final updatedTodo = todo.copyWith(
      isCompleted: !todo.isCompleted,
      completedAt: !todo.isCompleted ? DateTime.now() : null,
    );
    await _repository.updateTodo(updatedTodo);
  }
}
