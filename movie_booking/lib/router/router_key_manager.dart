import 'package:flutter/material.dart';

class RouterKeyManager {
  static final instance = RouterKeyManager();
  final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root_key');
  final GlobalKey<NavigatorState> homeNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'home_key');
  final GlobalKey<NavigatorState> categoryNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'category_key');
  final GlobalKey<NavigatorState> nutritionNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'nutrition_key');
  final GlobalKey<NavigatorState> profileNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'profile_key');
  final GlobalKey<NavigatorState> aboutUsNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'about_us_key');
}
