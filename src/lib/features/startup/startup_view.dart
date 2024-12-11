import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/startup/startup_viewmodel.dart';

class StartupView extends StatelessWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      viewModelBuilder: () => StartupViewModel(),
      onViewModelReady: (model) => model.runStartupLogic(),
      builder: (context, model, child) {
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Starting...',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 16),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
