import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = '/meal-details';

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Ingredients',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            height: 150,
            width: 300,
            child: ListView.builder(
              itemBuilder: (ctx, index) => Card(
                color: Theme.of(context).accentColor,
                child: Text(
                  '${index + 1}. ${selectedMeal.ingredients[index]}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              itemCount: selectedMeal.ingredients.length,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Steps',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            height: 150,
            width: 300,
            child: ListView.builder(
              itemBuilder: (ctx, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      '${index + 1}. ${selectedMeal.steps[index]}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Divider(),
                ],
              ),
              itemCount: selectedMeal.steps.length,
            ),
          ),
        ],
      ),
    );
  }
}
