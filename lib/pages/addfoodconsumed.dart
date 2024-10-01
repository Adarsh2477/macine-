// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';
// //
// // class Addfood extends StatefulWidget {
// //   const Addfood({Key? key}) : super(key: key);
// //
// //   @override
// //   State<Addfood> createState() => _AddfoodState();
// // }
// //
// // class _AddfoodState extends State<Addfood> {
// //   DateTime selectedDate = DateTime.now();
// //   TextEditingController searchController = TextEditingController();
// //
// //   // Function to format the date
// //   String getFormattedDate(DateTime date) {
// //     return DateFormat('dd-MM-yyyy').format(date);
// //   }
// //
// //   // Function to handle date change
// //   void _changeDate(int days) {
// //     setState(() {
// //       selectedDate = selectedDate.add(Duration(days: days));
// //     });
// //   }
// //
// //   // Function to show date picker
// //   Future<void> _selectDate(BuildContext context) async {
// //     final DateTime? pickedDate = await showDatePicker(
// //       context: context,
// //       initialDate: selectedDate,
// //       firstDate: DateTime(2000),
// //       lastDate: DateTime(2101),
// //     );
// //     if (pickedDate != null && pickedDate != selectedDate) {
// //       setState(() {
// //         selectedDate = pickedDate;
// //       });
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("ADD FOOD CONSUMED"),
// //       ),
// //       body: Stack(
// //         children: [
// //           Container(
// //             decoration: BoxDecoration(
// //               color: Colors.grey[200], // Background color
// //               image: DecorationImage(
// //                 image: AssetImage("assets/background.jpg"), // Replace with your image asset
// //                 fit: BoxFit.cover,
// //                 colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.dstATop),
// //               ),
// //             ),
// //             child: Column(
// //               children: [
// //                 Expanded(
// //                   child: SingleChildScrollView(
// //                     child: Container(
// //                       padding: EdgeInsets.symmetric(horizontal: 20),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           SizedBox(height: 20),
// //                           // Search box
// //                           Padding(
// //                             padding: const EdgeInsets.all(8.0),
// //                             child: TextField(
// //                               controller: searchController,
// //                               decoration: InputDecoration(
// //                                 prefixIcon: Icon(Icons.search),
// //                                 hintText: 'Search food item',
// //                                 border: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(8.0),
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                           // Date selector
// //                           Padding(
// //                             padding: const EdgeInsets.all(8.0),
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               children: [
// //                                 Transform.rotate(
// //                                   angle: -0.2, // Rotate counterclockwise
// //                                   child: IconButton(
// //                                     icon: Icon(Icons.arrow_back_ios, color: Colors.red, size: 30),
// //                                     onPressed: () => _changeDate(-1),
// //                                   ),
// //                                 ),
// //                                 Row(
// //                                   children: [
// //                                     TextButton(
// //                                       onPressed: () => _selectDate(context),
// //                                       child: Text(
// //                                         getFormattedDate(selectedDate),
// //                                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //                                       ),
// //                                     ),
// //                                     IconButton(
// //                                       icon: Icon(Icons.calendar_today),
// //                                       onPressed: () => _selectDate(context),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 Transform.rotate(
// //                                   angle: 0.2, // Rotate clockwise
// //                                   child: IconButton(
// //                                     icon: Icon(Icons.arrow_forward_ios, color: Colors.red, size: 30),
// //                                     onPressed: () => _changeDate(1),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                           // Displaying the indicators directly without ExpansionTile
// //                           Padding(
// //                             padding: const EdgeInsets.all(10.0),
// //                             child: SingleChildScrollView(
// //                               scrollDirection: Axis.horizontal,
// //                               child: Row(
// //                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                                 children: List.generate(8, (indicatorIndex) {
// //                                   List<String> titles = [
// //                                     'Food Name',
// //                                     'Quantity in grams',
// //                                     'Calories',
// //                                     'Protein added',
// //                                     'Sugar',
// //                                     'Deep Fried',
// //                                     'Maida',
// //                                     ''
// //                                   ];
// //                                   List<String> values = [
// //                                     'Roti', '80', '100', '80%', '50', 'Yes', 'No', ''
// //                                   ];
// //                                   // Add more sets of values here
// //                                   return Container(
// //                                     margin: EdgeInsets.symmetric(horizontal: 10),
// //                                     child: Column(
// //                                       crossAxisAlignment: CrossAxisAlignment.center,
// //                                       children: [
// //                                         Container(
// //                                           width: 60, // Width of the colored strip
// //                                           height: 5, // Height of the colored strip
// //                                           color: Colors.blue, // Color of the strip
// //                                           margin: const EdgeInsets.only(bottom: 5.0),
// //                                         ),
// //                                         Padding(
// //                                           padding: const EdgeInsets.symmetric(vertical: 5.0),
// //                                           child: Text(
// //                                             titles[indicatorIndex % 8],
// //                                             style: TextStyle(
// //                                               fontWeight: FontWeight.bold,
// //                                               color: Colors.black, // Color of the title text
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         Padding(
// //                                           padding: const EdgeInsets.symmetric(vertical: 5.0),
// //                                           child: Text(
// //                                             values[indicatorIndex % 8],
// //                                             style: TextStyle(color: Colors.grey),
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   );
// //                                 }),
// //                               ),
// //                             ),
// //                           ),
// //                           // Add other widgets here if necessary
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           // Define the action for the floating button
// //           // For example, navigate to another page or show a dialog
// //         },
// //         child: Icon(Icons.add),
// //         backgroundColor: Colors.red,
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../models/addfood.dart';
//
// class Addfood extends StatefulWidget {
//   const Addfood({Key? key}) : super(key: key);
//
//   @override
//   State<Addfood> createState() => _AddfoodState();
// }
//
// class _AddfoodState extends State<Addfood> {
//   DateTime selectedDate = DateTime.now();
//   TextEditingController searchController = TextEditingController();
//
//   // Function to format the date
//   String getFormattedDate(DateTime date) {
//     return DateFormat('dd-MM-yyyy').format(date);
//   }
//
//   // Function to handle date change
//   void _changeDate(int days) {
//     setState(() {
//       selectedDate = selectedDate.add(Duration(days: days));
//     });
//   }
//
//   // Function to show date picker
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (pickedDate != null && pickedDate != selectedDate) {
//       setState(() {
//         selectedDate = pickedDate;
//       });
//     }
//   }
//
//   // Function to handle edit action
//   void _editFood(int index) {
//     // Implement the edit action here
//     // For example, navigate to an edit page or show a dialog to edit the food item
//   }
//
//   // Function to handle delete action
//   void _deleteFood(int index) {
//     // Implement the delete action here
//     // For example, remove the food item from the list
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("ADD FOOD CONSUMED"),
//         backgroundColor: Colors.teal,
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.teal.shade100, Colors.teal.shade400],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 20),
//                           // Search box
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: TextField(
//                               controller: searchController,
//                               decoration: InputDecoration(
//                                 prefixIcon: Icon(Icons.search),
//                                 hintText: 'Search food item',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           // Date selector
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Transform.rotate(
//                                   angle: -0.2, // Rotate counterclockwise
//                                   child: IconButton(
//                                     icon: Icon(Icons.arrow_back_ios, color: Colors.red, size: 30),
//                                     onPressed: () => _changeDate(-1),
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     TextButton(
//                                       onPressed: () => _selectDate(context),
//                                       child: Text(
//                                         getFormattedDate(selectedDate),
//                                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                     IconButton(
//                                       icon: Icon(Icons.calendar_today),
//                                       onPressed: () => _selectDate(context),
//                                     ),
//                                   ],
//                                 ),
//                                 Transform.rotate(
//                                   angle: 0.2, // Rotate clockwise
//                                   child: IconButton(
//                                     icon: Icon(Icons.arrow_forward_ios, color: Colors.red, size: 30),
//                                     onPressed: () => _changeDate(1),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // Titles row
//                           Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: List.generate(8, (index) {
//                                   List<String> titles = [
//                                     'Food Name',
//                                     'Quantity in grams',
//                                     'Calories',
//                                     'Protein added',
//                                     'Sugar',
//                                     'Deep Fried',
//                                     'Maida',
//                                     'Actions'
//                                   ];
//                                   return Container(
//                                     margin: EdgeInsets.symmetric(horizontal: 10),
//                                     child: Text(
//                                       titles[index],
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                               ),
//                             ),
//                           ),
//                           // Displaying the food items with Edit and Delete icons
//                           Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Column(
//                                 children: List.generate(1, (index) {
//                                   List<String> values = [
//                                     'Roti', '80', '100', '80%', '50', 'Yes', 'No', ''
//                                   ];
//                                   return Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: List.generate(values.length, (i) {
//                                       return Container(
//                                         margin: EdgeInsets.symmetric(horizontal: 10),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           children: [
//                                             if (i != values.length - 1)
//                                               Padding(
//                                                 padding: const EdgeInsets.symmetric(vertical: 5.0),
//                                                 child: Text(
//                                                   values[i],
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.white,
//                                                   ),
//                                                 ),
//                                               ),
//                                             if (i == values.length - 1)
//                                               Row(
//                                                 children: [
//                                                   IconButton(
//                                                     icon: Icon(Icons.edit, color: Colors.blue),
//                                                     onPressed: () => _editFood(index),
//                                                   ),
//                                                   IconButton(
//                                                     icon: Icon(Icons.delete, color: Colors.red),
//                                                     onPressed: () => _deleteFood(index),
//                                                   ),
//                                                 ],
//                                               ),
//                                           ],
//                                         ),
//                                       );
//                                     }),
//                                   );
//                                 }),
//                               ),
//                             ),
//                           ),
//                           // Add other widgets here if necessary
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: ()async {
//           await Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => Food(),
//             ),
//           );
//           // Handle Add Food Consumption action
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../models/addfood.dart'; // Ensure this import is correct
//
// class Addfood extends StatefulWidget {
//   const Addfood({Key? key}) : super(key: key);
//
//   @override
//   State<Addfood> createState() => _AddfoodState();
// }
//
// class _AddfoodState extends State<Addfood> with SingleTickerProviderStateMixin {
//   DateTime selectedDate = DateTime.now();
//   TextEditingController searchController = TextEditingController();
//   late TabController _tabController;
//
//   // Sample daily calorie goal
//   final int dailyCalorieGoal = 2000; // Set this to the user's goal
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   // Function to format the date
//   String getFormattedDate(DateTime date) {
//     return DateFormat('dd-MM-yyyy').format(date);
//   }
//
//   // Function to handle date change
//   void _changeDate(int days) {
//     setState(() {
//       selectedDate = selectedDate.add(Duration(days: days));
//       // Refresh calorie intake calculation
//     });
//   }
//
//   // Function to show date picker
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (pickedDate != null && pickedDate != selectedDate) {
//       setState(() {
//         selectedDate = pickedDate;
//         // Refresh calorie intake calculation
//       });
//     }
//   }
//
//   // Function to calculate total calories for the day
//   int _calculateTotalCalories(String mealType) {
//     // Sample data, replace with actual data from your source
//     List<FoodItem> meals = _getMealsForDay(mealType);
//     int totalCalories = meals.fold(0, (sum, item) => sum + item.calories);
//     return totalCalories;
//   }
//
//   // Sample function to get meals for the day
//   List<FoodItem> _getMealsForDay(String mealType) {
//     // This is just sample data. Replace with actual database query or data source
//     if (mealType == 'Breakfast') {
//       return [
//         FoodItem(name: 'Roti', quantityInGrams: 80, calories: 100, proteinAdded: 5, sugar: 0, deepFried: false, carbs: 20, fat: 2, micronutrients: {}),
//       ];
//     } else if (mealType == 'Lunch') {
//       return [
//         FoodItem(name: 'Rice', quantityInGrams: 200, calories: 250, proteinAdded: 5, sugar: 0, deepFried: false, carbs: 45, fat: 3, micronutrients: {}),
//       ];
//     } else {
//       return [
//         FoodItem(name: 'Salad', quantityInGrams: 150, calories: 50, proteinAdded: 2, sugar: 5, deepFried: false, carbs: 10, fat: 1, micronutrients: {}),
//       ];
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("ADD FOOD CONSUMED"),
//         backgroundColor: Colors.teal,
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(text: 'Breakfast'),
//             Tab(text: 'Lunch'),
//             Tab(text: 'Dinner'),
//           ],
//         ),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.teal.shade100, Colors.teal.shade400],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             child: Column(
//               children: [
//                 // Search box
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     controller: searchController,
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.search),
//                       hintText: 'Search food item',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Date selector
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Transform.rotate(
//                         angle: -0.2, // Rotate counterclockwise
//                         child: IconButton(
//                           icon: Icon(Icons.arrow_back_ios, color: Colors.red, size: 30),
//                           onPressed: () => _changeDate(-1),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           TextButton(
//                             onPressed: () => _selectDate(context),
//                             child: Text(
//                               getFormattedDate(selectedDate),
//                               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.calendar_today),
//                             onPressed: () => _selectDate(context),
//                           ),
//                         ],
//                       ),
//                       Transform.rotate(
//                         angle: 0.2, // Rotate clockwise
//                         child: IconButton(
//                           icon: Icon(Icons.arrow_forward_ios, color: Colors.red, size: 30),
//                           onPressed: () => _changeDate(1),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Calorie Tracking
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Total Calories Consumed: ${_calculateTotalCalories('Breakfast') + _calculateTotalCalories('Lunch') + _calculateTotalCalories('Dinner')} kcal',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Daily Calorie Goal: $dailyCalorieGoal kcal',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//
//                 Expanded(
//                   child: TabBarView(
//                     controller: _tabController,
//                     children: [
//                       _buildMealContent('Breakfast'),
//                       _buildMealContent('Lunch'),
//                       _buildMealContent('Dinner'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => Food(), // Replace with your Food screen
//             ),
//           );
//           // Handle Add Food Consumption action
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }
//
//   Widget _buildMealContent(String meal) {
//     // Replace this sample data with actual database queries
//     List<FoodItem> currentMeals = _getMealsForDay(meal);
//     List<FoodItem> previousMeals = _getPreviousMealsForDay(meal); // Implement this method
//
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Text(
//             //   'Current Data',
//             //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             // ),
//             _buildMealTable(currentMeals),
//             // SizedBox(height: 20),
//             // Text(
//             //   'Previous Data',
//             //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             // ),
//             // _buildMealTable(previousMeals),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMealTable(List<FoodItem> meals) {
//     List<String> titles = [
//       'Food Name',
//       'Quantity in grams',
//       'Calories',
//       'Protein added',
//       'Sugar',
//       'Deep Fried',
//       '',
//     ];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Titles Row
//         Row(
//           children: List.generate(titles.length, (index) {
//             return SizedBox(
//               width: 100, // Set a fixed width for each column
//               child: Text(
//                 titles[index],
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             );
//           }),
//         ),
//         const SizedBox(height: 10), // Add some spacing between the titles and values
//         // Values Rows
//         Column(
//           children: meals.map((item) {
//             return Row(
//               children: List.generate(titles.length, (i) {
//                 return SizedBox(
//                   width: 100, // Set a fixed width for each column
//                   child: i != titles.length - 1
//                       ? Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5.0),
//                     child: Text(
//                       i == 0 ? item.name : // Example for name
//                       i == 1 ? item.quantityInGrams.toString() : // Example for quantity
//                       i == 2 ? item.calories.toString() : // Example for calories
//                       i == 3 ? item.proteinAdded.toString() : // Example for protein added
//                       i == 4 ? item.sugar.toString() : // Example for sugar
//                       i == 5 ? (item.deepFried ? 'Yes' : 'No') : '', // Example for deep fried
//                       style: TextStyle(
//                         color: Colors.black,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   )
//                       : Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.edit, color: Colors.blue),
//                         onPressed: () {
//                           // Handle edit action
//                         },
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.delete, color: Colors.red),
//                         onPressed: () {
//                           // Handle delete action
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   List<FoodItem> _getPreviousMealsForDay(String mealType) {
//     // Implement the logic to fetch previous meals data
//     return []; // Placeholder for previous meals
//   }
// }
//
// class FoodItem {
//   final String name;
//   final int quantityInGrams;
//   final int calories;
//   final double proteinAdded; // in grams
//   final double sugar; // in grams
//   final bool deepFried;
//   final double carbs; // in grams
//   final double fat; // in grams
//   final Map<String, double> micronutrients; // vitamins, minerals, etc.
//
//   FoodItem({
//     required this.name,
//     required this.quantityInGrams,
//     required this.calories,
//     required this.proteinAdded,
//     required this.sugar,
//     required this.deepFried,
//     required this.carbs,
//     required this.fat,
//     required this.micronutrients,
//   });
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/addfood.dart';

class Addfood extends StatefulWidget {
  const Addfood({Key? key}) : super(key: key);

  @override
  State<Addfood> createState() => _AddfoodState();
}

class _AddfoodState extends State<Addfood> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<FoodItem> breakfastItems = [];
  List<FoodItem> lunchItems = [];
  List<FoodItem> dinnerItems = [];
  DateTime selectedDate = DateTime.now();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Add listener to tab controller
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        fetchData(); // Reload data when tab is changed
      }
    });

    fetchData();
  }

  Future<void> fetchData() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    final response = await http.get(Uri.parse('http://192.168.1.12/tvsmotors/api2/fetch_food_data.php?Date=$formattedDate'));

    if (response.statusCode == 200) {
      print(response.body);  // Print body to check JSON structure
      List data = json.decode(response.body);

      setState(() {
        if (data.isNotEmpty) {
          List<FoodItem> allItems = data.map((item) => FoodItem.fromJson(item)).toList();
          breakfastItems = allItems.where((item) => item.mealType == 'Breakfast').toList();
          lunchItems = allItems.where((item) => item.mealType == 'Lunch').toList();
          dinnerItems = allItems.where((item) => item.mealType == 'Dinner').toList();
        } else {
          _clearData(); // Clear existing data if no data found
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No data found for $formattedDate')),
          );
        }
      });
    } else {
      print('Failed to load food data');
    }
  }



  String getFormattedDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }
  void _clearData() {
    setState(() {
      breakfastItems = [];
      lunchItems = [];
      dinnerItems = [];
    });
  }

  void _changeDate(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
      _clearData(); // Clear existing data before fetching new data
      fetchData(); // Reload data after changing date
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        _clearData(); // Clear existing data before fetching new data
        fetchData(); // Reload data after selecting a new date
      });
    }
  }


  int _calculateTotalCalories(String mealType) {
    List<FoodItem> meals;
    switch (mealType) {
      case 'Breakfast':
        meals = breakfastItems;
        break;
      case 'Lunch':
        meals = lunchItems;
        break;
      case 'Dinner':
        meals = dinnerItems;
        break;
      default:
        meals = [];
    }

    if (meals.isEmpty) return 0; // Return 0 if no data found

    int totalCalories = meals.fold(0, (sum, item) => sum + item.calories);
    return totalCalories;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD FOOD CONSUMED"),
        backgroundColor: Colors.teal,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Breakfast'),
            Tab(text: 'Lunch'),
            Tab(text: 'Dinner'),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade100, Colors.teal.shade400],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search food item',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform.rotate(
                        angle: -0.2,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.red, size: 30),
                          onPressed: () => _changeDate(-1),
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () => _selectDate(context),
                            child: Text(
                              getFormattedDate(selectedDate),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () => _selectDate(context),
                          ),
                        ],
                      ),
                      Transform.rotate(
                        angle: 0.2,
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward_ios, color: Colors.red, size: 30),
                          onPressed: () => _changeDate(1),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total Calories Consumed: ${_calculateTotalCalories('Breakfast') + _calculateTotalCalories('Lunch') + _calculateTotalCalories('Dinner')} kcal',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Daily Calorie Goal: 2000 kcal', // You can replace this with actual user goal
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildMealContent('Breakfast'),
                      _buildMealContent('Lunch'),
                      _buildMealContent('Dinner'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Food(),
                ),
              );
            },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget _buildMealContent(String mealType) {
    List<FoodItem> currentMeals;
    switch (mealType) {
      case 'Breakfast':
        currentMeals = breakfastItems;
        break;
      case 'Lunch':
        currentMeals = lunchItems;
        break;
      case 'Dinner':
        currentMeals = dinnerItems;
        break;
      default:
        currentMeals = [];
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMealTable(currentMeals),
          ],
        ),
      ),
    );
  }

  Widget _buildMealTable(List<FoodItem> meals) {
    if (meals.isEmpty) {
      return Center(
        child: Text(
          'No data found',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      );
    }

    List<String> titles = [
      'Food Name',
      'Quantity in grams',
      'Calories',
      'Protein added',
      'Sugar',
      'Deep Fried',
      '',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(titles.length, (index) {
            return SizedBox(
              width: 100,
              child: Text(
                titles[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        Column(
          children: meals.map((item) {
            return Row(
              children: List.generate(titles.length, (i) {
                return SizedBox(
                  width: 100,
                  child: i != titles.length - 1
                      ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      i == 0
                          ? item.name
                          : i == 1
                          ? item.quantityInGrams.toString()
                          : i == 2
                          ? item.calories.toString()
                          : i == 3
                          ? item.proteinAdded.toString()
                          : i == 4
                          ? item.carbs.toString()
                          : i == 5
                          ? item.fats.toString()
                          : '',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Handle delete
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Handle edit
                        },
                      ),
                    ],
                  ),
                );
              }),
            );
          }).toList(),
        ),
      ],
    );
  }
}
class FoodItem {
  final String name;
  final String quantityInGrams;
  final int calories;
  final String proteinAdded; // in grams
  final String carbs; // in grams
  final String fats; // in grams
  final String mealType;

  FoodItem({
    required this.name,
    required this.quantityInGrams,
    required this.calories,
    required this.proteinAdded,
    required this.carbs,
    required this.fats,
    required this.mealType,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      name: json['food_name'] ?? '',
      quantityInGrams: json['Quantity_grams'] ?? '',
      calories: int.tryParse(json['Calories']?.toString() ?? '0') ?? 0,
      proteinAdded: json['Protine'] ?? '',
      carbs: json['Carbs'] ?? '',
      fats: json['fats'] ?? '',
      mealType: json['mealType'] ?? '',
    );
  }
}
