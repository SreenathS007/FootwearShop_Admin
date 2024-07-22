import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopy_admin/model/product/product.dart';

class HomeController extends GetxController {
  //creating an instance for handling database
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //products collection reference
  late CollectionReference productCollection;

  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescriptionCtrl = TextEditingController();
  TextEditingController productImageCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();

  String category = 'General';
  String brand = 'Unbranded';
  bool offer = false;

  List<Product> products = [];
  @override
  Future<void> onInit() async {
    //using this colliction we can add delete remove, update...
    productCollection = firestore.collection('Products');
    await fetchProducts();
    super.onInit();
  }

  addProduct() {
    try {
      DocumentReference doc = productCollection.doc();
      Product product = Product(
        id: doc.id,
        name: productNameCtrl.text,
        category: category,
        description: productDescriptionCtrl.text,
        price: double.tryParse(productPriceCtrl.text),
        brand: brand,
        image: productImageCtrl.text,
        offer: offer,
      );
      final productJson = product.toJson();
      doc.set(productJson);
      Get.snackbar('Success', 'Product added Successfully',
          colorText: Colors.green);
      setValueDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    }
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrievedProducts);
      Get.snackbar('Success', 'Product fetch Successfuly',
          colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
      // You can also handle the error more specifically based on the type of exception
      // For example, if you're using Firebase Firestore, you can check for FirebaseException
      // if (e is FirebaseException) {
      //   print('Firebase error: ${e.message}');
      // } else {
      //   print('Unknown error: $e');
      // }
    } finally {
      update();
    }
  }

  deleteProduct(String id) async {
    try {
      await productCollection.doc(id).delete();
      fetchProducts();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    } finally {
      update();
    }
  }

  setValueDefault() {
    productNameCtrl.clear();
    productDescriptionCtrl.clear();
    productImageCtrl.clear();
    productPriceCtrl.clear();
    category = 'General';
    brand = 'Unbranded';
    offer = false;
    update();
  }
}
