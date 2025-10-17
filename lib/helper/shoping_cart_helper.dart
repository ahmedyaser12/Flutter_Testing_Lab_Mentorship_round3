import '../widgets/shopping_cart.dart';

class ShoppingCartHelper {
  final List<CartItem> _items = [];

  void addItem(
    String id,
    String name,
    double price,
    int quantity, {
    double discount = 0.0, // discount is a percentage (0.0–1.0)
  }) {
    // If item already exists, update quantity
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index].quantity += quantity;
    } else {
      _items.add(
        CartItem(
          id: id,
          name: name,
          price: price,
          quantity: quantity,
          discount: discount,
        ),
      );
    }
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
  }

  void updateQuantity(String id, int newQuantity) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      if (newQuantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = newQuantity;
      }
    }
  }

  void clearCart() {
    _items.clear();
  }

  List<CartItem> getItems() => _items;

  double get subtotal {
    double subtotal = 0;
    for (var item in _items) {
      subtotal += item.price * item.quantity;
    }
    return subtotal;
  }

  double get totalDiscount {
    double discount = 0;
    for (var item in _items) {
      // item.discount is a percentage (e.g., 0.1 = 10%)
      discount += (item.price * item.discount) * item.quantity;
    }
    return discount;
  }

  double get totalAmount {
    // Subtract discount from subtotal
    return subtotal - totalDiscount;
  }

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);
}
