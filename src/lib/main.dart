import 'package:flutter/material.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/features/app/app_view.dart';

void main() {
  setupLocator();
  runApp(const AppView());
}
