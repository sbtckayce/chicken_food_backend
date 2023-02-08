import 'package:emax_backend/controller/order_stat_controller.dart';
import 'package:emax_backend/widgets/custom_bart_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
final orderStatsController = Get.put(OrderStatsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('Chicken Food'),
      centerTitle: true,
      backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Column(children: [
          FutureBuilder(
                future: orderStatsController.stats.value,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        padding: EdgeInsets.all(10),
                        height: 250,
                        child: CustomBarChart(orderStats: snapshot.data!));
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })),
          InkWell(
            onTap: (){
              Get.toNamed('/products');
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                color:Colors.black87
              ),
              child: Center(child: Text('Go to Products',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:Colors.white),)),
            ),
          ),
          SizedBox(height: 20,),
          InkWell(
            onTap: (){
              Get.toNamed('/orders');
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                color:Colors.black87
              ),
              child: Center(child: Text('Go to Orders',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:Colors.white),)),
            ),
          )
        ],),
      ),
    );
  }
}