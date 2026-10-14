import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class DrypStorySection extends StatelessWidget {
  const DrypStorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 980;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 24,
        vertical: 80,
      ),
      color: AppTheme.bgCard,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1240),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Header Pill
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
                  'OUR PHILOSOPHY & CRAFT',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    color: AppTheme.accentAmber,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Title & Subtitle Row
              isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Born from an obsession with great coffee and authentic space.',
                            style: GoogleFonts.outfit(
                              fontSize: 38,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textLight,
                              height: 1.18,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'We set out to create a warm sanctuary where precision extraction meets relaxed nighttime culture.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              color: AppTheme.textMuted,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Born from an obsession with great coffee and authentic space.',
                          style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textLight,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'We set out to create a warm sanctuary where precision extraction meets relaxed nighttime culture.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            color: AppTheme.textMuted,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),

              const SizedBox(height: 50),

              // Two Showcase Columns with Real Photos
              isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildStoryCard(
                            imagePath: 'assets/images/dryp_bar_counter.jpg',
                            title: 'The Signature Neon Bar',
                            badge: 'Barista Counter',
                            description:
                                'Illuminated by our custom glowing curved neon light, the barista bar features high-pressure espresso extraction, dedicated syrup crafting, and daily weekend special announcements.',
                            tagline: 'Precision In Every Pull',
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: _buildStoryCard(
                            imagePath: 'assets/images/dryp_storefront_day.jpg',
                            title: 'Lush Foliage & Warm Facade',
                            badge: 'Exterior & Patio',
                            description:
                                'Surrounded by organic greenery and rustic wood paneling on Police Station Road. The welcoming glass facade invites morning light and transforms into an illuminated nighttime sanctuary.',
                            tagline: 'Come for Coffee, Stay for Vibe',
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _buildStoryCard(
                          imagePath: 'assets/images/dryp_bar_counter.jpg',
                          title: 'The Signature Neon Bar',
                          badge: 'Barista Counter',
                          description:
                              'Illuminated by our custom glowing curved neon light, the barista bar features high-pressure espresso extraction, dedicated syrup crafting, and daily weekend special announcements.',
                          tagline: 'Precision In Every Pull',
                        ),
                        const SizedBox(height: 24),
                        _buildStoryCard(
                          imagePath: 'assets/images/dryp_storefront_day.jpg',
                          title: 'Lush Foliage & Warm Facade',
                          badge: 'Exterior & Patio',
                          description:
                              'Surrounded by organic greenery and rustic wood paneling on Police Station Road. The welcoming glass facade invites morning light and transforms into an illuminated nighttime sanctuary.',
                          tagline: 'Come for Coffee, Stay for Vibe',
                        ),
                      ],
                    ),

              const SizedBox(height: 50),

              // Four Stat Pillars
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                decoration: BoxDecoration(
                  color: AppTheme.bgDark,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.06),
                    width: 1,
                  ),
                ),
                child: isDesktop
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('4.9 ★', 'Google Rating (340+ Reviews)'),
                          _buildDivider(),
                          _buildStatItem('100%', 'Specialty Grade Arabica'),
                          _buildDivider(),
                          _buildStatItem('Daily', 'Fresh Oven-Baked Pastries'),
                          _buildDivider(),
                          _buildStatItem('4 PM - 12 AM', 'Open Till Midnight'),
                        ],
                      )
                    : Column(
                        children: [
                          _buildStatItem('4.9 ★', 'Google Rating (340+ Reviews)'),
                          const SizedBox(height: 20),
                          _buildStatItem('100%', 'Specialty Grade Arabica'),
                          const SizedBox(height: 20),
                          _buildStatItem('Daily', 'Fresh Oven-Baked Pastries'),
                          const SizedBox(height: 20),
                          _buildStatItem('4 PM - 12 AM', 'Open Till Midnight'),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoryCard({
    required String imagePath,
    required String title,
    required String badge,
    required String description,
    required String tagline,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.bgDark,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Badge
          Stack(
            children: [
              SizedBox(
                height: 320,
                width: double.infinity,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppTheme.accentAmber.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    badge,
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

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tagline,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: AppTheme.accentAmber,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textLight,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: AppTheme.textMuted,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppTheme.accentAmber,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            color: AppTheme.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.white.withOpacity(0.1),
    );
  }
}
