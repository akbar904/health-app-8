import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService;

  HomeViewModel(this._navigationService);

  void navigateToTodos() {
    _navigationService.navigateTo('/todos');
  }
}
