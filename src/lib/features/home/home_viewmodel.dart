import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService;

  HomeViewModel({
    required NavigationService navigationService,
  }) : _navigationService = navigationService;

  Future<void> navigateToTodo() async {
    await _navigationService.navigateTo('/todo-view');
  }
}
