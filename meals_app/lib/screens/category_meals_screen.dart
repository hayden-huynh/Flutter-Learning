import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealScreen extends StatefulWidget {
  // Save route name for the screen like this to avoid typos
  static const routeName = 'category-meals';
  final List<Meal> availableMeals;

  CategoryMealScreen(this.availableMeals);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String _categoryTitle;
  List<Meal> _displayedMeals;
  bool _alreadyInitialized = false;

  // 'initState' runs before the 'build' function runs for the first time
  // However, we cannot use the 'context' object here as 'initState' is called too early
  // @override
  // void initState() {
  //   super.initState();
  // }

  // 'initState' official documentation suggests using 'didChangeDependencies' as a workaround
  // because this function is called immediately after 'initState'
  // However, because 'didChangeDependencies' is called multiple times and not just once, add a boolean flag to check that the initialization has already been executed
  @override
  void didChangeDependencies() {
    if (!_alreadyInitialized) {
      // Access the 'arguments' passed through 'pushNamed'
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      _categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      _displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
    }
    super.didChangeDependencies();
  }

  // Experimental function to see how to work with data passed back from popped screens
  void _removeMeal(String mealId) {
    setState(() {
      _displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: _displayedMeals[index].id,
            title: _displayedMeals[index].title,
            imageUrl: _displayedMeals[index].imageUrl,
            duration: _displayedMeals[index].duration,
            complexity: _displayedMeals[index].complexity,
            affordability: _displayedMeals[index].affordability,
            removeItem: _removeMeal,
          );
        },
        itemCount: _displayedMeals.length,
      ),
    );
  }
}
