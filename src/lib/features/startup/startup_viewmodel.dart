import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = NavigationService();

  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 1));
    _navigationService.replaceWith('/home');
  }
}
