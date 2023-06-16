import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techtest_phase1_agnesty/models/data_model.dart';
import 'package:techtest_phase1_agnesty/screens/edit_product_screen.dart';

import '../services/references.dart';
import '../widgets/item_user_product.dart';

class UserProdScreen extends StatelessWidget {
  const UserProdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? userId = user?.uid;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'User Product',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: dataPaperFR
                  .doc('techtest')
                  .collection('dataProduk')
                  .where('id', isEqualTo: userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No products have been added yet.'));
                }
                final toList = snapshot.data!.docs
                    .map((e) => DataModel.fromSnapshot(e))
                    .toList();
                return ListView.builder(
                    itemCount: toList.length,
                    itemBuilder: (BuildContext context, index) {
                      var tooList = toList[index];
                      return ItemProductUser(
                        id: tooList.id!,
                        gambar: tooList.gambar!,
                        title: tooList.title!,
                        price: tooList.price!,
                        dataProduct: tooList,
                      );
                    });
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => EditProductScreen(
                iniEdit: false,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
        elevation: 8,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
