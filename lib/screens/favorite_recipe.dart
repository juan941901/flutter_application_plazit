import 'package:flutter/material.dart';
import 'package:flutter_application_plazit/core/text_style.dart';
import 'package:flutter_application_plazit/models/recipe_model.dart';
import 'package:flutter_application_plazit/providers/recipes_provider.dart';
import 'package:flutter_application_plazit/screens/recipe_detail.dart';
import 'package:provider/provider.dart';

class FavoriteRecipe extends StatelessWidget {
  const FavoriteRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<RecipesProvider>(
        builder: (context, recipeProvider, child) {
          final favoritesRecipes = recipeProvider.favoriteRecipe;
          print(favoritesRecipes.length);
          return favoritesRecipes.isEmpty
              ? Center(child: Text("Sin recetas favoritas"))
              : ListView.builder(
                  itemCount: favoritesRecipes.length,
                  itemBuilder: (context, index) {
                    final recipe = favoritesRecipes[index];
                    return FavoriteRecipeCard(recipe: recipe);
                  },
                );
        },
      ),
    );
  }
}

class FavoriteRecipeCard extends StatelessWidget {
  final Recipe recipe;
  const FavoriteRecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetail(recipesData: recipe),
          ),
        );
      },
      child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 125,
        child: Card(
          child: Row(
            children: <Widget>[
              Container(
                height: 125,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(recipe.imageLink, fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 26.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(recipe.name, style: TextStyles.textCardRecipe),
                  SizedBox(height: 4),
                  Container(height: 2, width: 75, color: Colors.orange),
                  SizedBox(height: 4),
                  Text(
                    "Autor: ${recipe.author}",
                    style: TextStyles.textCardAuthor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
