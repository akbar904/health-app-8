import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:my_app/app/app.locator.dart';

class TodoViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _dialogService = locator<DialogService>();

  List<TodoModel> get todos => _todoService.todos;

  Future<void> initialize() async {
    setBusy(true);
    await _todoService.initialize();
    setBusy(false);
  }

  Future<void> addTodo(String title) async {
    setBusy(true);
    await _todoService.addTodo(title);
    notifyListeners();
    setBusy(false);
  }

  Future<void> toggleTodo(TodoModel todo) async {
    await _todoService.toggleTodo(todo.id);
    notifyListeners();
  }

  Future<void> showEditSheet(TodoModel todo) async {
    final result = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.editTodo,
      data: todo,
    );

    if (result?.confirmed == true && result?.data != null) {
      await _todoService.updateTodo(result!.data as TodoModel);
      notifyListeners();
    }
  }

  Future<void> deleteTodo(TodoModel todo) async {
    final response = await _dialogService.showDialog(
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
      buttonTitle: 'Delete',
      cancelTitle: 'Cancel',
    );

    if (response?.confirmed ?? false) {
      await _todoService.deleteTodo(todo.id);
      notifyListeners();
    }
  }
}
