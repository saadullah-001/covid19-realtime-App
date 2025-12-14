import 'package:crona_app/Models/world_stats_model.dart';
import 'package:crona_app/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:crona_app/Services/Utilities/state_services.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this,
  )..repeat();

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(11),
          child: Column(
            children: [
              SizedBox(height: 21),
              FutureBuilder(
                future: StateServices().fetchWorldStatsModelAPi(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total': double.parse(
                              snapshot.data!.cases.toString(),
                            ),
                            'Recovered': double.parse(
                              snapshot.data!.recovered.toString(),
                            ),
                            'Deaths': double.parse(
                              snapshot.data!.deaths.toString(),
                            ),
                          },
                          colorList: colorList,
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                          chartRadius: 200,
                          chartType: ChartType.ring,
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          animationDuration: Duration(milliseconds: 1200),
                        ),
                        SizedBox(height: 31),
                        Card(
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .06,
                              ),
                              ReusableRow(
                                title: 'Cases',
                                value: snapshot.data!.cases.toString(),
                              ),
                              ReusableRow(
                                title: 'Recovered',
                                value: snapshot.data!.recovered.toString(),
                              ),
                              ReusableRow(
                                title: 'Death',
                                value: snapshot.data!.deaths.toString(),
                              ),
                              ReusableRow(
                                title: 'Critical',
                                value: snapshot.data!.critical.toString(),
                              ),
                              ReusableRow(
                                title: 'Today Recovered',
                                value: snapshot.data!.todayRecovered.toString(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountriesList(),
                              ),
                            );
                          },

                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(child: Text('Track Countries')),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;

  const ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          SizedBox(height: 5),
          Divider(),
        ],
      ),
    );
  }
}
