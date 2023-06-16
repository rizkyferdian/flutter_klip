import 'package:flutter/material.dart';
import 'package:tubes_klip/controllers/cart.dart';
import 'package:tubes_klip/models/Product.dart';
import 'package:tubes_klip/pages/CheckoutPage.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Product> cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  void loadCartItems() {
    cartItems = CartController.getCartItems();
  }

  void removeItemFromCart(int index) {
    setState(() {
      CartController.removeFromCart(cartItems[index]);
      cartItems.removeAt(index);
    });
  }

  int getTotalPrice() {
    int totalPrice = 0;
    for (var product in cartItems) {
      totalPrice += product.harga;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: ListView.builder(
        itemCount: CartController.getCartItemCount(),
        itemBuilder: (context, index) {
          final product = CartController.cartItems[index];
          return ListTile(
            leading: Image.network(
              product.imageUrl,
              width: 50,
              height: 50,
            ),
            title: Text(product.nama),
            subtitle: Text('Rp.${product.harga}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                removeItemFromCart(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Item removed from cart'),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 200,
        color: Colors.grey.shade200,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total Items: ${CartController.getCartItemCount()}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Total Price: Rp.${getTotalPrice()}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.grey.shade900),
              ),
              child: Text(
                'Checkout',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
