class Recipe {
  String? name;
  String? author;
  String? imageLink;
  List<String>? recipeSteps;

  Recipe({this.name, this.author, this.imageLink, this.recipeSteps});

  factory Recipe.fromJSON(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      author: json['author'],
      imageLink: json['imageLink'],
      recipeSteps: List<String>.from(json['recipe'] ?? []),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'author': author,
      'imageLink': imageLink,
      'recipe': recipeSteps,
    };
  }
  
}
