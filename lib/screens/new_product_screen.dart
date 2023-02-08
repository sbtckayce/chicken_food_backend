import 'package:emax_backend/controller/product_controller.dart';
import 'package:emax_backend/models/models.dart';
import 'package:emax_backend/services/database_service.dart';
import 'package:emax_backend/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewProductScreen extends StatelessWidget {
  NewProductScreen({super.key});
  final ProductController productController = Get.find();
  StorageService storage = StorageService();
  DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Add a Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        backgroundColor: Colors.black),
                    onPressed: () async {
                      ImagePicker _picker = ImagePicker();
                      final XFile? _image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (_image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('No image was selected')));
                      }
                      if (_image != null) {
                        await storage.uploadImage(_image);
                        var imageUrl  = await storage.getDownloadUrl(_image.name);
                        productController.newProduct.update('imageUrl', (_) => imageUrl,ifAbsent: ()=> imageUrl);
                        print(productController.newProduct['imageUrl']);
                      
                      }
                    },
                    child: Row(
                      children: [
                        Icon(Icons.add_circle),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Select Image',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Product Information',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                _buildTextFormField(
                    hintText: 'Product ID',
                    name: 'id',
                    productController: productController),
                _buildTextFormField(
                    hintText: 'Product Name',
                    name: 'name',
                    productController: productController),
                _buildTextFormField(
                    hintText: 'Product Description',
                    name: 'description',
                    productController: productController),
                _buildTextFormField(
                    hintText: 'Product Category',
                    name: 'category',
                    productController: productController),
                _buildSlider(
                    title: 'Price',
                    name: 'price',
                    productController: productController,
                    controllerValue: productController.price),
                _buildSlider(
                    title: 'Quantity',
                    name: 'quantity',
                    productController: productController,
                    controllerValue: productController.quantity),
                _buildCheckout(
                    title: 'Recommended',
                    name: 'isRecommended',
                    productController: productController,
                    controllerValue: productController.isRecommended),
                _buildCheckout(
                    title: 'Popular',
                    name: 'isPopular',
                    productController: productController,
                    controllerValue: productController.isPopular),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      databaseService.addProduct(Product(id: productController.newProduct['id'],
                       name: productController.newProduct['name'], 
                       category: productController.newProduct['category'],
                        description: productController.newProduct['description'], 
                        imageUrl: productController.newProduct['imageUrl'],
                         isRecommended: productController.newProduct['isRecommended'], 
                         isPopular: productController.newProduct['isPopular'],
                         price: productController.newProduct['price'],
                         quantity: productController.newProduct['quantity'].toInt()));
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildCheckout(
      {required String title,
      required String name,
      required ProductController productController,
      bool? controllerValue}) {
    return Row(
      children: [
        SizedBox(
          width: 170,
          child: Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Checkbox(
            value: (controllerValue == null) ? false : controllerValue,
            checkColor: Colors.black,
            activeColor: Colors.black12,
            onChanged: (value) {
              productController.newProduct
                  .update(name, (_) => value, ifAbsent: () => value);
            }),
      ],
    );
  }

  Row _buildSlider(
      {required String title,
      required String name,
      required ProductController productController,
      double? controllerValue}) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Slider(
              value: (controllerValue == null) ? 0 : controllerValue,
              min: 0,
              max: 100,
              activeColor: Colors.black,
              inactiveColor: Colors.black12,
              divisions: 10,
              onChanged: (value) {
                productController.newProduct
                    .update(name, (_) => value, ifAbsent: () => value);
              }),
        )
      ],
    );
  }

  TextFormField _buildTextFormField(
          {required String hintText,
          required String name,
          required ProductController productController}) =>
      TextFormField(
        decoration: InputDecoration(hintText: hintText),
        onChanged: (value) {
          productController.newProduct
              .update(name, (_) => value, ifAbsent: () => value);
        },
      );
}
