import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobileappfrontend/core/model/products.dart';
import 'package:mobileappfrontend/core/repositories/product/product_repository.dart';
import 'package:mobileappfrontend/core/utils/colors.dart';
import 'package:mobileappfrontend/core/widgets/carousel_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductWithoutChatPage extends StatefulWidget {
  final String selectedCategory;

  const ProductWithoutChatPage({super.key, required this.selectedCategory});

  @override
  State<ProductWithoutChatPage> createState() => _ProductWithoutChatPageState();
}

class _ProductWithoutChatPageState extends State<ProductWithoutChatPage> {
  final ProductRepository _productRepository =
      GetIt.instance<ProductRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.primaryColor,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              size: 30.0,
            ),
            padding: const EdgeInsets.only(right: 20.0),
          )
        ],
      ),
      body: FutureBuilder(
        future: _productRepository
            .getProductsFromCategoryAsync(widget.selectedCategory),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!(snapshot.data == null ||
              (snapshot.data as List<Product>).isEmpty)) {
            return CarouselWidget(
              products: snapshot.data as List<Product>,
            );
          }

          //display if we don't get any data from rest
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No products found',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(240.0, 46.0),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            'Navigate',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          content: const Text(
                            'Do you wish to find these in other stores?',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();

                                await launchUrl(
                                  Uri.parse(
                                      "https://shopee.ph/search?keyword=sports%20wear"),
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'No',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Explore ${widget.selectedCategory} Products here',
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
