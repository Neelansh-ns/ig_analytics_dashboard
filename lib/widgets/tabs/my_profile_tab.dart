import 'package:flutter/material.dart';
import 'package:ig_analytics_dashboard/factory/view_factory.dart';
import 'package:ig_analytics_dashboard/models/user.dart';
import 'package:ig_analytics_dashboard/models/user_details.dart';
import 'package:ig_analytics_dashboard/view_model/authenticate_view.dart';
import 'package:ig_analytics_dashboard/view_model/ig_dashboard_view.dart';
import 'package:ig_analytics_dashboard/widgets/chart_section.dart';
import 'package:ig_analytics_dashboard/widgets/rounded_box.dart';

class MyProfileTab extends StatefulWidget {
  @override
  _MyProfileTabState createState() => _MyProfileTabState();
}

class _MyProfileTabState extends State<MyProfileTab> with AutomaticKeepAliveClientMixin {
  AuthenticateView _authenticateView = ViewFactory().get<AuthenticateView>();

  IgDashBoardView _dashBoardView = ViewFactory().get<IgDashBoardView>();

  @override
  void initState() {
    _dashBoardView.getUserData(_authenticateView.state.userValue.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(32).copyWith(bottom: 0),
              // height: 60,
              child: StreamBuilder<User>(
                  stream: _authenticateView.state.user,
                  builder: (context, snapshot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Name :${snapshot.data?.name ?? ''}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'User ID :${snapshot.data?.userId ?? ''}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  }),
            ),
            StreamBuilder<UserDetails>(
                stream: _dashBoardView.state.userDetails,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'User name :${snapshot.data?.username ?? ''}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Bio :${snapshot.data?.biography ?? ''}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Page name :${snapshot.data?.pageName ?? ''}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            CircleAvatar(
                              radius: 48,
                              backgroundImage: NetworkImage(snapshot.data?.profilePic),
                            )
                            // child: Image.network(snapshot.data?.profilePic))
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundedBoxForNumber(
                              title: 'Profile Views',
                              value:
                              snapshot.data.insights.totalProfileViews.toInt().toString(),
                            ),
                            RoundedBoxForNumber(
                              title: 'Total Posts',
                              value: snapshot.data.totalPosts.toString(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundedBoxForNumber(
                              title: 'Reach',
                              value: snapshot.data.insights.totalReach.toInt().toString(),
                            ),
                            RoundedBoxForNumber(
                              title: 'Follower Count',
                              value: snapshot.data.followersCount.toString(),
                            ),
                          ],
                        ),
                        ChartSection(
                          data: snapshot.data.insights.profileViews,
                          title: 'Profile Views ~30 days',
                        ),
                        Divider(
                          height: 0,
                          thickness: 0,
                          indent: 24,
                          endIndent: 24,
                        ),
                        ChartSection(
                          data: snapshot.data.insights.reach,
                          title: 'Reach ~30 days',
                        ),
                        Divider(
                          height: 0,
                          thickness: 0,
                          indent: 24,
                          endIndent: 24,
                        ),
                        ChartSection(
                          data: snapshot.data.insights.impressions,
                          title: 'Impressions ~30 days',
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
