class Product {
  final String? id;
  final String name;
  final String category;
  final double price;

  Product({
    this.id,
    required this.name,
    required this.category,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      // "id": id,
      "title": name,
      "category": category,
      "price": price,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return Product(
        id: map["id"],
        name: map["name"],
        category: map["category"],
        price: map["price"] is int ? map["price"].toDouble() : map["price"],
    );
  }

  @override
  String toString(){
    return "title: $name category: $category price: $price";
  }
}