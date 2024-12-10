import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/home/home_viewmodel.dart';

class AddTodoButton extends ViewModelWidget<HomeViewModel> {
  const AddTodoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return FloatingActionButton(
      onPressed: viewModel.addTodo,
      child: const Icon(Icons.add),
    );
  }
}
