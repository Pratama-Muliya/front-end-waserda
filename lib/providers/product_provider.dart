import 'package:flutter/material.dart';
import 'package:waserda/models/category_model.dart';
import 'package:waserda/models/product_model.dart';
import 'package:waserda/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> _productsCategory = [];
  int _idCategory = 6;
  bool _isCategory = false;

  List<CategoryModel> _caterogy = [];

  List<ProductModel> get productsCategory => _productsCategory;
  List<ProductModel> get products => _products;
  List<CategoryModel> get category => _caterogy;
  bool get isCategory => _isCategory;
  int get idCategory =>_idCategory;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  set isCategory(bool value) {
    _isCategory = value;
    notifyListeners();
  }
  set idCategory(int value) {
    _idCategory = value;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductModel> products = await ProductService().getProducts();
      _products = products;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getProductsByName(int id) async {
    _productsCategory = [];
    try {
      List<ProductModel> productsCategory =
          await ProductService().getProductsByName(id);
      _productsCategory = productsCategory;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getNameCategory() async {
    try {
      List<CategoryModel> category = await ProductService().getNameCategory();
      _caterogy = category;
            _caterogy.sort((a, b) => b.id.compareTo(a.id));

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
