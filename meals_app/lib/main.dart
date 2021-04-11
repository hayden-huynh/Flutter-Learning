import 'package:flutter/material.dart';

import 'screens/filters_screen.dart';
import 'screens/meal_details_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.teal,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // What every screen set as home in MaterialApp (or CupertinoApp) is the main screen
      // home: CategoriesScreen(),
      // Map of named routes (screens)
      initialRoute: '/', // Default is '/'
      routes: {
        '/': (ctx) => TabsScreen(), // '/' is set as home screen
        CategoryMealScreen.routeName: (ctx) => CategoryMealScreen(),
        MealDetailsScreen.routeName: (ctx) => MealDetailsScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen()
      },
      // 'onGenerateRoute': specify the fallback screen to go to when a named screen does not exist
      onGenerateRoute: (settings) {
        // The settings param can be used to access many properties of the screen navigated to
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      // 'onUnknownRoute': when all other routing methods fail, the fallback screen specified here is reached
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
