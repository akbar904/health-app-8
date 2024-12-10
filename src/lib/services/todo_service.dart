import 'package:my_app/features/todo/todo_repository.dart';
import 'package:my_app/models/todo_model.dart';

class TodoService {
  final TodoRepository _repository;

  TodoService(this._repository);

  Future<List<TodoModel>> getTodos() async {
    return await _repository.getTodos();
  }

  Future<void> addTodo(String title) async {
    final todo = TodoModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      createdAt: DateTime.now(),
    );
    await _repository.addTodo(todo);
  }

  Future<void> toggleTodoStatus(TodoModel todo) async {
    final updatedTodo = todo.copyWith(
      isCompleted: !todo.isCompleted,
      completedAt: !todo.isCompleted ? DateTime.now() : null,
    );
    await _repository.updateTodo(updatedTodo);
  }

  Future<void> deleteTodo(String id) async {
    await _repository.deleteTodo(id);
  }

  Future<void> updateTodoTitle(String id, String newTitle) async {
    final todo = (await _repository.getTodos()).firstWhere((t) => t.id == id);
    final updatedTodo = todo.copyWith(title: newTitle);
    await _repository.updateTodo(updatedTodo);
  }
}
