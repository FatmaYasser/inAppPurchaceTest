import 'package:flutter/material.dart';
import 'package:flutter_app_purchase/payment_service.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

void main() {
  InAppPurchaseConnection.enablePendingPurchases();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaymentService(),
    );
  }
}
