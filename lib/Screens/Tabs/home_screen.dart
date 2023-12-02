import 'package:example_riverpod/Screens/Widgets/vertical_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:example_riverpod/Controllers/homeController/home_controller.dart';
import 'package:example_riverpod/utils/customButton.dart';
import 'package:example_riverpod/utils/custom_loading.dart';
import 'package:example_riverpod/utils/custom_text.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeProvider).loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var homeprovider = ref.watch(homeProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: homeprovider.isLoading
          ? CustomLoading().circularLoading()
          : homeprovider.errorLoading
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      customText(text: "Something went wrong,Try Again."),
                      SizedBox(
                        height: 10.h,
                      ),
                      customButton(
                          text: "Retry",
                          onTap: () {
                            ref.read(homeProvider).loadData();
                          })
                    ],
                  ),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: homeprovider.productList.length,
                  physics: const BouncingScrollPhysics(),
                  padding:
                      REdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  itemBuilder: (context, index) {
                    return verticalTile(
                        img: homeprovider.productList[index].thumbnail,
                        title: homeprovider.productList[index].brand +
                            homeprovider.productList[index].title,
                        price: homeprovider.productList[index].price.toString(),
                        onTap: () {});
                  },
                ),
    );
  }
}
