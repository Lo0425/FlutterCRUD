import 'package:exam_notes/service/productService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController productName = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController price = TextEditingController();

  void addProduct() {
    ProductService.addProduct(
        productName.text, category.text, double.parse(price.text));

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
              controller: productName,
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
              controller: category,
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
              controller: price,
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
                onPressed: () => addProduct(), child: const Text("Add Item"))
          ],
        ),
      ),
    );
  }
}
