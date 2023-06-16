import 'package:flutter/cupertino.dart';
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
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Color.fromRGBO(255, 114, 111, 1),
      ),
      body: ListView.builder(
        itemCount: CartController.getCartItemCount(),
        itemBuilder: (context, index) {
          final product = CartController.cartItems[index];
          return ListTile(
            iconColor: Color.fromRGBO(251, 102, 102, 1),
            leading: Image.network(
              product.imageUrl,
              width: 75,
              height: 75,
            ),
            title: Text(product.nama),
            subtitle: Text('Rp.${product.harga}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                removeItemFromCart(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Item removed from cart'),
                    backgroundColor: Color.fromRGBO(166, 166, 166, 1),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 200,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
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
                if (CartController.getCartItemCount() > 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckoutPage()),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Cart is Empty'),
                        content: Text('Please add items to your cart.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Menutup dialog
                            },
                            child: const Text(
                              'OK',
                             ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromRGBO(251, 102, 102, 1)),
                fixedSize: MaterialStateProperty.all(
                  const Size(50, 50),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
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
