import 'package:stacked/stacked.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoViewModel extends BaseViewModel {
  final _todoService = TodoService(TodoRepository());
  final _bottomSheetService = BottomSheetService();

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  Future<void> initialize() async {
    setBusy(true);
    await _loadTodos();
    setBusy(false);
  }

  Future<void> _loadTodos() async {
    _todos = await _todoService.getTodos();
    notifyListeners();
  }

  Future<void> addTodo(String title, String description) async {
    final todo = Todo(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    await _todoService.addTodo(todo);
    await _loadTodos();
  }

  Future<void> toggleTodo(Todo todo) async {
    await _todoService.toggleTodoCompletion(todo);
    await _loadTodos();
  }

  Future<void> deleteTodo(String id) async {
    await _todoService.deleteTodo(id);
    await _loadTodos();
  }

  Future<void> showAddTodoSheet() async {
    final result = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: 'Add Todo',
      description: 'Enter todo details',
    );

    if (result?.confirmed ?? false) {
      final data = result?.data as Map<String, String>;
      await addTodo(data['title']!, data['description']!);
    }
  }
}
