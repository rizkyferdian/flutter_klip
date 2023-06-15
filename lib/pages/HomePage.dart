import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tubes_klip/pages/ProductDetailsPage.dart';
import 'package:tubes_klip/models/Product.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
            padding: const EdgeInsets.only(top: 50, left: 24, right: 24),
            child: Column(
              children: [
                Container(
                  width: 400,
                  height: 170,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/banner.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
    );
  }
}
