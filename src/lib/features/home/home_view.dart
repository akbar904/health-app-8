import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Todo App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: viewModel.navigateToTodo,
              child: const Text('View Todos'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel(
        navigationService: locator<NavigationService>(),
      );
}