import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.bottomsheets.dart';
import 'package:my_app/app/app.dialogs.dart';
import 'package:my_app/features/todo/models/todo.dart';
import 'package:my_app/features/todo/todo_repository.dart';

class TodoViewModel extends BaseViewModel {
  final _todoRepository = locator<TodoRepository>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _dialogService = locator<DialogService>();

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  TodoViewModel() {
    loadTodos();
  }

  Future<void> loadTodos() async {
    setBusy(true);
    _todos = await _todoRepository.getTodos();
    setBusy(false);
  }

  Future<void> addTodo(String title, String description) async {
    final todo = Todo(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    await _todoRepository.addTodo(todo);
    await loadTodos();
  }

  Future<void> toggleTodoComplete(Todo todo) async {
    await _todoRepository.updateTodo(
      todo.copyWith(isCompleted: !todo.isCompleted),
    );
    await loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.deleteTodo,
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
    );

    if (response?.confirmed ?? false) {
      await _todoRepository.deleteTodo(todo.id);
      await loadTodos();
    }
  }

  Future<void> showAddTodoSheet() async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addTodo,
    );

    if (response?.confirmed ?? false) {
      final data = response?.data as Map<String, String>;
      await addTodo(data['title']!, data['description']!);
    }
  }
}
