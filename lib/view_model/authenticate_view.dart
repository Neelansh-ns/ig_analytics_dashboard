import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ig_analytics_dashboard/factory/base_view.dart';
import 'package:ig_analytics_dashboard/factory/base_view_state.dart';
import 'package:ig_analytics_dashboard/models/user.dart';
import 'package:ig_analytics_dashboard/utils/constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticateView extends BaseView<AuthenticateViewState> {
  @override
  initializeState() {
    return AuthenticateViewState();
  }

  Future<bool> isUserSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future.value(false);
  }

  Future<void> signInWithInstagram() async {
    state._showSignInWebView.add(true);
    isLoading(true);
    print('Sign In Clicked');
  }

  Future<bool> logIn(String code) async {
    print(code);
    var url = '${StringConstants.LAMBDA_ENDPOINT}/login?code=$code';
    Uri uri = Uri.parse(url);
    print(uri);
    return http.get(uri).then((response) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${jsonDecode(response.body)}');
      saveUserData(User(
          name: jsonDecode(response.body)['user']['body']['name'],
          userId: (jsonDecode(response.body)['user']['body']['id']).toString()));
      return response.statusCode == 200;
    }).onError((error, stackTrace) {
      print('Error caught in login(): $error $stackTrace');
      return false;
    }).whenComplete(() {
      state._showSignInWebView.add(false);
    });
  }

  closeWebView() {
    state._showSignInWebView.add(false);
  }

  isLoading(bool isLoading) {
    state._isLoading.add(isLoading);
  }

  void saveUserData(User user) {
    state._user.add(user);
  }
}

class AuthenticateViewState extends BaseViewState {
  Stream<User> get user => _user;
  BehaviorSubject<User> _user = BehaviorSubject();

  User get userValue => _user.value;

  BehaviorSubject<bool> _isLoading = BehaviorSubject.seeded(false);

  Stream<bool> get isLoading => _isLoading;
  String initialUrl =
      'https://www.facebook.com/v10.0/dialog/oauth?client_id=${StringConstants.INSTAGRAM_APP_ID}&redirect_uri=${StringConstants.INSTAGRAM_REDIRECT_URI}&scope=pages_show_list,instagram_basic,instagram_manage_insights';

  BehaviorSubject<bool> _showSignInWebView = BehaviorSubject.seeded(false);

  bool get showSignInWebViewValue => _showSignInWebView.value;

  Stream<bool> get showSignInWebView => _showSignInWebView;

  // bool get showSignInWebViewValue => _showSignInWebView.value;

  @override
  dispose() {
    _isLoading.close();
    _showSignInWebView.close();
    _user.close();
  }
}
