import 'dart:ui';

class CommonModel {
  String title;
  String? subtitle;
  String? message;
  VoidCallback? onTap;
  String? icon;
  String? selectedIcon;
  bool isSelected;
  int? id;

  CommonModel(
      {required this.title,
        this.message,
      this.subtitle,
      this.onTap,
      this.isSelected = false,this.icon,this.selectedIcon, this.id});
}
