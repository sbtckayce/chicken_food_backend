import 'package:emax_backend/controller/product_controller.dart';
import 'package:emax_backend/models/models.dart';
import 'package:emax_backend/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Products'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                  backgroundColor: Colors.black),
              onPressed: () {
                Get.toNamed('/products/new_product');
              },
              child: Row(
                children: [
                  Icon(Icons.add_circle),
                  SizedBox(width: 10,),
                  Text(
                    'Add a new Product',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              )),
          Expanded(
            child: Obx(
              ()=> ListView.builder(
                  itemCount: productController.products.length,
                  itemBuilder: ((context, index) {
                    return ProductCard(
                        product: productController.products[index],
                        index: index,
                      
                    );
                  })),
            ),
          ),
        ],
      ),
    );
  }
}
