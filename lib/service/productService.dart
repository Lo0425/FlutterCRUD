import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../src/data/model/product.dart';

class ProductService {
  static Future addProduct(
      String productName, String category, double price) async {
    CollectionReference productsCollection =
        FirebaseFirestore.instance.collection('Products');
    String productId = productsCollection.doc().id;
    await productsCollection.doc(productId).set({
      'id': productId,
      'name': productName,
      'category': category,
      'price': price
    });
  }

  static Future<void> editProduct(
      String? productId, String productName, String category, double price) async {
    CollectionReference productsCollection =
    FirebaseFirestore.instance.collection('Products');
    // var productData = Product(
    //   id: productId,
    //   name: productName,
    //   category: category,
    //   price: price
    // ).toMap();
    await productsCollection.doc(productId).update({
      'name': productName,
      'category': category,
      'price': price,
    });
    // await productsCollection.doc(productId).update(productData);
  }

  static Future<void> deleteProduct(String productId) async {
    try {
      CollectionReference recipesCollection =
      FirebaseFirestore.instance.collection('Products');
      await recipesCollection.doc(productId).delete();
    } catch (e) {
      rethrow;
    }
  }

}
