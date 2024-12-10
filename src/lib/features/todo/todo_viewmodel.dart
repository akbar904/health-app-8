import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import 'todo_repository.dart';
import 'models/todo_model.dart';
import '../../ui/bottom_sheets/bottom_sheet_type.dart';

class TodoViewModel extends BaseViewModel {
  final _repository = locator<TodoRepository>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  Future<void> initialize() async {
    _todos = await _repository.getTodos();
    rebuildUi();
  }

  Future<void> addTodo(String title, String description) async {
    await _repository.addTodo(
      TodoModel(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        isCompleted: false,
        createdAt: DateTime.now(),
      ),
    );
    initialize();
  }

  Future<void> toggleTodo(String id) async {
    final todo = _todos.firstWhere((t) => t.id == id);
    await _repository.updateTodo(
      todo.copyWith(isCompleted: !todo.isCompleted),
    );
    initialize();
  }

  Future<void> deleteTodo(String id) async {
    await _repository.deleteTodo(id);
    initialize();
  }

  Future<void> showTodoDetails(TodoModel todo) async {
    await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.todoDetails,
      data: todo,
    );
  }
}