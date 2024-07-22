import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Add this import
import 'package:shopy_admin/controller/home_controler.dart';
import 'package:shopy_admin/widgets/dropdown_button.dart';

class AddProductController extends GetxController {
  // Add your controller logic here
}

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add products'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Add New Products',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.indigoAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: ctrl.productNameCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Product Name',
                      hintText: 'Enter Your Product Name',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: ctrl.productDescriptionCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Description',
                      hintText: 'Enter Description',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: ctrl.productImageCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Image URL',
                      hintText: 'Enter Image URL',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: ctrl.productPriceCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Price',
                      hintText: 'Enter Product Price',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                          child: DropDownBtn(
                        items: [
                          'Shoes',
                          'Crocs',
                          'Casuals',
                          'Sports',
                          'Flip-Flops',
                          'Slippers',
                          'Boots',
                        ],
                        selectedItemText: ctrl.category,
                        onSelected: (selectedValue) {
                          ctrl.category = selectedValue ?? 'General';
                          ctrl.update();
                        },
                      )),
                      Flexible(
                        child: DropDownBtn(
                          items: const [
                            'Nike',
                            'Puma',
                            'Woodland',
                            'Adidas',
                            'Skechers',
                            'Crocs'
                          ],
                          selectedItemText: ctrl.brand ?? 'Un Branded',
                          onSelected: (selectedValue) {
                            ctrl.brand = selectedValue;
                            ctrl.update();
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Offer Product'),
                  const SizedBox(height: 10),
                  DropDownBtn(
                    items: ['True', 'False'],
                    selectedItemText: ctrl.offer.toString(),
                    onSelected: (selectedValue) {
                      ctrl.offer =
                          bool.tryParse(selectedValue ?? 'false') ?? false;
                      ctrl.update();
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                          foregroundColor:
                              Colors.white), //inside button text colour change
                      onPressed: () {
                        ctrl.addProduct();
                      },
                      child: Text('Add Product'))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
