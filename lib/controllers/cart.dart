import 'package:tubes_klip/models/Product.dart';

class CartController {
  static List<Product> cartItems = [];

  static void addToCart(Product product) {
    cartItems.add(product);
  }

  static void removeFromCart(Product product) {
    cartItems.remove(product);
  }

  static void clearCart() {
    cartItems.clear();
  }

  static int getCartItemCount() {
    return cartItems.length;
  }

  static List<Product> getCartItems() {
    return List.from(cartItems);
  }
}
