import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tubes_klip/pages/ProductDetailsPage.dart';
import 'package:tubes_klip/pages/LoginPage.dart';
import 'package:tubes_klip/pages/Cart.dart';
import 'package:tubes_klip/models/Product.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;

    final List<Widget> _pages = [
      HomePage(),
      CartPage(),
      // ProfilePage(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color.fromRGBO(255, 114, 111, 1),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              })
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('Product').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          final List<QueryDocumentSnapshot<Map<String, dynamic>>>? documents =
              snapshot.data?.docs;

          if (documents == null || documents.isEmpty) {
            return Text('No data available');
          }

          return Padding(
            padding: const EdgeInsets.only(top: 15, left: 24, right: 24),
            child: Column(
              children: [
                Image.asset('assets/images/logo.png', width: 200, height: 100),
                SizedBox(height: 10.0),
                Container(
                  width: 400,
                  height: 170,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/banner.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    child: Text(
                      'Produk Terbaru',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(217, 63, 63, 1),
                      ),
                    ),
                  )
                ]),
                SizedBox(height: 16),
                Container(
                  height: 250,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: documents.map((document) {
                        Product product = Product(
                            id: document.id,
                            nama: document.data()['Nama'] as String,
                            harga: document.data()['Harga'] as int,
                            imageUrl: document.data()['imageUrl'] as String,
                            desc: document.data()['Desc'] as String);
                        return GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman detail produk dengan mempassing data produk
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                  product: product,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 200,
                            margin: EdgeInsets.all(8),
                            child: Card(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      product.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(product.nama),
                                    subtitle: Text('Harga: ${product.harga}'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        selectedItemColor: Color.fromRGBO(251, 102, 102, 1),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
