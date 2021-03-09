import 'package:flutter/material.dart';
import 'package:ig_analytics_dashboard/widgets/sparkline_chart.dart';

class ChartSection extends StatelessWidget {
  final List<double> data;
  final String title;

  ChartSection({this.data, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Container(
        height: 160,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
              Container(
                child: Sparkline(
                  data: data,
                  lineWidth: 4.0,
                  pointsMode: PointsMode.all,
                  sharpCorners: false,
                  lineGradient: new LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.purple[800], Colors.purple[200]],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
