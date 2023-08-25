import 'package:flutter/material.dart';
import 'package:project_3_meal/Widgets/meal_item.dart';
import '../dummy.dart';

class CategoryMealScreen extends StatelessWidget {
  static const routename = '/category-meals';
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    if (routeArgs == null || !(routeArgs is Map<String, String>)) {
      throw ArgumentError("Invalid route arguments");
    }

    final categoryTitle = routeArgs['title'];
    // ignore: unused_local_variable
    final categoryId = routeArgs['id'];
    final categoryMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle!),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
                title: categoryMeals[index].title,
                imageUrl: categoryMeals[index].imageUrl,
                complexity: categoryMeals[index].complexity,
                affordability: categoryMeals[index].affordability,
                duration: categoryMeals[index].duration);
          },
          itemCount: categoryMeals.length,
        ));
  }
}
