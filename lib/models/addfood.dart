import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Food extends StatefulWidget {
  const Food({Key? key}) : super(key: key);

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  List<GlobalKey<_FoodFieldState>> foodFieldKeys = [GlobalKey<_FoodFieldState>()];
  List<Map<String, dynamic>> foodNames = [];

  @override
  void initState() {
    super.initState();
    fetchFoodNames();
  }

  Future<void> fetchFoodNames() async {
    final response = await http.get(Uri.parse('http://192.168.1.12/tvsmotors/api2/food_item.php'));

    if (response.statusCode == 200) {
      setState(() {
        foodNames = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load food names');
    }
  }

  Future<void> saveAllData() async {
    for (var key in foodFieldKeys) {
      if (key.currentState != null) {
        await key.currentState!.saveData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Details'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.teal.shade50,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: foodFieldKeys.map((key) {
                  return FoodField(
                    key: key,
                    foodNames: foodNames,
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
            foodFieldKeys.add(GlobalKey<_FoodFieldState>());
          });
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FoodField extends StatefulWidget {
  final List<Map<String, dynamic>> foodNames;

  const FoodField({Key? key, required this.foodNames}) : super(key: key);

  @override
  State<FoodField> createState() => _FoodFieldState();
}

class _FoodFieldState extends State<FoodField> {
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController quantitygramController = TextEditingController();
  final TextEditingController quantityController = TextEditingController(text: '1');
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController carbsController = TextEditingController();
  final TextEditingController fatsController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController mealTypeController = TextEditingController();

  bool isEditable = true;

  double? baseQuantitugram;
  double? baseCalories;
  double? baseProtein;
  double? baseCarbs;
  double? baseFats;

  @override
  void initState() {
    super.initState();
    dateController.text = DateTime.now().toString().split(' ')[0]; // Set current date
  }

  Future<void> saveData() async {
    final data = {
      'food_name': foodNameController.text,
      'serving_size_grams': quantitygramController.text,
      'calories': caloriesController.text,
      'protein': proteinController.text,
      'carbs': carbsController.text,
      'fats': fatsController.text,
      'quantity': quantityController.text,
      'date': dateController.text,
      'meal_type': mealTypeController.text,
    };

    final response = await http.post(
      Uri.parse('http://192.168.1.12/tvsmotors/api2/save_food_item.php'),
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data saved successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save data!')),
      );
    }
  }

  void _updateNutritionalValues() {
    int quantity = int.tryParse(quantityController.text) ?? 1;
    if (baseQuantitugram != null) {
      quantitygramController.text = (baseQuantitugram! * quantity).toStringAsFixed(2);
    }
    if (baseCalories != null) {
      caloriesController.text = (baseCalories! * quantity).toStringAsFixed(2);
    }
    if (baseProtein != null) {
      proteinController.text = (baseProtein! * quantity).toStringAsFixed(2);
    }
    if (baseCarbs != null) {
      carbsController.text = (baseCarbs! * quantity).toStringAsFixed(2);
    }
    if (baseFats != null) {
      fatsController.text = (baseFats! * quantity).toStringAsFixed(2);
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
              items: widget.foodNames.map((food) {
                return DropdownMenuItem(
                  value: food,
                  child: Text(food['food_name']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  foodNameController.text = value!['food_name'];
                  baseQuantitugram = double.tryParse(value!['serving_size_grams'].toString());
                  baseCalories = double.tryParse(value!['calories_per_serving'].toString());
                  baseProtein = double.tryParse(value!['protein_per_serving'].toString());
                  baseCarbs = double.tryParse(value!['carbs_per_serving'].toString());
                  baseFats = double.tryParse(value!['fats_per_serving'].toString());

                  _updateNutritionalValues();
                  isEditable = false; // Disable editing for fields except quantity
                });
              },
              decoration: const InputDecoration(
                labelText: 'Food Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              items: const [
                DropdownMenuItem(
                  value: 'Breakfast',
                  child: Text('Breakfast'),
                ),
                DropdownMenuItem(
                  value: 'Lunch',
                  child: Text('Lunch'),
                ),
                DropdownMenuItem(
                  value: 'Dinner',
                  child: Text('Dinner'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  mealTypeController.text = value.toString();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Meal Type',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _updateNutritionalValues(),
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_upward),
                      onPressed: () {
                        int currentValue = int.tryParse(quantityController.text) ?? 1;
                        quantityController.text = (currentValue + 1).toString();
                        _updateNutritionalValues();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_downward),
                      onPressed: () {
                        int currentValue = int.tryParse(quantityController.text) ?? 1;
                        if (currentValue > 1) {
                          quantityController.text = (currentValue - 1).toString();
                          _updateNutritionalValues();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: quantitygramController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Quantity in grams',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: caloriesController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Calories',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: proteinController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Protein',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: carbsController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Carbs',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: fatsController,
              readOnly: !isEditable,
              decoration: const InputDecoration(
                labelText: 'Fats',
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
