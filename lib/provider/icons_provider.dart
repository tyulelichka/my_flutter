import 'package:flutter/material.dart';
import 'package:todolist/provider/icons_repo.dart';

class IconsProvider extends ChangeNotifier {
  final IconsRepository _repo;

  IconsProvider(this._repo);

  Map<String, IconData> get allIcons => _repo.getAllIcons();

  IconData? getIcon(String name) => _repo.getIconByName(name);
}
