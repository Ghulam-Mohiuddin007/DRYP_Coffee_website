import 'menu_item.dart';

class OrderTrayItem {
  final CraftMenuItem item;
  int quantity;

  OrderTrayItem({
    required this.item,
    this.quantity = 1,
  });

  int get totalPrice => item.rawPrice * quantity;
}
