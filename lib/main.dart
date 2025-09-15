import 'package:flutter/material.dart';
import 'package:flutter_application_plazit/providers/recipes_provider.dart';
import 'package:flutter_application_plazit/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipesProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Libro de recetas",
        home: const RecipeBook(),
      ),
    );
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Libro de recetas',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orange,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Inicio"),
              Tab(icon: Icon(Icons.favorite), text: "Favoritos"),
              Tab(icon: Icon(Icons.settings), text: "Ajustes"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeScreen(),
            Center(child: Text("Favoritos")),
            Center(child: Text("Ajustes")),
          ],
        ),
      ),
    );
  }
}
