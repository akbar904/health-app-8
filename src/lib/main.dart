import 'package:flutter/material.dart';
import 'package:my_app/app/app.bottomsheets.dart';
import 'package:my_app/app/app.dialogs.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/features/app/app_view.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  runApp(const AppView());
}
