import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/startup/startup_viewmodel.dart';
import 'package:gap/gap.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({super.key});

  @override
  Widget builder(
      BuildContext context, StartupViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.task_alt,
              size: 100,
            ),
            const Gap(16),
            Text(
              'Todo App',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(8),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();
}
