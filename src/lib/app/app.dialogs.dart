// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/add_todo/add_todo_dialog.dart';
import '../ui/dialogs/edit_todo/edit_todo_dialog.dart';
import '../ui/dialogs/info_alert/info_alert_dialog.dart';

enum DialogType {
  infoAlert,
  addTodo,
  editTodo,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.infoAlert: (context, request, completer) =>
        InfoAlertDialog(request: request, completer: completer),
    DialogType.addTodo: (context, request, completer) =>
        AddTodoDialog(request: request, completer: completer),
    DialogType.editTodo: (context, request, completer) =>
        EditTodoDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
