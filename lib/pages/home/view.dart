import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/pages/home/controller.dart';
import 'package:flutter_template/widgets/nested_overscroll.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 32,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.plus_one),
          )
        ],
      ),
      body: NestedOverscroll(
        child: Obx(
          () => PageView(
            physics: const PageScrollPhysics(),
            onPageChanged: homeController.onPageChange,
            scrollDirection: Axis.vertical,
            children: [
              for (int i = 0; i < homeController.count.value; i++)
                SingleChildScrollView(
                  child: longColumn(Color(Random().nextInt(0xffffffff))),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget longColumn(Color color) {
    return Column(
      children: [
        for (int i = 0; i < 50; i++)
          Text(
            'Item $i',
            style: TextStyle(color: color, fontSize: 32),
          ),
      ],
    );
  }
}
