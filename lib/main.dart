import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/menu_item.dart';
import 'models/order_tray.dart';
import 'models/review_model.dart';
import 'theme/app_theme.dart';
import 'widgets/hero_section.dart';
import 'widgets/location_footer.dart';
import 'widgets/menu_section.dart';
import 'widgets/navbar.dart';
import 'widgets/order_tray_dialog.dart';
import 'widgets/reviews_section.dart';
import 'widgets/story_section.dart';
import 'widgets/vibe_section.dart';
import 'widgets/write_review_dialog.dart';

void main() {
  runApp(const DrypCoffeeApp());
}

class DrypCoffeeApp extends StatelessWidget {
  const DrypCoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DRYP Coffee & Craft | Artisanal Specialty Coffee & Bakery',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const DrypHomePage(),
    );
  }
}

class DrypHomePage extends StatefulWidget {
  const DrypHomePage({super.key});

  @override
  State<DrypHomePage> createState() => _DrypHomePageState();
}

class _DrypHomePageState extends State<DrypHomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _storyKey = GlobalKey();
  final GlobalKey _menuKey = GlobalKey();
  final GlobalKey _vibeKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  final GlobalKey _locationKey = GlobalKey();

  double _scrollOffset = 0.0;
  double _scrollProgress = 0.0;
  List<CustomerReview> _reviews = [];
  final List<OrderTrayItem> _tray = [];

  @override
  void initState() {
    super.initState();
    _reviews = CustomerReview.getSampleReviews();

    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      final maxScroll = _scrollController.position.maxScrollExtent;
      setState(() {
        _scrollOffset = offset;
        _scrollProgress = maxScroll > 0 ? (offset / maxScroll).clamp(0.0, 1.0) : 0.0;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _addToTray(CraftMenuItem item) {
    setState(() {
      final index = _tray.indexWhere((t) => t.item.id == item.id);
      if (index >= 0) {
        _tray[index].quantity++;
      } else {
        _tray.add(OrderTrayItem(item: item, quantity: 1));
      }
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.bgCardElevated,
        duration: const Duration(milliseconds: 1800),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppTheme.accentAmber),
        ),
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: AppTheme.accentAmber, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Added "${item.title}" to your tray (Rs. ${item.rawPrice})',
                style: GoogleFonts.plusJakartaSans(color: AppTheme.textLight, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openTrayModal() {
    showDialog(
      context: context,
      builder: (context) => OrderTrayDialog(
        trayItems: _tray,
        onQuantityChanged: (item, newQty) {
          setState(() {
            if (newQty <= 0) {
              _tray.removeWhere((i) => i.item.id == item.item.id);
            } else {
              item.quantity = newQty;
            }
          });
        },
        onClearTray: () {
          setState(() {
            _tray.clear();
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _openWriteReviewDialog() {
    showDialog(
      context: context,
      builder: (context) => WriteReviewDialog(
        onReviewSubmitted: (newReview) {
          setState(() {
            _reviews.insert(0, newReview);
          });
        },
      ),
    );
  }

  void _openItemDetailsModal(CraftMenuItem item) {
    showDialog(
      context: context,
      builder: (context) => _MenuItemDetailsDialog(
        item: item,
        onAddToTray: () => _addToTray(item),
      ),
    );
  }

  void _openPhotoLightbox(String title, String imagePath, String caption) {
    showDialog(
      context: context,
      builder: (context) => _PhotoLightboxDialog(
        title: title,
        imagePath: imagePath,
        caption: caption,
      ),
    );
  }

  int get _trayCount => _tray.fold(0, (sum, i) => sum + i.quantity);
  int get _trayTotal => _tray.fold(0, (sum, i) => sum + i.totalPrice);

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Top offset for sticky navbar
                const SizedBox(height: 70),

                // Hero Section
                Container(
                  key: _heroKey,
                  child: DrypHeroSection(
                    onMenuClick: () => _scrollToKey(_menuKey),
                    onReviewsClick: () => _scrollToKey(_reviewsKey),
                    onStoryClick: () => _scrollToKey(_storyKey),
                  ),
                ),

                // Philosophy & Story Section
                Container(
                  key: _storyKey,
                  child: const DrypStorySection(),
                ),

                // Craft Menu Section (With Search and Category Navigation)
                Container(
                  key: _menuKey,
                  child: DrypMenuSection(
                    onItemSelect: _openItemDetailsModal,
                    onAddToTray: _addToTray,
                  ),
                ),

                // Atmosphere & Photo Gallery Section
                Container(
                  key: _vibeKey,
                  child: DrypVibeSection(
                    onPhotoTap: _openPhotoLightbox,
                  ),
                ),

                // Google Reviews Section
                Container(
                  key: _reviewsKey,
                  child: DrypReviewsSection(
                    reviews: _reviews,
                    onReviewAdded: (newReview) {
                      setState(() {
                        _reviews.insert(0, newReview);
                      });
                    },
                  ),
                ),

                // Location & Hours Footer
                Container(
                  key: _locationKey,
                  child: DrypLocationFooter(
                    onWriteReviewClick: _openWriteReviewDialog,
                  ),
                ),
              ],
            ),
          ),

          // Sticky Top Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DrypNavBar(
                  onStoryClick: () => _scrollToKey(_storyKey),
                  onMenuClick: () => _scrollToKey(_menuKey),
                  onVibeClick: () => _scrollToKey(_vibeKey),
                  onReviewsClick: () => _scrollToKey(_reviewsKey),
                  onLocationClick: () => _scrollToKey(_locationKey),
                  onWriteReviewClick: _openWriteReviewDialog,
                  onTrayClick: _openTrayModal,
                  trayCount: _trayCount,
                  scrollProgress: _scrollOffset,
                ),
                // Smooth Animated Scroll Progress Indicator
                Container(
                  height: 2.5,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: _scrollProgress,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.accentAmber,
                            AppTheme.accentGold,
                            AppTheme.accentWarmOrange,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Floating Order Tray Bar (when items added!)
          if (_tray.isNotEmpty)
            Positioned(
              bottom: 24,
              left: 20,
              right: isDesktop ? null : 20,
              child: InkWell(
                onTap: _openTrayModal,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: isDesktop ? 460 : double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppTheme.bgCardElevated,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.accentAmber, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                      BoxShadow(
                        color: AppTheme.accentAmber.withOpacity(0.2),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.accentAmber,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.shopping_bag_rounded, color: Colors.black, size: 18),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '$_trayCount items in Tray',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textLight,
                                ),
                              ),
                              Text(
                                'Rs. $_trayTotal estimated',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.accentGold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'View Tray',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.accentAmber,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_forward_rounded, size: 16, color: AppTheme.accentAmber),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Floating Back-to-Top Button
          if (_scrollOffset > 400 && _tray.isEmpty)
            Positioned(
              bottom: 24,
              right: 24,
              child: FloatingActionButton(
                mini: !isDesktop,
                backgroundColor: AppTheme.accentAmber,
                foregroundColor: Colors.black,
                elevation: 6,
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutCubic,
                  );
                },
                child: const Icon(Icons.arrow_upward_rounded),
              ),
            ),
        ],
      ),
    );
  }
}

class _MenuItemDetailsDialog extends StatelessWidget {
  final CraftMenuItem item;
  final VoidCallback onAddToTray;

  const _MenuItemDetailsDialog({
    required this.item,
    required this.onAddToTray,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.bgCardElevated,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: AppTheme.accentAmber.withOpacity(0.4)),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 580),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Header
            Stack(
              children: [
                SizedBox(
                  height: 270,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(23)),
                    child: item.isNetwork
                        ? Image.network(
                            item.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Image.asset(
                              'assets/images/dryp_coffee_tray.jpg',
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            item.imagePath,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Positioned(
                  top: 14,
                  right: 14,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close_rounded, color: Colors.white, size: 20),
                    ),
                  ),
                ),
                Positioned(
                  top: 14,
                  left: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Text(
                      item.category.toUpperCase(),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (item.badge != null)
                  Positioned(
                    bottom: 14,
                    left: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.accentAmber),
                      ),
                      child: Text(
                        item.badge!,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.accentAmber,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Item Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: GoogleFonts.outfit(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textLight,
                          ),
                        ),
                      ),
                      Text(
                        item.price,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.accentGold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.description,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: AppTheme.textMuted,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Notes & Ingredients',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.accentGold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: item.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppTheme.bgDark,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withOpacity(0.08)),
                        ),
                        child: Text(
                          tag,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: AppTheme.textLight,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            onAddToTray();
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.add_shopping_cart_rounded, size: 18),
                          label: Text(
                            'Add to Tray (${item.price})',
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
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoLightboxDialog extends StatelessWidget {
  final String title;
  final String imagePath;
  final String caption;

  const _PhotoLightboxDialog({
    required this.title,
    required this.imagePath,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 820),
        decoration: BoxDecoration(
          color: AppTheme.bgDark,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppTheme.accentAmber.withOpacity(0.4)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.8),
              blurRadius: 30,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo with Close Button
            Stack(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 520),
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  top: 14,
                  right: 14,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close_rounded, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),

            // Caption Info
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textLight,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    caption,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: AppTheme.textMuted,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
