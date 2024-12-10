import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'models/todo_model.dart';
import 'todo_repository.dart';

class TodoViewModel extends BaseViewModel {
  final TodoRepository _repository;
  final DialogService _dialogService;
  final BottomSheetService _bottomSheetService;

  TodoViewModel({
    required TodoRepository repository,
    required DialogService dialogService,
    required BottomSheetService bottomSheetService,
  })  : _repository = repository,
        _dialogService = dialogService,
        _bottomSheetService = bottomSheetService;

  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  Future<void> initialize() async {
    setBusy(true);
    await loadTodos();
    setBusy(false);
  }

  Future<void> loadTodos() async {
    _todos = await _repository.getTodos();
    notifyListeners();
  }

  Future<void> addTodo(String title, String description) async {
    final todo = TodoModel(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    await _repository.addTodo(todo);
    await loadTodos();
  }

  Future<void> toggleTodo(String id) async {
    final todo = _todos.firstWhere((todo) => todo.id == id);
    final updatedTodo = todo.copyWith(
      isCompleted: !todo.isCompleted,
      completedAt: !todo.isCompleted ? DateTime.now() : null,
    );
    await _repository.updateTodo(updatedTodo);
    await loadTodos();
  }

  Future<void> deleteTodo(String id) async {
    final result = await _dialogService.showCustomDialog(
      variant: 'confirmDelete',
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
    );

    if (result?.confirmed ?? false) {
      await _repository.deleteTodo(id);
      await loadTodos();
    }
  }

  Future<void> showTodoDetails(TodoModel todo) async {
    await _bottomSheetService.showCustomSheet(
      variant: 'todoDetails',
      data: todo,
    );
  }
}
