import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/enums/dialog_type.dart';
import 'package:my_app/enums/bottom_sheet_type.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  int _counter = 0;
  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void navigateToTodos() {
    _navigationService.navigateToTodoView();
  }

  Future<void> showDialog() async {
    await _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Dialog',
      description: 'This is a stacked dialog',
    );
  }

  Future<void> showBottomSheet() async {
    await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: 'Stacked Bottom Sheet',
      description: 'This is a stacked bottom sheet',
    );
  }
}