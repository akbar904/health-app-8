import 'package:my_app/features/todo/todo_model.dart';
import 'package:my_app/features/todo/todo_repository.dart';

class TodoService {
  final TodoRepository _repository;

  TodoService(this._repository);

  List<TodoModel> getTodos() {
    return _repository.getTodos();
  }

  void addTodo(TodoModel todo) {
    _repository.addTodo(todo);
  }

  void toggleTodo(String id) {
    _repository.toggleTodo(id);
  }

  void deleteTodo(String id) {
    _repository.deleteTodo(id);
  }

  void updateTodo(TodoModel todo) {
    _repository.updateTodo(todo);
  }
}
