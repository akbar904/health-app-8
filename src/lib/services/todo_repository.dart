import 'package:my_app/models/todo_model.dart';

class TodoRepository {
  final List<TodoModel> _todos = [];

  TodoRepository();

  Future<List<TodoModel>> getTodos() async {
    return _todos;
  }

  Future<void> addTodo(TodoModel todo) async {
    _todos.add(todo);
  }

  Future<void> updateTodo(TodoModel updatedTodo) async {
    final index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      _todos[index] = updatedTodo;
    }
  }

  Future<void> deleteTodo(String id) async {
    _todos.removeWhere((todo) => todo.id == id);
  }
}