class CartItem {
  final String title;
  final String image;
  final double price;
  int quantity;

  CartItem({
    required this.title,
    required this.image,
    required this.price,
    this.quantity = 1,
  });
}
