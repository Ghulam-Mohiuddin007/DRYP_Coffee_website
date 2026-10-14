import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/order_tray.dart';
import '../theme/app_theme.dart';

class OrderTrayDialog extends StatefulWidget {
  final List<OrderTrayItem> trayItems;
  final Function(OrderTrayItem, int) onQuantityChanged;
  final VoidCallback onClearTray;

  const OrderTrayDialog({
    super.key,
    required this.trayItems,
    required this.onQuantityChanged,
    required this.onClearTray,
  });

  @override
  State<OrderTrayDialog> createState() => _OrderTrayDialogState();
}

class _OrderTrayDialogState extends State<OrderTrayDialog> {
  final _nameController = TextEditingController();
  final _tableController = TextEditingController();
  String _orderType = 'Dine-In (At Cafe)';

  @override
  void dispose() {
    _nameController.dispose();
    _tableController.dispose();
    super.dispose();
  }

  int get _subtotal {
    return widget.trayItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  void _sendWhatsAppOrder() async {
    final customer = _nameController.text.trim().isEmpty ? 'Guest' : _nameController.text.trim();
    final table = _tableController.text.trim().isEmpty ? 'Counter / Patio' : _tableController.text.trim();

    final itemLines = widget.trayItems
        .map((i) => '• ${i.quantity}x ${i.item.title} (Rs. ${i.totalPrice})')
        .join('%0A');

    final msg =
        'Hello DRYP Coffee & Craft! ☕%0A%0AOrder Inquiry from: *$customer*%0ATable/Type: *$table ($orderType)*%0A%0A*Selected Items:*%0A$itemLines%0A%0A*Estimated Total:* Rs. $_subtotal%0A%0AThank you!';

    final uri = Uri.parse('https://wa.me/?text=$msg');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }

    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppTheme.bgCardElevated,
          content: Text(
            'Order inquiry sent for $customer! Baristas have been notified.',
            style: GoogleFonts.plusJakartaSans(color: AppTheme.textLight),
          ),
        ),
      );
    }
  }

  String get orderType => _orderType;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.bgCardElevated,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: AppTheme.accentAmber.withOpacity(0.4)),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 560),
        padding: const EdgeInsets.all(26),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.accentAmber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.shopping_bag_rounded, color: AppTheme.accentAmber, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your DRYP Order Tray',
                            style: GoogleFonts.outfit(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textLight,
                            ),
                          ),
                          Text(
                            '${widget.trayItems.fold<int>(0, (sum, i) => sum + i.quantity)} items selected',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppTheme.textMuted),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Divider(color: Colors.white12),
              const SizedBox(height: 16),

              if (widget.trayItems.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.coffee_rounded, size: 48, color: Colors.white.withOpacity(0.2)),
                        const SizedBox(height: 12),
                        Text(
                          'Your tray is currently empty',
                          style: GoogleFonts.plusJakartaSans(
                            color: AppTheme.textMuted,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Add handcrafted brews or brownies from the menu below!',
                          style: GoogleFonts.plusJakartaSans(
                            color: AppTheme.textSubtle,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else ...[
                // Item List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.trayItems.length,
                  separatorBuilder: (context, index) => const Divider(color: Colors.white10),
                  itemBuilder: (context, index) {
                    final item = widget.trayItems[index];
                    return Row(
                      children: [
                        // Image Thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: 48,
                            height: 48,
                            child: item.item.isNetwork
                                ? Image.network(
                                    item.item.imagePath,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Image.asset(
                                      'assets/images/dryp_coffee_tray.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Image.asset(
                                    item.item.imagePath,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        // Title & Unit Price
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.item.title,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textLight,
                                ),
                              ),
                              Text(
                                '${item.item.price} each',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  color: AppTheme.accentAmber,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Quantity Stepper
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline, size: 20, color: AppTheme.textMuted),
                              onPressed: () {
                                widget.onQuantityChanged(item, item.quantity - 1);
                                setState(() {});
                              },
                            ),
                            Text(
                              '${item.quantity}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.textLight,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline, size: 20, color: AppTheme.accentAmber),
                              onPressed: () {
                                widget.onQuantityChanged(item, item.quantity + 1);
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        // Total Line Price
                        SizedBox(
                          width: 70,
                          child: Text(
                            'Rs. ${item.totalPrice}',
                            textAlign: TextAlign.end,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textLight,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),
                const Divider(color: Colors.white12),
                const SizedBox(height: 16),

                // Order Type Selector
                Row(
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('Dine-In (Cafe / Patio)'),
                        selected: _orderType == 'Dine-In (At Cafe)',
                        onSelected: (s) {
                          if (s) setState(() => _orderType = 'Dine-In (At Cafe)');
                        },
                        selectedColor: AppTheme.accentAmber,
                        backgroundColor: AppTheme.bgDark,
                        labelStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: _orderType == 'Dine-In (At Cafe)' ? Colors.black : AppTheme.textMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('Takeaway / Pickup'),
                        selected: _orderType == 'Takeaway / Pickup',
                        onSelected: (s) {
                          if (s) setState(() => _orderType = 'Takeaway / Pickup');
                        },
                        selectedColor: AppTheme.accentAmber,
                        backgroundColor: AppTheme.bgDark,
                        labelStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: _orderType == 'Takeaway / Pickup' ? Colors.black : AppTheme.textMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Input fields: Customer name & Table
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        style: GoogleFonts.plusJakartaSans(color: AppTheme.textLight, fontSize: 13),
                        decoration: InputDecoration(
                          hintText: 'Your Name (e.g. Ali)',
                          hintStyle: GoogleFonts.plusJakartaSans(color: AppTheme.textSubtle, fontSize: 12),
                          filled: true,
                          fillColor: AppTheme.bgDark,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _tableController,
                        style: GoogleFonts.plusJakartaSans(color: AppTheme.textLight, fontSize: 13),
                        decoration: InputDecoration(
                          hintText: 'Table # or Note',
                          hintStyle: GoogleFonts.plusJakartaSans(color: AppTheme.textSubtle, fontSize: 12),
                          filled: true,
                          fillColor: AppTheme.bgDark,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Subtotal Summary
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.bgDark,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withOpacity(0.08)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Estimated Total',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textMuted,
                        ),
                      ),
                      Text(
                        'Rs. $_subtotal',
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.accentGold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Order Buttons
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        widget.onClearTray();
                        setState(() {});
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.textMuted,
                        side: BorderSide(color: Colors.white.withOpacity(0.15)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Icon(Icons.delete_sweep_rounded, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _sendWhatsAppOrder,
                        icon: const Icon(Icons.send_rounded, size: 16),
                        label: Text(
                          'Place Order / Inquire',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentAmber,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
