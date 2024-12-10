import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService;

  StartupViewModel(this._navigationService);

  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 2));
    _navigationService.replaceWith('/home');
  }
}
