import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class DrypVibeSection extends StatelessWidget {
  final Function(String title, String imagePath, String caption) onPhotoTap;

  const DrypVibeSection({
    super.key,
    required this.onPhotoTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 980;

    final gallery = [
      {
        'title': 'Night Ambiance & Patio',
        'image': 'assets/images/dryp_storefront_night.jpg',
        'tag': 'EXTERIOR VIBE',
        'caption': 'Warm illuminated facade with lush greenery and cozy outdoor tables under the evening stars. Open till midnight.',
      },
      {
        'title': 'Custom Curved Neon Light',
        'image': 'assets/images/dryp_bar_counter.jpg',
        'tag': 'BARISTA CRAFT',
        'caption': 'The focal point of our bar: custom glowing tube lighting, commercial espresso gear, and chalkboard weekend specials.',
      },
      {
        'title': 'Signature Plated Pairings',
        'image': 'assets/images/dryp_coffee_tray.jpg',
        'tag': 'CRAFT COFFEE',
        'caption': 'Every drink served on dark wooden trays with custom DRYP napkins, artisanal latte art, and rich dessert accompaniments.',
      },
      {
        'title': 'The Handcrafted Bakery Case',
        'image': 'assets/images/dryp_bakery_display.jpg',
        'tag': 'FRESH BAKES',
        'caption': 'Freshly baked batches of fudge brownies, triple chocolate cookies, and weekend cinnamon rolls right at the entrance.',
      },
      {
        'title': 'Daylight Facade & Sidewalk',
        'image': 'assets/images/dryp_storefront_day.jpg',
        'tag': 'STREET VIEW',
        'caption': 'Located on Police Station Road. A peaceful oasis with natural wood and vertical green gardens.',
      },
    ];

    return Container(
      width: double.infinity,
      color: AppTheme.bgCard,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 24,
        vertical: 80,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1240),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.bgDark,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.accentAmber.withOpacity(0.35),
                    width: 1,
                  ),
                ),
                child: Text(
                  'THE DRYP EXPERIENCE',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    color: AppTheme.accentAmber,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Title
              Text(
                'Step Inside Our Space',
                style: GoogleFonts.outfit(
                  fontSize: isDesktop ? 38 : 28,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textLight,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Click any moment below to view the authentic details of our craft bar and bakery.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  color: AppTheme.textMuted,
                ),
              ),

              const SizedBox(height: 40),

              // Responsive Gallery Layout
              isDesktop
                  ? Column(
                      children: [
                        // Row 1: Featured 2 large cards
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: _GalleryItemCard(
                                title: gallery[0]['title']!,
                                imagePath: gallery[0]['image']!,
                                tag: gallery[0]['tag']!,
                                height: 380,
                                onTap: () => onPhotoTap(
                                  gallery[0]['title']!,
                                  gallery[0]['image']!,
                                  gallery[0]['caption']!,
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              flex: 5,
                              child: _GalleryItemCard(
                                title: gallery[1]['title']!,
                                imagePath: gallery[1]['image']!,
                                tag: gallery[1]['tag']!,
                                height: 380,
                                onTap: () => onPhotoTap(
                                  gallery[1]['title']!,
                                  gallery[1]['image']!,
                                  gallery[1]['caption']!,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Row 2: 3 cards
                        Row(
                          children: [
                            Expanded(
                              child: _GalleryItemCard(
                                title: gallery[2]['title']!,
                                imagePath: gallery[2]['image']!,
                                tag: gallery[2]['tag']!,
                                height: 320,
                                onTap: () => onPhotoTap(
                                  gallery[2]['title']!,
                                  gallery[2]['image']!,
                                  gallery[2]['caption']!,
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: _GalleryItemCard(
                                title: gallery[3]['title']!,
                                imagePath: gallery[3]['image']!,
                                tag: gallery[3]['tag']!,
                                height: 320,
                                onTap: () => onPhotoTap(
                                  gallery[3]['title']!,
                                  gallery[3]['image']!,
                                  gallery[3]['caption']!,
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: _GalleryItemCard(
                                title: gallery[4]['title']!,
                                imagePath: gallery[4]['image']!,
                                tag: gallery[4]['tag']!,
                                height: 320,
                                onTap: () => onPhotoTap(
                                  gallery[4]['title']!,
                                  gallery[4]['image']!,
                                  gallery[4]['caption']!,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      children: gallery.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _GalleryItemCard(
                            title: item['title']!,
                            imagePath: item['image']!,
                            tag: item['tag']!,
                            height: 280,
                            onTap: () => onPhotoTap(
                              item['title']!,
                              item['image']!,
                              item['caption']!,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GalleryItemCard extends StatefulWidget {
  final String title;
  final String imagePath;
  final String tag;
  final double height;
  final VoidCallback onTap;

  const _GalleryItemCard({
    required this.title,
    required this.imagePath,
    required this.tag,
    required this.height,
    required this.onTap,
  });

  @override
  State<_GalleryItemCard> createState() => _GalleryItemCardState();
}

class _GalleryItemCardState extends State<_GalleryItemCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? AppTheme.accentAmber.withOpacity(0.6)
                  : Colors.white.withOpacity(0.08),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppTheme.accentAmber.withOpacity(0.2)
                    : Colors.black.withOpacity(0.4),
                blurRadius: _isHovered ? 25 : 12,
                offset: Offset(0, _isHovered ? 8 : 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Photo with subtle zoom simulation
              Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
              ),

              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.85),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.3, 0.6, 1.0],
                  ),
                ),
              ),

              // Tag Pill Top Left
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppTheme.accentAmber.withOpacity(0.5),
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    widget.tag,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.accentAmber,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),

              // Expand Icon Top Right
              Positioned(
                top: 16,
                right: 16,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isHovered ? 1.0 : 0.6,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.fullscreen_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),

              // Title Bottom
              Positioned(
                bottom: 18,
                left: 18,
                right: 18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.outfit(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Tap to inspect photo',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.accentGold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 12,
                          color: AppTheme.accentGold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
