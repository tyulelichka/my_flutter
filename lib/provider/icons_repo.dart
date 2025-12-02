import 'package:flutter/material.dart';
import 'package:todolist/data/icons.dart';

abstract class IconsRepository {
  Map<String, IconData> getAllIcons();
  IconData? getIconByName(String name);
}

class IconsRepositoryImpl implements IconsRepository {
  @override
  Map<String, IconData> getAllIcons() {
    return IconsMap.nameIcon;
  }

  @override
  IconData? getIconByName(String name) {
    return IconsMap.getIcon(name);
  }
}
