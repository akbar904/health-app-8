import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, StartupViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Todo App',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel(
        navigationService: locator<NavigationService>(),
      );

  @override
  void onViewModelReady(StartupViewModel viewModel) =>
      viewModel.runStartupLogic();
}