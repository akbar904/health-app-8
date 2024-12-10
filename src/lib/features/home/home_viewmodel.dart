import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.dialogs.dart';
import 'package:my_app/models/todo_model.dart';
import 'package:my_app/services/todo_service.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();

  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;

  List<TodoModel> _filteredTodos = [];
  List<TodoModel> get filteredTodos => _filteredTodos;

  bool _isSearchVisible = false;
  bool get isSearchVisible => _isSearchVisible;

  String _filterMode = 'all';
  String _searchQuery = '';

  void initialize() {
    refreshTodos();
  }

  void refreshTodos() {
    _todos = _todoService.getAllTodos();
    _applyFilters();
  }

  void toggleSearchBar() {
    _isSearchVisible = !_isSearchVisible;
    if (!_isSearchVisible) {
      _searchQuery = '';
      _applyFilters();
    }
    notifyListeners();
  }

  void searchTodos(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void clearSearch() {
    _searchQuery = '';
    _applyFilters();
    toggleSearchBar();
  }

  void _applyFilters() {
    var filtered = _todos;

    // Apply filter mode
    switch (_filterMode) {
      case 'completed':
        filtered = filtered.where((todo) => todo.isCompleted).toList();
        break;
      case 'pending':
        filtered = filtered.where((todo) => !todo.isCompleted).toList();
        break;
    }

    // Apply search
    if (_searchQuery.isNotEmpty) {
      filtered = _todoService.searchTodos(_searchQuery);
    }

    _filteredTodos = filtered;
    notifyListeners();
  }

  void handleMenuOption(String value) {
    _filterMode = value;
    switch (value) {
      case 'export':
        _exportTodos();
        break;
      case 'import':
        _importTodos();
        break;
      default:
        _applyFilters();
    }
  }

  void _exportTodos() {
    final jsonString = _todoService.exportTodosToJson();
    // Handle export logic here
  }

  void _importTodos() {
    // Handle import logic here
    refreshTodos();
  }

  Future<void> showAddDialog() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.addTodo,
    );

    if (response?.confirmed == true && response?.data != null) {
      final TodoModel newTodo = response!.data as TodoModel;
      _todoService.addTodo(newTodo);
      refreshTodos();
    }
  }

  Future<void> showEditDialog(TodoModel todo) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.editTodo,
      data: todo,
    );

    if (response?.confirmed == true && response?.data != null) {
      final TodoModel updatedTodo = response!.data as TodoModel;
      _todoService.updateTodo(updatedTodo);
      refreshTodos();
    }
  }

  void toggleTodoCompletion(String id) {
    _todoService.toggleTodoCompletion(id);
    refreshTodos();
  }

  void deleteTodo(String id) {
    _todoService.deleteTodo(id);
    refreshTodos();
  }
}
