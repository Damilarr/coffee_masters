class Product {
  int id;
  String name;
  String image;
  double price;
  String get imageUrl =>
      "https://firtman.github.io/coffeemasters/api/images/$image";
  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      price: json['price'] as double,
    );
  }
}

class Category {
  String name;
  List<Product> products;
  Category({required this.name, required this.products});
  factory Category.fromJson(Map<String, dynamic> json) {
    var productsJson = json['products'] as Iterable<dynamic>;
    var products = productsJson.map((p) => Product.fromJson(p)).toList();
    return Category(name: json['name'] as String, products: products);
  }
}

class ItemInCart {
  Product product;
  int quantity;
  ItemInCart({required this.product, required this.quantity});
}
