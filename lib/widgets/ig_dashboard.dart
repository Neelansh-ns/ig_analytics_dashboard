import 'package:flutter/material.dart';
import 'package:ig_analytics_dashboard/factory/view_factory.dart';
import 'package:ig_analytics_dashboard/models/user.dart';
import 'package:ig_analytics_dashboard/view_model/authenticate_view.dart';
import 'package:ig_analytics_dashboard/view_model/ig_dashboard_view.dart';
import 'package:ig_analytics_dashboard/widgets/rounded_box.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IGDashboard extends StatefulWidget {
  @override
  _IGDashboardState createState() => _IGDashboardState();
}

class _IGDashboardState extends State<IGDashboard> {
  AuthenticateView _authenticateView = ViewFactory().get<AuthenticateView>();
  IgDashBoardView _dashBoardView = ViewFactory().get<IgDashBoardView>();

  @override
  void initState() {
    _dashBoardView.getUserData(_authenticateView.state.userValue.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
                onTap: () async {
                  final cookieManager = CookieManager();
                  cookieManager.clearCookies();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        'Logout',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.logout),
                    ],
                  ),
                ))
          ],
          title: Center(
            child: Row(
              children: [
                Text(
                  'Data insights',
                  style: TextStyle(),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(Icons.bar_chart_outlined)
              ],
            ),
          ),
        ),
        body: SafeArea(
          top: true,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(32).copyWith(bottom: 0),
                  height: 60,
                  child: StreamBuilder<User>(
                      stream: _authenticateView.state.user,
                      builder: (context, snapshot) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Name :${snapshot.data?.name ?? ''}',
                              style: TextStyle(fontSize: 22),
                            ),
                            Text(
                              'User ID :${snapshot.data?.userId ?? ''}',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundedBoxForNumber(
                        title: 'Profile Views',
                        value: 24,
                      ),
                      RoundedBoxForNumber(
                        title: 'Total Posts',
                        value: 24,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundedBoxForNumber(
                        title: 'Reach',
                        value: 24,
                      ),
                      RoundedBoxForNumber(
                        title: 'Follower Count',
                        value: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
