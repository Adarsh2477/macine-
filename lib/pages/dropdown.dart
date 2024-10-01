// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
//
//
//
// class dtrdtdrtt extends StatefulWidget {
//   @override
//   _dtrdtdrttState createState() => _dtrdtdrttState();
// }
//
// class _dtrdtdrttState extends State<dtrdtdrtt> {
//   bool _isFirstGraphVisible = true;
//   bool _isSecondGraphVisible = true;
//
//   void _toggleGraphVisibility() {
//     setState(() {
//       _isFirstGraphVisible = !_isFirstGraphVisible;
//       _isSecondGraphVisible = !_isSecondGraphVisible;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Toggle Graph Visibility'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _isFirstGraphVisible ? FirstGraph() : SecondGraph(),
//             _isSecondGraphVisible ? FirstGraph() : SecondGraph(),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _toggleGraphVisibility,
//               child: Text(_isFirstGraphVisible ? _isSecondGraphVisible?'Show Second Graph' : 'Show First Graph'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class FirstGraph extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       width: 300,
//       child: charts.LineChart(
//         _createSampleData(),
//         animate: true,
//       ),
//     );
//   }
//
//   List<charts.Series<LinearSales, int>> _createSampleData() {
//     final data = [
//       LinearSales(0, 5),
//       LinearSales(1, 25),
//       LinearSales(2, 100),
//       LinearSales(3, 75),
//     ];
//
//     return [
//       charts.Series<LinearSales, int>(
//         id: 'Sales',
//         domainFn: (LinearSales sales, _) => sales.year,
//         measureFn: (LinearSales sales, _) => sales.sales,
//         data: data,
//       ),
//     ];
//   }
// }
//
// class SecondGraph extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       width: 300,
//       child: charts.BarChart(
//         _createSampleData(),
//         animate: true,
//       ),
//     );
//   }
//
//   List<charts.Series<OrdinalSales, String>> _createSampleData() {
//     final data = [
//       OrdinalSales('2014', 5),
//       OrdinalSales('2015', 25),
//       OrdinalSales('2016', 100),
//       OrdinalSales('2017', 75),
//     ];
//
//     return [
//       charts.Series<OrdinalSales, String>(
//         id: 'Sales',
//         domainFn: (OrdinalSales sales, _) => sales.year,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//         data: data,
//       ),
//     ];
//   }
// }
//
// class LinearSales {
//   final int year;
//   final int sales;
//
//   LinearSales(this.year, this.sales);
// }
//
// class OrdinalSales {
//   final String year;
//   final int sales;
//
//   OrdinalSales(this.year, this.sales);
// }