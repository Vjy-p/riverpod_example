import 'package:example_riverpod/Models/product_model.dart';
import 'package:example_riverpod/services/productServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier extends ChangeNotifier {
  bool isLoading = false;
  bool errorLoading = false;
  ProductsModel? product;
  List<Products> productList = [];
  loadData() {
    isLoading = true;
    errorLoading = false;
    notifyListeners();

    ProductServices().getAllProducts().then((response) {
      debugPrint("\nresp: $response");
      if (response != null) {
        product = ProductsModel.fromJson(response);
        productList = product!.products;
        isLoading = false;
        errorLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        errorLoading = true;
        notifyListeners();
      }
    });

    isLoading = false;
    errorLoading = false;
    notifyListeners();
  }
}

final homeProvider = ChangeNotifierProvider<HomeNotifier>((ref) {
  return HomeNotifier();
});
