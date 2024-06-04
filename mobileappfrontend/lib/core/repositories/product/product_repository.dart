import 'package:mobileappfrontend/core/model/category.dart';
import 'package:mobileappfrontend/core/model/products.dart';

abstract class ProductRepository {
  Future<List<Category>> getProductCategoriesAsync();
  Future<List<Product>> getProductsFromCategoryAsync(String category);
  Future<void> sendSelectedCategoryAsync(String selectedCategory);
  Future<void> sendSelectedProductAsync(String selectedProduct);

  // For product_chat_page.dart only
  Future<void> sendProductsAsync(List<Product> products);
}
