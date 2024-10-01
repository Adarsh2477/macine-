// import 'package:fl_chart/fl_chart.dart';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
//
// import 'exersize.dart';
//
// class AddExercise extends StatefulWidget {
//   const AddExercise({Key? key}) : super(key: key);
//
//   @override
//   State<AddExercise> createState() => _AddExerciseState();
// }
//
// class _AddExerciseState extends State<AddExercise> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   List<ExerciseItem> cardio = [];
//   List<ExerciseItem> strength = [];
//   List<ExerciseItem> yoga = [];
//   DateTime selectedDate = DateTime.now();
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//
//     _tabController.addListener(() {
//       if (_tabController.indexIsChanging) {
//         fetchData(); // Reload data when tab is changed
//       }
//     });
//
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     // Get the current date formatted
//     String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
//
//     // API call
//     final response = await http.get(Uri.parse('http://192.168.1.11/tvsmotors/api2/fetch_escersie_data.php?exercise_date=$formattedDate'));
//
//     // Log the raw response for debugging
//     print('Raw Response: ${response.body}');
//
//     // Check if the response was successful
//     if (response.statusCode == 200) {
//       // Handle the specific response "0 results[]"
//       if (response.body.trim() == "0 results[]") {
//         _clearData();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('No data found for $formattedDate')),
//         );
//         return;
//       }
//
//       // Try to parse the JSON data
//       try {
//         // Decode the JSON response
//         List<dynamic> data = json.decode(response.body);
//
//         // Update the state with parsed data
//         setState(() {
//           List<ExerciseItem> allItems = data.map((item) => ExerciseItem.fromJson(item)).toList();
//           cardio = allItems.where((item) => item.muscleGroup == 'Cardio').toList();
//           strength = allItems.where((item) => item.muscleGroup == 'Strength').toList();
//           yoga = allItems.where((item) => item.muscleGroup == 'Yoga').toList();
//         });
//
//         // Show a snack bar if no data is found for the current date
//         var allItems;
//         if (allItems.isEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('No data found for $formattedDate')),
//           );
//         }
//       } catch (e) {
//         // Handle JSON parsing errors
//         print('JSON Parsing Error: $e');
//       }
//     } else {
//       // Handle response error
//       print('Failed to load exercise data');
//     }
//   }
//
//
//
//   void _clearData() {
//     setState(() {
//       cardio = [];
//       strength = [];
//       yoga = [];
//     });
//   }
//
//   void _changeDate(int days) {
//     setState(() {
//       selectedDate = selectedDate.add(Duration(days: days));
//       _clearData();
//       fetchData();
//     });
//   }
//
//   final int dailyCalorieBurnGoal = 500;
//
//   String getFormattedDate(DateTime date) {
//     return DateFormat('dd-MM-yyyy').format(date);
//   }
//
//   int _calculateTotalCalories(String muscleGroup) {
//     List<ExerciseItem> exercises;
//     switch (muscleGroup) {
//       case 'Cardio':
//         exercises = cardio;
//         break;
//       case 'Strength':
//         exercises = strength;
//         break;
//       case 'Yoga':
//         exercises = yoga;
//         break;
//       default:
//         exercises = [];
//     }
//
//     if (exercises.isEmpty) return 0;
//
//     int totalCalories = exercises.fold(0, (sum, item) => sum + item.totalCaloriesBurned);
//     return totalCalories;
//   }
//
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
//         _clearData();
//         fetchData();
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add Exercise"),
//         backgroundColor: Colors.teal,
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const [
//             Tab(text: 'Cardio'),
//             Tab(text: 'Strength'),
//             Tab(text: 'Yoga'),
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
//                       prefixIcon: const Icon(Icons.search),
//                       hintText: 'Search exercise',
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
//                         angle: -0.2,
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
//                               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.calendar_today),
//                             onPressed: () => _selectDate(context),
//                           ),
//                         ],
//                       ),
//                       Transform.rotate(
//                         angle: 0.2,
//                         child: IconButton(
//                           icon: Icon(Icons.arrow_forward_ios, color: Colors.red, size: 30),
//                           onPressed: () => _changeDate(1),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Calorie Burn Tracking
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Total Calories Burned: ${_calculateTotalCalories('Cardio') + _calculateTotalCalories('Strength') + _calculateTotalCalories('Yoga')} kcal',
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Daily Calorie Burn Goal: $dailyCalorieBurnGoal kcal',
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Expanded(
//                   child: TabBarView(
//                     controller: _tabController,
//                     children: [
//                       _buildExerciseContent('Cardio'),
//                       _buildExerciseContent('Strength'),
//                       _buildExerciseContent('Yoga'),
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
//               builder: (context) => Exercise(),
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }
//
//   Widget _buildExerciseContent(String exerciseType) {
//     List<ExerciseItem> currentExercises;
//     switch (exerciseType) {
//       case 'Cardio':
//         currentExercises = cardio;
//         break;
//       case 'Strength':
//         currentExercises = strength;
//         break;
//       case 'Yoga':
//         currentExercises = yoga;
//         break;
//       default:
//         currentExercises = [];
//     }
//
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildExerciseTable(currentExercises),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildExerciseTable(List<ExerciseItem> exercises) {
//     const List<String> titles = [
//       'Exercise Name',
//       'Duration (min)',
//       'Calories Burned',
//       'Exercise Date',
//       '',
//     ];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: List.generate(titles.length, (index) {
//             return SizedBox(
//               width: 100,
//               child: Text(
//                 titles[index],
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             );
//           }),
//         ),
//         const SizedBox(height: 10),
//         Column(
//           children: exercises.map((item) {
//             return Row(
//               children: List.generate(titles.length, (i) {
//                 return SizedBox(
//                   width: 100,
//                   child: i != titles.length - 1
//                       ? Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4.0),
//                     child: Text(
//                       i == 0
//                           ? item.exerciseId.toString()
//                           : i == 1
//                           ? item.durationMinutes.toString()
//                           : i == 2
//                           ? item.totalCaloriesBurned.toString()
//                           : i == 3
//                           ? DateFormat('dd-MM-yyyy').format(item.exerciseDate)
//                           : '',
//                       style: const TextStyle(
//                         color: Colors.black,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   )
//                       : Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.delete, color: Colors.red),
//                         onPressed: () {
//                           // Handle delete
//                         },
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.edit, color: Colors.blue),
//                         onPressed: () {
//                           // Handle edit
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
//
// class ExerciseItem {
//   final int exerciseId;
//   final double durationMinutes;
//   final int totalCaloriesBurned;
//   final DateTime exerciseDate;
//   final String muscleGroup;
//
//   ExerciseItem({
//     required this.exerciseId,
//     required this.durationMinutes,
//     required this.totalCaloriesBurned,
//     required this.exerciseDate,
//     required this.muscleGroup,
//   });
//
//   factory ExerciseItem.fromJson(Map<String, dynamic> json) {
//     return ExerciseItem(
//       exerciseId: json['exercise_id'],
//       durationMinutes: double.parse(json['duration_minutes'].toString()),
//       totalCaloriesBurned: int.parse(json['total_calories_burned'].toString()),
//       exerciseDate: DateTime.parse(json['exercise_date']),
//       muscleGroup: json['muscle_group'],
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'exersize.dart';
class AddExercise extends StatefulWidget {
  const AddExercise({Key? key}) : super(key: key);

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<ExerciseItem> strengthExercises = [];
  List<ExerciseItem> cardioExercises = [];
  List<ExerciseItem> yogaExercises = [];
  DateTime selectedDate = DateTime.now();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Listen to tab changes to reload data if needed
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        fetchData(); // Reload data when tab is changed
      }
    });

    fetchData(); // Fetch data for the current date on initial load
  }
  Future<void> fetchData() async {
    // Format the selected date
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    try {
      // Fetch data from the server
      final response = await http.get(Uri.parse('http://192.168.1.12/tvsmotors/api2/fetch_escersie_data.php?Date=$formattedDate'));

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        print(data);
        setState(() {
          if (data.isNotEmpty) {
            List<ExerciseItem> allItems = data.map((item) => ExerciseItem.fromJson(item)).toList();
            strengthExercises = allItems.where((item) => item.muscleGroup == 'Strength').toList();
            cardioExercises = allItems.where((item) => item.muscleGroup == 'Cardio').toList();
            yogaExercises = allItems.where((item) => item.muscleGroup == 'Yoga').toList();
          } else {
            // If no data is found for the selected date
            _clearData(); // Clear previous data
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No data found for $formattedDate')),
            );
          }
        });
      } else {
        // Handle server errors or network issues
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load data. Please try again later.')),
        );
      }
    } catch (error) {
      // Handle any other errors, such as network issues
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please check your connection and try again.')),
      );
    }
  }

  // Helper method to clear all exercise data
  void _clearData() {
    setState(() {
      strengthExercises = [];
      cardioExercises = [];
      yogaExercises = [];
    });
  }

  // Method to change the selected date
  void _changeDate(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
    });
    _clearData(); // Clear existing data before fetching new data
    fetchData(); // Fetch new data for the updated date
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
      });
      _clearData(); // Clear existing data before fetching new data
      fetchData(); // Fetch new data for the selected date
    }
  }

  // Method to calculate total calories burned for a specific muscle group
  int _calculateTotalCalories(String muscleGroup) {
    List<ExerciseItem> exercises;
    switch (muscleGroup) {
      case 'Strength':
        exercises = strengthExercises;
        break;
      case 'Cardio':
        exercises = cardioExercises;
        break;
      case 'Yoga':
        exercises = yogaExercises;
        break;
      default:
        exercises = [];
    }

    if (exercises.isEmpty) return 0; // Return 0 if no data found

    double totalCalories = exercises.fold(0, (sum, item) => sum + item.totalCaloriesBurned);
    return totalCalories.toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD EXERCISES"),
        backgroundColor: Colors.teal,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Strength'),
            Tab(text: 'Cardio'),
            Tab(text: 'Yoga'),
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
                      hintText: 'Search exercise',
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
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.red, size: 30),
                        onPressed: () => _changeDate(-1),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () => _selectDate(context),
                            child: Text(
                              DateFormat('dd-MM-yyyy').format(selectedDate),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () => _selectDate(context),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios, color: Colors.red, size: 30),
                        onPressed: () => _changeDate(1),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total Calories Burned: ${_calculateTotalCalories('Strength') + _calculateTotalCalories('Cardio') + _calculateTotalCalories('Yoga')} kcal',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Daily Calorie Goal: 500 kcal', // You can replace this with actual user goal
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildExerciseContent('Strength'),
                      _buildExerciseContent('Cardio'),
                      _buildExerciseContent('Yoga'),
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
              builder: (context) => Exercise(),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
  // Method to build content for a specific muscle group
  Widget _buildExerciseContent(String muscleGroup) {
    List<ExerciseItem> currentExercises;
    switch (muscleGroup) {
      case 'Strength':
        currentExercises = strengthExercises;
        break;
      case 'Cardio':
        currentExercises = cardioExercises;
        break;
      case 'Yoga':
        currentExercises = yogaExercises;
        break;
      default:
        currentExercises = [];
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExerciseTable(currentExercises),
          ],
        ),
      ),
    );
  }

  // Method to build a table of exercises
  Widget _buildExerciseTable(List<ExerciseItem> exercises) {
    if (exercises.isEmpty) {
      return Center(
        child: Text(
          'No data found',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      );
    }

    List<String> titles = [
      'Exercise Name',
      'Duration (minutes)',
      'Calories Burned',
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
          children: exercises.map((item) {
            return Row(
              children: List.generate(titles.length, (i) {
                return SizedBox(
                  width: 100,
                  child: i != titles.length - 1
                      ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      i == 0
                          ? item.exerciseName
                          : i == 1
                          ? item.durationMinutes.toString()
                          : i == 2
                          ? item.totalCaloriesBurned.toString()
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

class ExerciseItem {
  final String exerciseName;
  final int durationMinutes;
  final double totalCaloriesBurned;
  final String muscleGroup;

  ExerciseItem({
    required this.exerciseName,
    required this.durationMinutes,
    required this.totalCaloriesBurned,
    required this.muscleGroup,
  });

  // Factory method to create an ExerciseItem from JSON data
  factory ExerciseItem.fromJson(Map<String, dynamic> json) {
    return ExerciseItem(
      exerciseName: json['exercise_name'] ?? '',
      durationMinutes: int.tryParse(json['duration_minutes']?.toString() ?? '0') ?? 0,
      totalCaloriesBurned: double.tryParse(json['total_calories_burned']?.toString() ?? '0.0') ?? 0.0,
      muscleGroup: json['muscle_group'] ?? '',
    );
  }
}
