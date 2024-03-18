import 'package:flutter/material.dart';

abstract class ScrollListenerState<T extends StatefulWidget> extends State<T> {
  final scrollController = ScrollController();
  int blurHeightLimit = 200;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(didScroll);
  }

  Future<void> didScroll();

  @override
  void dispose() {
    scrollController.removeListener(didScroll);
    scrollController.dispose();
    super.dispose();
  }
}