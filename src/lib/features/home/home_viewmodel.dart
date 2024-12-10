import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.router.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = NavigationService();

  Future<void> navigateToTodo() async {
    await _navigationService.navigateTo(Routes.todoView);
  }
}
