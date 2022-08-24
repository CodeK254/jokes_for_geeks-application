class Jokes{
  bool? error;
  String? category;
  String? type;
  String? setup;
  String? delivery;
  int? id;
  String? joke;
  bool? safe;
  String? lang;

  Jokes({
    this.error,
    this.category,
    this.type,
    this.setup,
    this.delivery,
    this.id,
    this.joke,
    this.safe,
    this.lang,
  });

  factory Jokes.fromJson(Map<String, dynamic> json) => Jokes(
    error: json["error"],
    category: json["category"],
    type: json["type"],
    setup: json["setup"],
    delivery: json["delivery"],
    id: json["id"],
    joke: json["joke"],
    safe: json["safe"],
    lang: json["lang"],
  );
}

class Category{
  String name;
  int index;
  
  Category({required this.name, required this.index});
}

List<Category> category = [
  Category(name: "Safe Mode", index: 0),
  Category(name: "Spooky", index: 1),
  Category(name: "pun", index: 2),
  Category(name: "programming", index: 3),
  Category(name: "dark", index: 4),
  Category(name: "misc", index: 5),
  Category(name: "Christmas", index: 6),
];