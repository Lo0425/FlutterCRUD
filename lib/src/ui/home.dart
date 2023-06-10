import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_notes/service/productService.dart';
import 'package:exam_notes/src/ui/editProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/model/product.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _products = <Product>[];

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() async {
    await getProducts();
  }

  Future _addProduct(BuildContext context) async {
    var result = await context.push("/addProduct");
    if (result != null) {
      _refresh();
    }
    _products.clear();
  }

  Future getProducts() async {
    var collection = FirebaseFirestore.instance.collection("Products");
    var querySnapshot = await collection.get();

    for (var item in querySnapshot.docs) {
      var data = item.data();
      var product = Product.fromMap(data);
      setState(() {
        _products.add(product);
      });
    }
  }

  editProduct(Product product) async {
    var res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProduct(product: product)),
    );

    if (res != null) {
      _products.clear();
      _refresh();
    }

  }

  void deleteProduct(String productId) {
    ProductService.deleteProduct(productId);
    _products.clear();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.lightBlueAccent,
        title: const Text("Home"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              child: Container(
            margin: const EdgeInsets.all(12),
            color: Colors.white,
            width: double.infinity,
            child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return Card(
                      elevation: 10,
                      margin: const EdgeInsets.all(8),
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Title: ${product.name} "),
                              Text("Category: ${product.category} "),
                              Text("Price: ${product.price}"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () => {
                                            editProduct(product),
                                          },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () => {
                                            if (product.id != null)
                                              {
                                                deleteProduct(product.id!),
                                                debugPrint(product.id),
                                                debugPrint(product.name)
                                              },
                                          },
                                      icon: const Icon(Icons.delete))
                                ],
                              )
                            ]),
                      ));
                }),
          )),
          Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                onPressed: () => _addProduct(context),
                child: const Icon(Icons.add),
              ))
        ],
      ),
    );
  }
}
