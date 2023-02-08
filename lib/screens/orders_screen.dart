import 'package:emax_backend/controller/order_controller.dart';
import 'package:emax_backend/models/models.dart';
import 'package:emax_backend/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
   OrdersScreen({super.key});
  final OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Orders'),
      ),
      body: Obx(
       ()=> ListView.builder(
            itemCount: orderController.pendingOrders.length,
            itemBuilder: ((context, index) {
              return OrderCard(
                order: orderController.pendingOrders[index],
              );
            })),
      ),
    );
  }
}

