import 'package:flutter/material.dart';
import 'package:ig_analytics_dashboard/factory/view_factory.dart';
import 'package:ig_analytics_dashboard/utils/constants.dart';
import 'package:ig_analytics_dashboard/view_model/authenticate_view.dart';
import 'package:ig_analytics_dashboard/widgets/ig_dashboard.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SignInWithInstagram extends StatefulWidget {
  @override
  _SignInWithInstagramState createState() => _SignInWithInstagramState();
}

class _SignInWithInstagramState extends State<SignInWithInstagram> {
  AuthenticateView _authenticateView = ViewFactory().get<AuthenticateView>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_authenticateView.state.showSignInWebViewValue == true) {
          _authenticateView.closeWebView();
          return false;
        }
        return true;
      },
      child: Center(
        child: StreamBuilder<bool>(
            stream: _authenticateView.state.showSignInWebView,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.data) {
                return WebView(
                  initialUrl: _authenticateView.state.initialUrl,
                  navigationDelegate: (NavigationRequest request) {
                    if (request.url.startsWith(StringConstants.INSTAGRAM_REDIRECT_URI)) {
                      if (request.url.contains('error')) print('the url error');
                      var startIndex = request.url.indexOf('code=');
                      var endIndex = request.url.lastIndexOf('#');
                      var code = request.url.substring(startIndex + 5, endIndex);
                      _authenticateView.logIn(code).then((value) {
                        if (value) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (BuildContext context) => IGDashboard()));
                        }
                      });
                      return NavigationDecision.prevent;
                    }
                    return NavigationDecision.navigate;
                  },
                  onPageStarted: (url) => print("Page started " + url),
                  javascriptMode: JavascriptMode.unrestricted,
                  gestureNavigationEnabled: true,
                  initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
                );
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/1200px-Instagram_logo_2016.svg.png',
                    height: 120,
                    width: 120,
                  ),
                  SizedBox(
                    height: 56,
                  ),
                  GestureDetector(
                    onTap: () {
                      _authenticateView.signInWithInstagram();
                    },
                    child: Container(
                      height: 56,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Color(0xffe9505f),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Center(
                          child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
