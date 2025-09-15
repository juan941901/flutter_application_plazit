import 'package:flutter/material.dart';
import 'package:flutter_application_plazit/core/text_style.dart';
import 'package:flutter_application_plazit/providers/recipes_provider.dart';
import 'package:flutter_application_plazit/screens/recipe_detail.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipesProvider = Provider.of<RecipesProvider>(context, listen: false);
    recipesProvider.fetchRecipes();
    return Scaffold(
      body: Consumer<RecipesProvider>(
        builder: (context, provider, child) {
          if(provider.isLoading){
            return const Center(child: CircularProgressIndicator());
          }
          else if (provider.recipes.isEmpty) {
            return const Center(child: Text('No se encuentran recetas'));
          } else {
            return ListView.builder(
              itemCount: provider.recipes.length,
              itemBuilder: (context, index) {
                return _recipesCard(context, provider.recipes[index]);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _showBottom(context);
        },
      ),
    );
  }
}

Widget _recipesCard(BuildContext context, recipe) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeDetail(
            recipeAuthor: "Mario y Luigi",
            recipeImage:
                "https://static.platzi.com/media/uploads/flutter_lasana_b894f1aee1.jpg",
            recipeInstructions:
                "1. Precalienta el horno a 375°F (190°C).\n2. En una sartén grande, cocina la carne molida hasta que esté dorada. Agrega la cebolla y el ajo, y cocina hasta que estén tiernos. Añade la salsa de tomate, el puré de tomate, el agua, el azúcar, la albahaca, el orégano, la sal y la pimienta. Cocina a fuego lento durante 30 minutos.\n3. En un bol grande, mezcla el queso ricotta, el huevo, el perejil y 1 taza de queso mozzarella.\n4. En una fuente para horno, extiende una capa delgada de la mezcla de carne en el fondo. Coloca una capa de láminas de lasaña encima. Añade una capa de la mezcla de queso y luego otra capa de carne. Repite las capas hasta que se terminen los ingredientes, terminando con una capa de carne.\n5. Cubre con el resto del queso mozzarella y el queso parmesano.\n6. Cubre con papel aluminio y hornea durante 25 minutos. Luego, retira el papel aluminio y hornea por otros 25 minutos o hasta que el queso esté dorado y burbujeante.\n7. Deja reposar durante 15 minutos antes de servir.",
            recipeName: "Lasagna",
          ),
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

Future<void> _showBottom(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 500,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: RecipeForm(),
      );
    },
  );
}

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController _recipeName = TextEditingController();
    final TextEditingController _recipeAuthor = TextEditingController();
    final TextEditingController _recipeImage = TextEditingController();
    final TextEditingController _recipeInstructions = TextEditingController();

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Agregar nueva receta", style: TextStyles.titleStyle),
            SizedBox(height: 10),
            _buildTextField(
              controller: _recipeName,
              label: "Nombre de la receta",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el nombre de la receta';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            _buildTextField(
              controller: _recipeAuthor,
              label: "Autor",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el nombre del autor';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            _buildTextField(
              controller: _recipeImage,
              label: "Imagen URL",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa la URL de la imagen';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            _buildTextField(
              controller: _recipeInstructions,
              label: "Receta",
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa la receta';
                }
                return null;
              },
            ),
            SizedBox(height: 65),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Aquí puedes agregar la lógica para guardar la receta
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Guardar',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(dynamic value) validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontFamily: "Poppins", color: Colors.orange),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.orange, width: 1.0),
        ),
      ),
    );
  }
}
