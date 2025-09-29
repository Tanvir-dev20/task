import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_list_app/data/services/api_caller.dart';

class ProductListController extends GetxController {
  final TextEditingController searchTEController = TextEditingController();

  RxBool isLoading = true.obs;
  RxList listData = <dynamic>[].obs;
  List originalData = <dynamic>[];

  RxList<String> categories = <String>[].obs;
  RxString selectedCategory = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading(true);
      final data = await ApiCaller.getProduct();
      originalData = data;
      listData.assignAll(data);

      final uniqCategories =
          data.map((item) => item.category as String).toSet().toList();
      categories.assignAll(uniqCategories);
    } finally {
      isLoading(false);
    }
  }

  void searchProduct(String query) {
    if (query.isEmpty) {
      listData.assignAll(originalData);
    } else {
      listData.assignAll(
        originalData.where((item) {
          final product = item.title.toString().toLowerCase();
          return product.contains(query.toLowerCase());
        }),
      );
    }
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    if (category == 'All') {
      listData.assignAll(originalData);
    } else {
      listData.assignAll(
        originalData.where((item) => item['category'] == category),
      );
    }
  }

  @override
  void dispose() {
    searchTEController.dispose();
    super.dispose();
  }
}
