import 'package:flutter/material.dart';
import 'package:tubes_klip/pages/ProductDetailsPage.dart';
import 'package:tubes_klip/pages/SuccessPage.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(251, 102, 102, 1),
        elevation: 0,
        toolbarHeight: 60, // Menyesuaikan tinggi AppBar
        title: Padding(
          padding:
              const EdgeInsets.only(right: 50.0), // Menambahkan margin kanan
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: Text(
                  'Checkout',
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/logo.png', width: 200, height: 100),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(), // Tambahkan border
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Alamat Email',
                  border: OutlineInputBorder(), // Tambahkan border
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(), // Tambahkan border
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(), // Tambahkan border
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi/Ukuran',
                  border: OutlineInputBorder(), // Tambahkan border
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(251, 102, 102, 1)),
                  fixedSize: MaterialStateProperty.all(
                    const Size(50, 50),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: () {
                  // Logika checkout
                  String fullName = _nameController.text;
                  String email = _emailController.text;
                  String address = _addressController.text;
                  String phoneNumber = _phoneNumberController.text;
                  String description = _descriptionController.text;
                  Navigator.push(
                    context,
                  MaterialPageRoute(builder: (context) => SuccessPage())
                  );
                  // Lakukan proses checkout dengan data yang diinputkan

                  // Contoh tampilan snackbar sebagai umpan balik checkout
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Checkout successful!'),
                    ),
                  );
                },
                child: const Text(
                  'Checkout Now',
                  style: TextStyle(fontSize: 20),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
