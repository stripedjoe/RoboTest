import 'dart:convert';
import 'package:mobileappfrontend/core/model/category.dart';
import 'package:mobileappfrontend/core/model/products.dart';
import 'package:mobileappfrontend/core/repositories/product/product_repository.dart';
import 'package:http/http.dart' as http;

class ProductRepositoryImpl implements ProductRepository {
  static const String _baseApi =
      "https://flutterpocfunction.azurewebsites.net"; //"http://10.0.2.2:7167";

  final String _getListOfProductCategoriesEndpoint =
      '$_baseApi/api/GetListOfProductCategories';
  final String _getProductsByCategoryEndpoint =
      '$_baseApi/api/GetProductsByCategory/';
  final String _postTriggerEndpoint = '$_baseApi/api/PostTriggerAsync';
  final String _postProductsEndPoint = '$_baseApi/api/PostProductsAsync';

  @override
  Future<List<Category>> getProductCategoriesAsync() async {
    final response =
        await http.get(Uri.parse(_getListOfProductCategoriesEndpoint));

    if (response.statusCode != 200) {
      throw Exception('Failed to load product categories');
    }

    List<dynamic> categories = jsonDecode(response.body);
    var categoryList =
        categories.map((category) => Category.fromJson(category)).toList();
    return categoryList;
  }

  @override
  Future<List<Product>> getProductsFromCategoryAsync(String category) async {
    final response =
        await http.get(Uri.parse('$_getProductsByCategoryEndpoint/$category'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load product from category');
    }

    List<dynamic> products = jsonDecode(response.body);
    var productList =
        products.map((product) => Product.fromJson(product)).toList();
    return productList;
  }

  @override
  Future<void> sendSelectedCategoryAsync(String selectedCategory) async {
    if (selectedCategory.isEmpty) {
      return;
    }

    await http.post(Uri.parse(_postTriggerEndpoint), body: selectedCategory);
  }

  @override
  Future<void> sendSelectedProductAsync(String selectedProduct) async {
    if (selectedProduct.isEmpty) {
      return;
    }

    await http.post(Uri.parse(_postTriggerEndpoint), body: selectedProduct);
  }

  @override
  Future<void> sendProductsAsync(List<Product> products) async {
    if (products.isEmpty) {
      return;
    }

    await http.post(
      Uri.parse(_postProductsEndPoint),
      body: jsonEncode(products),
    );
  }
}
