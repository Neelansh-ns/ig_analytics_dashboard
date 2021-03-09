import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ig_analytics_dashboard/factory/view_factory.dart';
import 'package:ig_analytics_dashboard/view_model/authenticate_view.dart';
import 'package:ig_analytics_dashboard/view_model/ig_dashboard_view.dart';
import 'package:ig_analytics_dashboard/widgets/tabs/compare_tab.dart';
import 'package:ig_analytics_dashboard/widgets/tabs/my_profile_tab.dart';
import 'package:ig_analytics_dashboard/widgets/sign_in_with_instagram.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IGDashboard extends StatefulWidget {
  @override
  _IGDashboardState createState() => _IGDashboardState();
}

class _IGDashboardState extends State<IGDashboard> with SingleTickerProviderStateMixin {
  IgDashBoardView _dashBoardView = ViewFactory().get<IgDashBoardView>();

  @override
  void initState() {
    _dashBoardView.state.tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      top: true,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _appBar(context),
          body: TabBarView(
            children: [
              MyProfileTab(),
              CompareTab(),
            ],
          ),
        ),
      ),
    ));
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
          actions: [
            GestureDetector(
                onTap: () async {
                  final cookieManager = CookieManager();
                  cookieManager.clearCookies();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SignInWithInstagram()));
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
          bottom: TabBar(
            tabs: [
              Tab(icon: Text('My Profile')),
              Tab(icon: Text('Compare')),
            ],
          ),
        );
  }
}
