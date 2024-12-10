import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: viewModel.navigateToTodo,
            child: const Text('Go to Todo List'),
          ),
        ),
      ),
    );
  }
}
