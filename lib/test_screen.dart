import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final _productIds = {'product_1', 'product_2', 'product_3'};
  InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Stream purchaseUpdated =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    initStoreInfo();
  }

  initStoreInfo() async {
    ProductDetailsResponse productDetailResponse =
        await _connection.queryProductDetails(_productIds);
    if (productDetailResponse.error == null) {
      setState(() {
        _products = productDetailResponse.productDetails;
      });
    }
  }

  _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // show progress bar or something
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // show error message or failure icon
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          // show success message and deliver the product.
        }
      }
    });
  }

  _buyProduct() {
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: _products[0]);
    _connection.buyConsumable(purchaseParam: purchaseParam);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
