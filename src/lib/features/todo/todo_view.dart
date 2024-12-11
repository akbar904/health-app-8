import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/todo/todo_viewmodel.dart';
import 'package:my_app/features/todo/widgets/todo_input.dart';
import 'package:my_app/features/todo/widgets/todo_item.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoViewModel>.reactive(
      viewModelBuilder: () => TodoViewModel(),
      onViewModelReady: (model) => model.initialize(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo List'),
            actions: [
              IconButton(
                icon: const Icon(Icons.sort),
                onPressed: model.toggleSortOrder,
              ),
            ],
          ),
          body: Column(
            children: [
              TodoInput(
                onSubmit: model.addTodo,
              ),
              Expanded(
                child: model.isBusy
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: model.todos.length,
                        itemBuilder: (context, index) {
                          final todo = model.todos[index];
                          return TodoItem(
                            todo: todo,
                            onToggle: model.toggleTodo,
                            onDelete: model.deleteTodo,
                            onEdit: model.editTodo,
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: model.showAddTodoDialog,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
