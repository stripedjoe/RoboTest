import 'package:mobileappfrontend/core/model/category.dart';
import 'package:mobileappfrontend/core/model/products.dart';
import 'package:mobileappfrontend/core/repositories/product/product_repository.dart';

class ProductRepositoryMock implements ProductRepository {
  @override
  Future<List<Category>> getProductCategoriesAsync() {
    Set<String> categoryNames = <String>{};
    List<Category> productCategories = [];

    for (var product in productsItems) {
      if (!categoryNames.contains(product.category)) {
        categoryNames.add(product.category);
        productCategories.add(
          Category(
            name: product.category,
            numberEquivalent: (productCategories.length + 1).toString(),
            products: productsItems
                .where((item) => item.category == product.category)
                .toList(),
          ),
        );
      }
    }

    return Future.value(productCategories);
  }

  @override
  Future<List<Product>> getProductsFromCategoryAsync(String category) {
    var productItems =
        productsItems.where((product) => product.category == category).toList();
    return Future.value(productItems);
  }

  @override
  Future<void> sendSelectedCategoryAsync(String selectedCategory) {
    //do nothing
    return Future.value();
  }

  @override
  Future<void> sendSelectedProductAsync(String selectedProduct) {
    //do nothing
    return Future.value();
  }

  @override
  Future<void> sendProductsAsync(List<Product> products) {
    //do nothing
    return Future.value();
  }

  @override
  Future<void> sendAppLifeCycleStateAsync(String state) {
    //do nothing
    return Future.value();
  }
}
