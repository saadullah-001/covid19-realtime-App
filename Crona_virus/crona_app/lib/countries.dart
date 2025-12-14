import 'package:crona_app/detail_screen.dart';
import 'package:flutter/material.dart';

class Countries extends StatefulWidget {
  final String image;
  final String name;
  final int? totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  const Countries({
    super.key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: 60),
                        ReusableRow(
                          title: 'Total Cases: ',
                          value: widget.totalCases.toString(),
                        ),
                        ReusableRow(
                          title: 'Total Deaths',
                          value: widget.totalDeaths.toString(),
                        ),
                        ReusableRow(
                          title: 'Total Recovered',
                          value: widget.totalRecovered.toString(),
                        ),
                        ReusableRow(
                          title: 'Active Cases',
                          value: widget.active.toString(),
                        ),
                        ReusableRow(
                          title: 'Critical Cases',
                          value: widget.critical.toString(),
                        ),
                        ReusableRow(
                          title: 'Recovered Today',
                          value: widget.todayRecovered.toString(),
                        ),
                        ReusableRow(
                          title: 'Tests Conducted',
                          value: widget.test.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.image),
                  radius: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
