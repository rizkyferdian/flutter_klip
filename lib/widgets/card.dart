import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(10),
              width: 200,
              height: 320,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 2),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 180,
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl), // Perubahan disini
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          nama, // Perubahan disini
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          harga.toString(), // Perubahan disini
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.red),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
