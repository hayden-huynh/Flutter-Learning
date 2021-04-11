import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sliver: scrollable areas on the screen
    // SliverGridDelegateWithMaxCrossAxisExtent: provide a max width for each grid item and as many as possible of these items will be fitted on a row
    return GridView(
      padding: const EdgeInsets.all(20),
      children: DUMMY_CATEGORIES.map((catData) {
        return CategoryItem(
          catData.id,
          catData.title,
          catData.color,
        );
      }).toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio:
            3 / 2, // The height over width ratio of each grid item
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
