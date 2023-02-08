import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderStats {
  final DateTime dateTime;
  final int index;
  final int orders;
  charts.Color? barColor;

  OrderStats(
      {required this.dateTime,
      required this.index,
      required this.orders,
      this.barColor}) {
    barColor = charts.ColorUtil.fromDartColor(Colors.black);
  }
  factory OrderStats.fromSnapshot(DocumentSnapshot snap, int index) {
    return OrderStats(
        dateTime: snap['dateTime'].toDate(),
        index: index,
        orders: snap['orders']);
  }
  static final List<OrderStats> data = [
    OrderStats(
      dateTime: DateTime.now(),
      index: 0,
      orders: 10,
    ),
    OrderStats(
      dateTime: DateTime.now(),
      index: 1,
      orders: 12,
    ),
    OrderStats(
      dateTime: DateTime.now(),
      index: 2,
      orders: 15,
    ),
    OrderStats(
      dateTime: DateTime.now(),
      index: 3,
      orders: 12,
    ),
    OrderStats(
      dateTime: DateTime.now(),
      index: 4,
      orders: 9,
    )
  ];
}
