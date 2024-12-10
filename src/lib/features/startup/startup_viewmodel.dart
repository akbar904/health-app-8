import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.router.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService;

  StartupViewModel({required NavigationService navigationService}) 
      : _navigationService = navigationService;

  Future<void> runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));
    await _navigationService.replaceWithHomeView();
  }
}