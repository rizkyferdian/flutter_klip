import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              QueryDocumentSnapshot<Map<String, dynamic>> document =
                  documents[index];
              String nama = document.data()['Nama'] as String;
              String imageUrl = document.data()['imageUrl'] as String;
              int harga = document.data()['Harga'] as int;

              return Card(
                child: ListTile(
                  leading: Image.network(imageUrl),
                  title: Text(nama),
                  subtitle: Text('Harga: $harga'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
