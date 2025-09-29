import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:product_list_app/controller/product_list_controller.dart';
import 'package:shimmer/shimmer.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key});
  final ProductListController controller = Get.put(ProductListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextFormField(
                controller: controller.searchTEController,
                decoration: InputDecoration(
                  hintText: 'Search Product',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                onChanged: (value) => controller.searchProduct(value),
              ),
              SizedBox(height: 10.h),

              Obx(() {
                final allCategories = ['All', ...controller.categories];
                return DropdownButton<String>(
                  value: controller.selectedCategory.value,
                  items:
                      allCategories.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.filterByCategory(value);
                    }
                  },
                );
              }),

              Obx(() {
                if (controller.isLoading.value) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: ListTile(
                            leading: Container(
                              height: 50.h,
                              width: 50.w,
                              color: Colors.white,
                            ),
                            title: Container(
                              height: 10.h,
                              width: 10.w,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    ),
                  );
                }
                return Expanded(
                  child: ListView.separated(
                    itemCount: controller.listData.length,
                    itemBuilder: (context, index) {
                      var product = controller.listData[index];
                      return Card(
                        child: ListTile(
                          leading: Image(
                            height: 50.h,
                            width: 50.w,
                            image: NetworkImage(product.image),
                          ),
                          title: Text(product.title),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
