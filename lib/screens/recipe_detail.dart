import 'package:flutter/material.dart';
import 'package:flutter_application_plazit/core/text_style.dart';

class RecipeDetail extends StatelessWidget {
  final String recipeName;
  final String recipeAuthor;
  final String recipeImage;
  final String recipeInstructions;

  const RecipeDetail({
    super.key,
    required this.recipeName,
    required this.recipeAuthor,
    required this.recipeImage,
    required this.recipeInstructions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeName, style: TextStyles.titleStyle),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Text('Details of the selected recipe will be shown here.'),
      ),
    );
  }
}