import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../features/home/home_view.dart';
import '../features/startup/startup_view.dart';
import '../features/todo/todo_view.dart';
import '../ui/bottom_sheets/todo_details/todo_details_sheet.dart';
import '../ui/dialogs/confirm_delete/confirm_delete_dialog.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: TodoView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: TodoRepository),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: TodoDetailsSheet),
  ],
  dialogs: [
    StackedDialog(classType: ConfirmDeleteDialog),
  ],
)
class App {}
