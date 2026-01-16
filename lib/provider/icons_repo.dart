import 'package:flutter/material.dart';

abstract class IconsRepository {
  Map<String, IconData> getAllIcons();
  IconData? getIconByName(String name);
  static IconData? getIcon(String name) {
    return IconsRepositoryImpl.nameIcon[name] ?? null;
  }
}

class IconsRepositoryImpl implements IconsRepository {
  static const Map<String, IconData> nameIcon = {
    'all': Icons.list,
    'home': Icons.home,
    'work': Icons.work,
    'study': Icons.school,
    'shopping': Icons.shopping_cart,
    'health': Icons.health_and_safety,
    'sport': Icons.fitness_center,
    'travel': Icons.flight_takeoff,
    'finance': Icons.account_balance_wallet,
    'reading': Icons.menu_book,
    'cleaning': Icons.cleaning_services,
    'birthday': Icons.cake,
    'cleaning_list': Icons.local_laundry_service,
    'maintenance': Icons.build,
    'entertainment': Icons.movie,
    'reminder': Icons.notifications,
    'daily': Icons.today,
    'gift': Icons.card_giftcard,
  };
  @override
  Map<String, IconData> getAllIcons() {
    return IconsRepositoryImpl.nameIcon;
  }

  IconData? getIcon(String name) {
    return IconsRepositoryImpl.nameIcon[name] ?? null;
  }

  @override
  IconData? getIconByName(String name) {
    return getIcon(name);
  }
}
