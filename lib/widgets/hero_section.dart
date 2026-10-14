import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class DrypHeroSection extends StatefulWidget {
  final VoidCallback onMenuClick;
  final VoidCallback onReviewsClick;
  final VoidCallback onStoryClick;

  const DrypHeroSection({
    super.key,
    required this.onMenuClick,
    required this.onReviewsClick,
    required this.onStoryClick,
  });

  @override
  State<DrypHeroSection> createState() => _DrypHeroSectionState();
}

class _DrypHeroSectionState extends State<DrypHeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 980;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 700),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 24,
        vertical: isDesktop ? 70 : 40,
      ),
      child: Stack(
        children: [
          // Ambient Glow in background
          Positioned(
            top: -50,
            left: isDesktop ? 200 : 50,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.accentAmber.withOpacity(0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left Column: Text & CTAs
                        Expanded(
                          flex: 11,
                          child: _buildHeroContent(context, isDesktop),
                        ),
                        const SizedBox(width: 50),
                        // Right Column: Authentic Image Collage
                        Expanded(
                          flex: 11,
                          child: _buildHeroVisuals(context, isDesktop),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeroContent(context, isDesktop),
                        const SizedBox(height: 40),
                        _buildHeroVisuals(context, isDesktop),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroContent(BuildContext context, bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Top Pill Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.bgCardElevated,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppTheme.accentAmber.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppTheme.accentAmber,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'ARTISANAL SPECIALTY COFFEE & BAKERY',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: AppTheme.accentAmber,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Bold Editorial Headline
        Text(
          'Mix it. Sip it.\nDRYP.',
          style: GoogleFonts.outfit(
            fontSize: isDesktop ? 64 : 44,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.5,
            height: 1.05,
            color: AppTheme.textLight,
          ),
        ),

        const SizedBox(height: 16),

        Text(
          'Come for the coffee, stay for the vibe.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: isDesktop ? 22 : 18,
            fontWeight: FontWeight.w600,
            color: AppTheme.accentGold,
            letterSpacing: -0.3,
          ),
        ),

        const SizedBox(height: 18),

        Text(
          'Experience slow-steeped iced tiramisu brews, silky artisan flat whites, and oven-fresh brownies under our signature curved neon glow. Handcrafted everyday on Police Station Road.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppTheme.textMuted,
            height: 1.65,
          ),
        ),

        const SizedBox(height: 32),

        // CTA Buttons Row
        Wrap(
          spacing: 16,
          runSpacing: 14,
          children: [
            ElevatedButton(
              onPressed: widget.onMenuClick,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentAmber,
                foregroundColor: Colors.black,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Explore Craft Menu',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),

            OutlinedButton(
              onPressed: widget.onReviewsClick,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.textLight,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                side: BorderSide(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star_rounded, color: AppTheme.starGold, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Google Reviews (4.9 ★)',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 36),

        // Quick Highlights Row
        Wrap(
          spacing: 24,
          runSpacing: 12,
          children: [
            _buildFeaturePill(Icons.access_time_rounded, 'Open 4:00 PM – 12:00 AM Daily'),
            _buildFeaturePill(Icons.local_fire_department_rounded, 'Fresh Weekend Bakes'),
            _buildFeaturePill(Icons.verified_rounded, '100% Specialty Arabica'),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturePill(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppTheme.accentAmber, size: 16),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppTheme.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroVisuals(BuildContext context, bool isDesktop) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: isDesktop ? 540 : 420,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Main Featured Image: Plated Coffee Tray with Latte Art & Tiramisu Drink
          Container(
            width: isDesktop ? 440 : double.infinity,
            height: isDesktop ? 480 : 380,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
                BoxShadow(
                  color: AppTheme.accentAmber.withOpacity(0.15),
                  blurRadius: 40,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(
                color: Colors.white.withOpacity(0.12),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Image.asset(
                'assets/images/dryp_coffee_tray.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Floating Badge Top Right: Evening Storefront Preview
          if (isDesktop)
            Positioned(
              top: -20,
              right: -10,
              child: Container(
                width: 180,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppTheme.accentAmber.withOpacity(0.5),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.7),
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/dryp_storefront_night.jpg',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.85),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        left: 12,
                        right: 12,
                        child: Text(
                          'Night Ambiance\nOutdoor Seating',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Floating Badge Bottom Left: Real Google Review Score Card
          Positioned(
            bottom: -15,
            left: isDesktop ? -20 : 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: AppTheme.bgCardElevated,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppTheme.accentAmber.withOpacity(0.3),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'G',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF4285F4),
                        height: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (index) => const Icon(
                              Icons.star_rounded,
                              color: AppTheme.starGold,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '4.9',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textLight,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '340+ Verified Google Reviews',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
