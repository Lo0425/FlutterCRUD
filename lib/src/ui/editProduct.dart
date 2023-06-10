import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_notes/service/productService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/model/product.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key, required this.product}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
  final Product product;
}

class _EditProductState extends State<EditProduct> {
  final _products = [];

  final TextEditingController _productName = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _price = TextEditingController();

  @override
  void initState(){
    super.initState();
    getProductById(widget.product.id);

  }

  Future getProductById(String? id) async {
    var collection = FirebaseFirestore.instance.collection("Products");
    var querySnapshot = await collection.where('id', isEqualTo: id).get();

    for (var item in querySnapshot.docs){
      var data = item.data();
      var product = Product.fromMap(data);
      setState(() {
        _products.add(product);
      });
    }
    setState(() {
      if(_products.isNotEmpty){
        _productName.text = _products[0].name;
        _category.text = _products[0].category;
        _price.text = _products[0].price.toString();
      }
    });
  }

  @override
  void dispose() {
    _productName.dispose();
    _category.dispose();
    _price.dispose();
    super.dispose();
  }

  void editProduct() {
    ProductService.editProduct(widget.product.id, _productName.text,
        _category.text, double.parse(_price.text));

    context.pop(true);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.lightBlueAccent,
        title: const Text("AddProduct"),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
        child: Column(
          children: [
            TextField(
              controller: _productName,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  prefixIconColor: Colors.white,
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  hintText: "Email",
                  hintStyle: const TextStyle(color: Colors.white, fontSize: 18),
                  // errorText: _emailError.isEmpty ? null : _emailError,
                  border: const OutlineInputBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)))),
            ),
            TextField(
              controller: _category,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  prefixIconColor: Colors.white,
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  hintText: "category",
                  hintStyle: const TextStyle(color: Colors.white, fontSize: 18),
                  // errorText: _emailError.isEmpty ? null : _emailError,
                  border: const OutlineInputBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)))),
            ),
            TextField(
              controller: _price,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  prefixIconColor: Colors.white,
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  hintText: "price",
                  hintStyle: const TextStyle(color: Colors.white, fontSize: 18),
                  // errorText: _emailError.isEmpty ? null : _emailError,
                  border: const OutlineInputBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)))),
            ),
            ElevatedButton(
                onPressed: () => editProduct(), child: const Text("Edit Item"))
          ],
        ),
      ),
    );
  }
}
