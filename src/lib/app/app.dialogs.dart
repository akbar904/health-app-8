import 'package:my_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:my_app/ui/dialogs/task_dialog/task_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogs() {
  final dialogService = DialogService();

  final builders = {
    DialogType.infoAlert: (context, DialogRequest dialogRequest, 
        Function(DialogResponse) completer) => InfoAlertDialog(
          dialogRequest: dialogRequest,
          onDialogTap: () => completer(DialogResponse()),
        ),
    DialogType.taskDialog: (context, DialogRequest dialogRequest,
        Function(DialogResponse) completer) => TaskDialog(
          dialogRequest: dialogRequest,
          onDialogTap: () => completer(DialogResponse()),
        ),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

enum DialogType { infoAlert, taskDialog }