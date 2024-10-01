import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LineChartExample extends StatefulWidget {
  @override
  _LineChartExampleState createState() => _LineChartExampleState();
}

class _LineChartExampleState extends State<LineChartExample> {
  List<Map<String, dynamic>> data = [];
  bool heightVisible = true;
  bool weightVisible = true;
  bool bmiVisible = true;

  String empid = "";
  String username = "";
  String companyurl = "";
  Future<void> _loadCompanyCode() async {
    final prefs = await SharedPreferences.getInstance();
    empid = prefs.getString('empid') ?? '';
    username = prefs.getString('username') ?? '';
    companyurl = prefs.getString('companyurl') ?? '';
  }

  @override
  void initState() {
    _loadCompanyCode();
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Replace 'your_php_api_url' with the actual URL of your PHP script.

    await Future.delayed(Duration(seconds: 0));
    final response = await http.get(Uri.parse(companyurl+'api2/osigrafh.php?id=${empid}'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      print(responseData);
      setState(() {
        data = responseData.cast<Map<String, dynamic>>();
        // Convert height values to doubles with validation
        data.forEach((item) {
          item['MONTH'] = parseDouble(item['MONTH']);
          item['OPD_COUNT'] = parseDouble(item['OPD_COUNT']);
          item['INJURY_COUNT'] = parseDouble(item['INJURY_COUNT']);
          item['SICKNESS_COUNT'] = parseDouble(item['SICKNESS_COUNT']);
        });
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  double parseDouble(dynamic value) {
    try {
      return double.parse(value.toString());
    } catch (e) {
      // Handle the case when parsing fails
      return 0.0; // or any default value you prefer
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 300,
                width: 400,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:
                    LineChart(
                      LineChartData(
                        extraLinesData: ExtraLinesData(extraLinesOnTop: true),

                        gridData: FlGridData(show: true, ),
                        titlesData: const FlTitlesData(rightTitles: AxisTitles(sideTitles: SideTitles()),topTitles: AxisTitles(sideTitles: SideTitles())),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                            color: const Color(0xff37434d),
                            width: 0.5,
                          ),
                        ),
                        // minX: 0,
                        // minY: 0,
                        lineBarsData: [
                          LineChartBarData(
                            spots: List.generate(
                              data.length,
                                  (index) => FlSpot(data[index]['MONTH'], data[index]['OPD_COUNT']),
                            ),
                            isCurved: false,
                            color: Colors.blue,
                            dotData: FlDotData(show: true),
                            belowBarData: BarAreaData(show: false,spotsLine:const BarAreaSpotsLine()),
                            barWidth: heightVisible ? 5 : 0,
                          ),
                          LineChartBarData(
                            spots: List.generate(
                              data.length,
                                  (index) => FlSpot(data[index]['MONTH'], data[index]['INJURY_COUNT']),
                            ),
                            isCurved: false,
                            color: Colors.yellow,
                            dotData: FlDotData(show: true),
                            barWidth: weightVisible ? 5 : 0,
                            belowBarData: BarAreaData(show: false,spotsLine:const BarAreaSpotsLine()),
                          ),
                          LineChartBarData(
                            spots: List.generate(
                              data.length,
                                  (index) => FlSpot(data[index]['MONTH'], data[index]['SICKNESS_COUNT']),
                            ),
                            isCurved: false,
                            color: Colors.green,
                            barWidth: bmiVisible ? 5 : 0,
                            dotData: FlDotData(show: true),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    setState(() {
                      heightVisible = !heightVisible; // Toggle visibility
                    });
                  },
                  child: Text(heightVisible ? 'OPD' : 'OPD'),
                ),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    setState(() {
                      weightVisible = !weightVisible; // Toggle visibility
                    });
                  },
                  child: Text(weightVisible ? 'INJURY' : 'INJURY'),
                ),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    setState(() {
                      bmiVisible = !bmiVisible; // Toggle visibility
                    });
                  },

                  child: Text(bmiVisible ? 'SICKNESS' : 'SICKNESS'),
                ),
              ],
            ),
          ],
        ),
      );
  }
}