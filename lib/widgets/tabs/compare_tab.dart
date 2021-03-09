import 'package:flutter/material.dart';
import 'package:ig_analytics_dashboard/factory/view_factory.dart';
import 'package:ig_analytics_dashboard/models/other_user_details.dart';
import 'package:ig_analytics_dashboard/view_model/authenticate_view.dart';
import 'package:ig_analytics_dashboard/view_model/ig_dashboard_view.dart';
import 'package:ig_analytics_dashboard/widgets/chart_section.dart';
import 'package:ig_analytics_dashboard/widgets/primary_button.dart';

class CompareTab extends StatefulWidget {
  @override
  _CompareTabState createState() => _CompareTabState();
}

class _CompareTabState extends State<CompareTab> {
  IgDashBoardView _dashBoardView = ViewFactory().get<IgDashBoardView>();
  AuthenticateView _authenticateView = ViewFactory().get<AuthenticateView>();

  @override
  void initState() {
    _dashBoardView.state.textController = new TextEditingController();
    _dashBoardView.state.textController.addListener(() {
      print(_dashBoardView.state.textController.value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _dashBoardView.state.textController,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[400]),
                  hintText: "Enter user name",
                  fillColor: Colors.white70),
            ),
          ),
          Center(
            child: PrimaryButton(
              onTap: () => _dashBoardView.getDataForUserName(_authenticateView.state.userValue.userId),
              buttonText: 'Search',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: StreamBuilder<OtherUserDetails>(
              stream: _dashBoardView.state.otherUserDetails,
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Container();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Media :${snapshot.data?.mediaCount ?? ''}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Total Followers :${snapshot.data?.followersCount ?? ''}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Avg Likes :${snapshot.data?.avgLikes ?? ''}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Avg Comments :${snapshot.data?.avgComments ?? ''}',
                          style: TextStyle(fontSize: 16),
                        )

                      ],
                    ),
                    ChartSection(
                      data: snapshot.data.likes,
                      title: 'Likes ~${snapshot.data.likes.length} posts',
                    ),
                    Divider(
                      height: 0,
                      thickness: 0,
                      indent: 24,
                      endIndent: 24,
                    ),
                    ChartSection(
                      data: snapshot.data.comments,
                      title: 'Comments ~${snapshot.data.comments.length} posts',
                    ),
                  ],
                );
              }
            ),
          )
        ],
      ),
    );
  }
}
