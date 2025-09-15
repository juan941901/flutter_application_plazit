import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_plazit/models/recipe_model.dart';
import 'package:http/http.dart' as http;

class RecipesProvider with ChangeNotifier {

  bool isLoading = false;
  List<Recipe> recipes = [];

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
        recipes = List<Recipe>.from(data["recipes"].map((recipe) => Recipe.fromJSON(recipe)));
      } else {
        print("Error: ${response.statusCode}");
        recipes = [];
      }
    } catch (e) {
      print("Error aplicacion: e");
      recipes = [];
    }
    finally {
      isLoading = false;
      notifyListeners(); // Avisar a los escuchas que el estado ha cambiado
    }
  }
}
