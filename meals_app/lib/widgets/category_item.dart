import 'package:flutter/material.dart';

import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String categoryId;
  final Color color;

  CategoryItem(this.categoryId, this.title, this.color);

  void selectCategory(BuildContext ctx) {
    // Navigate to an unnamed screen
    // Navigator.of(ctx).push(
    //   MaterialPageRoute(
    //     builder: (_) {
    //       return CategoryMealScreen(categoryId, title);
    //     },
    //   ),
    // );

    // Navigate to a named screen, pass data using 'arguments' 
    Navigator.pushNamed(
      ctx,
      CategoryMealScreen.routeName,
      arguments: {'id': categoryId, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    // InkWell: basically a GestureDetector that also fires a ripple effect when pressed
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius:
          BorderRadius.circular(15), // Should be same as that of the container
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // Gradient Color
            colors: [
              // The range of the color used to create the gradient, should provide start and end color
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
