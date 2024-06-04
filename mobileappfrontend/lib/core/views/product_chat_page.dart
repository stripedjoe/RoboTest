import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobileappfrontend/core/model/products.dart';
import 'package:mobileappfrontend/core/repositories/product/product_repository.dart';
import 'package:mobileappfrontend/core/utils/colors.dart';
import 'package:mobileappfrontend/core/widgets/carousel_widget.dart';
import 'package:collection/collection.dart';

class ProductChatPage extends StatefulWidget {
  const ProductChatPage({super.key});

  @override
  State<ProductChatPage> createState() => _ProductChatPageState();
}

class _ProductChatPageState extends State<ProductChatPage> {
  final ProductRepository _productRepository =
      GetIt.instance<ProductRepository>();
  final TextEditingController _textController = TextEditingController();

  List<Product> _products = productsItems.sample(5);

  int currentIndex = 0;
  int selectedIndex = -1;

  void _randomizeCatalog() async {
    Product currentProduct = _products[currentIndex];
    selectedIndex = -1;
    _textController.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      do {
        _products = productsItems.sample(5);
        _products.shuffle();
      } while (_products[currentIndex] == currentProduct);
    });

    await _productRepository.sendProductsAsync(_products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.primaryColor,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          // No functionality yet since this is the first page
          onPressed: () {},
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
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CarouselWidget(
                    products: _products,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: _textController,
                  onEditingComplete: _randomizeCatalog,
                  decoration: InputDecoration(
                    hintText: 'Enter your message here',
                    hintStyle: const TextStyle(
                      color: AppColors.primaryColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: _randomizeCatalog,
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
