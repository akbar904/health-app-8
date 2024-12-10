import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:my_app/ui/widgets/todo_item.dart';
import 'package:my_app/ui/widgets/add_todo_form.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/todo/todo_viewmodel.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoViewModel>.reactive(
      viewModelBuilder: () => TodoViewModel(),
      onViewModelReady: (model) => model.initialize(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: Column(
          children: [
            AddTodoForm(
              onSubmit: model.addTodo,
            ),
            const Gap(16),
            Expanded(
              child: model.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: model.todos.length,
                      itemBuilder: (context, index) {
                        final todo = model.todos[index];
                        return TodoItem(
                          todo: todo,
                          onToggle: (value) => model.toggleTodo(todo),
                          onEdit: () => model.showEditSheet(todo),
                          onDelete: () => model.deleteTodo(todo),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
