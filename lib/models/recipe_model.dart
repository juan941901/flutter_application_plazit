class Recipe {
  String? name;
  String? author;
  String? image_link;
  List<String>? recipeSteps;

  Recipe({this.name, this.author, this.image_link, this.recipeSteps});

  factory Recipe.fromJSON(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      author: json['author'],
      image_link: json['image_link'],
      recipeSteps: List<String>.from(json['recipe'] ?? []),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'author': author,
      'image_link': image_link,
      'recipe': recipeSteps,
    };
  }
  
}
