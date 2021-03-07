import 'package:flutter/material.dart';
import 'package:ig_analytics_dashboard/widgets/rounded_box.dart';

class IGDashboard extends StatefulWidget {
  @override
  _IGDashboardState createState() => _IGDashboardState();
}

class _IGDashboardState extends State<IGDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                Padding(
                  padding: const EdgeInsets.all(16),
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
