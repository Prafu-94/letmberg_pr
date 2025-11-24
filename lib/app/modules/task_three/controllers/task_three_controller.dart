import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:letmberg_pr/app/data/theme/app_colors.dart';

class TaskThreeController extends GetxController {
  Rx<Color> textColor = AppColors.whiteColor.obs;
  RxInt currentPage = 0.obs;
  PageController? pageController;
  bool running = true;

  final List<String> horizontalString = [
    "100%.\nWe charge zero\ncommission on\nyour sales.",
    "Always.\nPayments are\nsecure and\non-time,\nevery time.",
    "Yes!\nWe deliver to\n20,000+ pin codes\nacross India.",
    "No worries\noffline exposure is\npart of the plan.",
    "With us,\nyou get fewer\nreturns and\nmore profit.",
  ];
  final List<String> verticleString = [
    "How much\nof my earnings\ndo I get to keep?",
    "Will I get paid\non time,\nand is it safe?",
    "Can I reach more\ncustomers beyond\nmy area?",
    "What if most of my\nsales happen offline?",
    "How do I minimize\nreturns and losses?",
  ];

  final List<Color> colors = [
    Color(0xff27AE60),
    Color(0xff2980B9),
    Color(0xff9B59B6),
    Color(0xffE67E22),
    Color(0xffE74C3C),
  ];

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) => _startAutoScroll());
    super.onInit();
  }

  @override
  void dispose() {
    running = false;
    pageController?.dispose();
    super.dispose();
  }

  Future<void> _startAutoScroll() async {
    pageController?.jumpToPage(currentPage.value);
    await Future.delayed(const Duration(milliseconds: 50));
    await _animateTo(currentPage.value);
    while (running) {
      await Future.delayed(Duration(milliseconds: 2500));
      if (currentPage.value < colors.length) {
        currentPage.value++;
        await _animateTo(currentPage.value - 1);
      }
    }
  }

  Future<void> _animateTo(int page) async {
    try {
      await pageController
          ?.animateToPage(
            page,
            duration: Duration(milliseconds: 700),
            curve: Curves.linear,
          )
          .then((value) {
            textColor.value = Colors.black;
          });
    } catch (error) {}
  }
}
