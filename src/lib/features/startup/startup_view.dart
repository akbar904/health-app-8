import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/startup/startup_viewmodel.dart';

class StartupView extends StatelessWidget {
  const StartupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      viewModelBuilder: () => StartupViewModel(),
      onModelReady: (viewModel) => viewModel.runStartupLogic(),
      builder: (context, viewModel, child) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
