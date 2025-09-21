import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_plazit/models/recipe_model.dart';
// import 'package:flutter_application_plazit/screens/favorite_recipe.dart';
import 'package:http/http.dart' as http;

class RecipesProvider with ChangeNotifier {
  bool isLoading = false;
  List<Recipe> recipes = [];
  List<Recipe> favoriteRecipe = [];

  Future<void> fetchRecipes() async {
    isLoading = true;
    notifyListeners(); // Avisar a los escuchas que el estado ha cambiado

    // Localhost android 10.0.2.2
    // Localhost IOS 127.0.0.1
    // localhost web localhost
    final url = Uri.parse('http://10.0.2.2:12346/recipes');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        recipes = List<Recipe>.from(
          data["recipes"].map((recipe) => Recipe.fromJSON(recipe)),
        );
      } else {
        print("Error: ${response.statusCode}");
        recipes = [];
      }
    } catch (e) {
      print("Error aplicacion: e");
      recipes = [];
    } finally {
      isLoading = false;
      notifyListeners(); // Avisar a los escuchas que el estado ha cambiado
    }
  }

  Future<void> toggleFavoriteStatus(Recipe recipe) async {

    final isFavorite = favoriteRecipe.contains(recipe);

    final url = Uri.parse('http://10.0.2.2:12346/favorites');
    try {
      final response = isFavorite
          ? await http.delete(url, headers: {"Content-Type": "application/json"}, body: jsonEncode({"id": recipe.id}))
          : await http.post(url, headers: {"Content-Type": "application/json"}, body: jsonEncode(recipe.toJSON()));
      
      if(response.statusCode == 200){

        if(isFavorite){
          favoriteRecipe.remove(recipe);
        }else{
          favoriteRecipe.add(recipe);
        }

        notifyListeners();
      }
      else{
        throw Exception("Failed to update favorite recipes");
      }
    } catch (e) {
      print("Error $e");
    }
  }
}
