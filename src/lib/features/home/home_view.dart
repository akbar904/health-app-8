import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/home/home_viewmodel.dart';
import 'package:my_app/features/home/widgets/todo_list.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: viewModel.toggleSearchBar,
          ),
          PopupMenuButton<String>(
            onSelected: viewModel.handleMenuOption,
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'all',
                child: Text('Show All'),
              ),
              const PopupMenuItem(
                value: 'completed',
                child: Text('Show Completed'),
              ),
              const PopupMenuItem(
                value: 'pending',
                child: Text('Show Pending'),
              ),
              const PopupMenuItem(
                value: 'export',
                child: Text('Export Todos'),
              ),
              const PopupMenuItem(
                value: 'import',
                child: Text('Import Todos'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (viewModel.isSearchVisible)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: viewModel.searchTodos,
                decoration: InputDecoration(
                  hintText: 'Search todos...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: viewModel.clearSearch,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          Expanded(
            child: TodoList(
              todos: viewModel.filteredTodos,
              onToggle: viewModel.toggleTodoCompletion,
              onEdit: viewModel.showEditDialog,
              onDelete: viewModel.deleteTodo,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) => viewModel.initialize();
}
