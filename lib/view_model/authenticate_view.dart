import 'package:http/http.dart' as http;
import 'package:ig_analytics_dashboard/factory/base_view.dart';
import 'package:ig_analytics_dashboard/factory/base_view_state.dart';
import 'package:ig_analytics_dashboard/utils/constants.dart';
import 'package:ig_analytics_dashboard/utils/string_helper.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthenticateView extends BaseView<AuthenticateViewState> {
  @override
  initializeState() {
    return AuthenticateViewState();
  }

  Future<bool> isUserSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    state._userId = prefs.getString('userId');
    state._token = prefs.getString('token');
    print(state.userId.isValid && state.token.isValid);
    return (state.userId.isValid && state.token.isValid);
  }

  Future<void> signInWithInstagram() async {
    state._showSignInWebView.add(true);
    isLoading(true);
    print('Sign In Clicked');
  }

  Future<bool> logIn(String code) async {
    print(code);
    var url = 'https://6etkn5v0ik.execute-api.us-east-1.amazonaws.com/login?code=$code';
    Uri uri = Uri.parse(url);
    print(uri);
    return http.get(uri).then((response) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
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
}

class AuthenticateViewState extends BaseViewState {
  BehaviorSubject<bool> _isLoading = BehaviorSubject.seeded(false);

  Stream<bool> get isLoading => _isLoading;
  String initialUrl =
      'https://www.facebook.com/v10.0/dialog/oauth?client_id=${StringConstants.INSTAGRAM_APP_ID}&redirect_uri=${StringConstants.INSTAGRAM_REDIRECT_URI}&scope=pages_show_list,instagram_basic,instagram_manage_insights';

  BehaviorSubject<bool> _showSignInWebView = BehaviorSubject.seeded(false);

  Stream<bool> get showSignInWebView => _showSignInWebView;

  bool get showSignInWebViewValue => _showSignInWebView.value;
  String _userId;
  String _token;

  String get userId => _userId;

  String get token => _token;

  @override
  dispose() {
    _isLoading.close();
    _showSignInWebView.close();
  }
}
