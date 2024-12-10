import 'package:my_app/features/todo/todo_model.dart';
import 'package:my_app/features/todo/todo_repository.dart';

class TodoService {
  final TodoRepository _repository;

  TodoService(this._repository);

  List<Todo> getAllTodos() => _repository.getAllTodos();

  void addTodo(String title) {
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      createdAt: DateTime.now(),
    );
    _repository.addTodo(todo);
  }

  void toggleTodoCompletion(String id) {
    _repository.toggleTodoCompletion(id);
  }

  void deleteTodo(String id) {
    _repository.deleteTodo(id);
  }
}
