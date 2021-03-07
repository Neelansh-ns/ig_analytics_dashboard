import 'package:flutter/material.dart';
import 'package:ig_analytics_dashboard/factory/view_factory.dart';
import 'package:ig_analytics_dashboard/view_model/authenticate_view.dart';
import 'package:ig_analytics_dashboard/widgets/ig_dashboard.dart';
import 'package:ig_analytics_dashboard/widgets/sign_in_with_instagram.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  AuthenticateView _authenticateView = ViewFactory().get<AuthenticateView>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _authenticateView.isUserSignedIn(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }
          return snapshot.data ? IGDashboard() : SignInWithInstagram();
        });
  }
}
