import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Exercise extends StatefulWidget {
  const Exercise({Key? key}) : super(key: key);

  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  List<GlobalKey<_ExerciseFieldState>> exerciseFieldKeys = [GlobalKey<_ExerciseFieldState>()];
  List<Map<String, dynamic>> exerciseNames = [];

  @override
  void initState() {
    super.initState();
    fetchExerciseNames();
  }

  Future<void> fetchExerciseNames() async {
    final response = await http.get(Uri.parse('http://192.168.1.12/tvsmotors/api2/exercise_item.php'));
    if (response.statusCode == 200) {
      setState(() {
        exerciseNames = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load exercise names');
    }
  }

  Future<void> saveAllData() async {
    for (var key in exerciseFieldKeys) {
      if (key.currentState != null) {
        await key.currentState!.saveData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Details'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.teal.shade50,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: exerciseFieldKeys.map((key) {
                  return ExerciseField(
                    key: key,
                    exerciseNames: exerciseNames,
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: saveAllData,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            exerciseFieldKeys.add(GlobalKey<_ExerciseFieldState>());
          });
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ExerciseField extends StatefulWidget {
  final List<Map<String, dynamic>> exerciseNames;

  const ExerciseField({Key? key, required this.exerciseNames}) : super(key: key);

  @override
  State<ExerciseField> createState() => _ExerciseFieldState();
}

class _ExerciseFieldState extends State<ExerciseField> {
  final TextEditingController exerciseNameController = TextEditingController();
  final TextEditingController exerciseTypeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  bool isEditable = true;
  double caloriesPerMinute = 0.0;

  @override
  void initState() {
    super.initState();
    dateController.text = DateTime.now().toIso8601String().split('T').first;
  }

  void updateCalories() {
    final duration = double.tryParse(durationController.text) ?? 0.0;
    final totalCalories = duration * caloriesPerMinute;
    caloriesController.text = totalCalories.toStringAsFixed(2);
  }

  Future<void> saveData() async {
    final data = {
      'exercise_name': exerciseNameController.text,
      'exercise_type': exerciseTypeController.text,
      'duration_minutes': durationController.text,
      'calories_burned': caloriesController.text,
      'Date': dateController.text,
    };

    final response = await http.post(
      Uri.parse('http://192.168.1.12/tvsmotors/api2/save_exercise_item.php'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data saved successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save data: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField(
              items: widget.exerciseNames.map((exercise) {
                return DropdownMenuItem(
                  value: exercise,
                  child: Text(exercise['exercise_name']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  exerciseNameController.text = value!['exercise_name'];
                  caloriesPerMinute = double.parse(value['calories_burned_per_minute'].toString());
                  isEditable = false;
                  updateCalories();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Exercise Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              items: const [
                DropdownMenuItem(
                  value: 'Strength',
                  child: Text('Strength'),
                ),
                DropdownMenuItem(
                  value: 'Cardio',
                  child: Text('Cardio'),
                ),
                DropdownMenuItem(
                  value: 'Yoga',
                  child: Text('Yoga'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  exerciseTypeController.text = value.toString();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Exercise Type',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: durationController,
              decoration: const InputDecoration(
                labelText: 'Duration (minutes)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                updateCalories();
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: caloriesController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Calories Burned',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.datetime,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null) {
                  setState(() {
                    dateController.text = pickedDate.toString().split(' ')[0];
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
