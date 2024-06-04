import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:mobileappfrontend/app.dart';
import 'package:mobileappfrontend/core/repositories/product/product_repository.dart';
import 'package:mobileappfrontend/core/repositories/product/product_repository_impl.dart';

void main() async {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setupLocator();

  await Future.delayed(const Duration(seconds: 3));
  runApp(const MyMaterialApp());
  FlutterNativeSplash.remove();
}

// Register your repositories
void setupLocator() {
  GetIt.instance
      .registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());
}
