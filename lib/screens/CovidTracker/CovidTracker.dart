import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class CovidTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Container(
              height: 200,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(10)
              ),
              child: PieChart(
                animationDuration: const Duration(milliseconds: 1500),
                  dataMap: const {'not-infected': 15, 'infected': 19, 'deaths': 5}),
            )
          ],
        ),
      ),
    );
  }
}
