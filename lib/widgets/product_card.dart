import 'package:emax_backend/controller/product_controller.dart';
import 'package:emax_backend/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key? key,
    required this.product, required this.index,
  }) : super(key: key);
  final Product product;
  final int index;
  final ProductController productController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 70,
                            child: Text(
                              'Price',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 170,
                            child: Slider(
                                value: product.price,
                                min: 0,
                                max: 50,
                                divisions: 10,
                                activeColor: Colors.black,
                                inactiveColor: Colors.black12,
                                onChanged: (value) {
                                  productController.updateProductPrice(index, product, value);
                                },
                                onChangeEnd: (value){
                                  productController.saveNewProductPrice(product, 'price', value);
                                },
                                ),
                                
                          ),
                          Text(
                            '\$${product.price.toStringAsFixed(1)}',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
              children: [
                 SizedBox(
                  width: 70,
                   child: Text(
                              'Quantity',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                 ),
                SizedBox(
                  width: 170,
                  child: Slider(
                      value: product.quantity.toDouble(),
                      min: 0,
                      max: 10,
                      activeColor: Colors.black,
                      inactiveColor: Colors.black12,
                      divisions: 10,
                      onChanged: (value) {
                        productController.updateProductQuantity(index, product, value.toInt());
                      },
                       onChangeEnd: (value){
                                  productController.saveNewProductPrice(product, 'quantity', value);
                                },
                      ),
                ),
                    Text(
                            '\$${product.quantity.toStringAsFixed(1)}',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
              ],
            )
                    ],
                  ),
                )
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
