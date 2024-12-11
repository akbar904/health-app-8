import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = NavigationService();

  Future<void> runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 2));
    _navigationService.replaceWith('/home-view');
  }
}
