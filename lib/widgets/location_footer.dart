import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class DrypLocationFooter extends StatelessWidget {
  final VoidCallback onWriteReviewClick;

  const DrypLocationFooter({
    super.key,
    required this.onWriteReviewClick,
  });

  void _openDirections() async {
    final uri = Uri.parse('https://maps.google.com/?q=DRYP+Coffee+%26+Craft+Police+Station+Road');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 980;

    return Container(
      width: double.infinity,
      color: AppTheme.bgCardElevated,
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
              // Visit Us Header Card
              Container(
                padding: EdgeInsets.all(isDesktop ? 40 : 24),
                decoration: BoxDecoration(
                  color: AppTheme.bgDark,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppTheme.accentAmber.withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: isDesktop
                    ? Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: _buildLocationInfo(),
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            flex: 5,
                            child: _buildVisitActions(),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLocationInfo(),
                          const SizedBox(height: 32),
                          _buildVisitActions(),
                        ],
                      ),
              ),

              const SizedBox(height: 60),

              // Bottom Brand & Copyright Bar
              isDesktop
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildBrandIdentity(),
                        _buildFooterLinks(),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBrandIdentity(),
                        const SizedBox(height: 24),
                        _buildFooterLinks(),
                      ],
                    ),

              const SizedBox(height: 40),
              const Divider(color: Colors.white12),
              const SizedBox(height: 24),

              // Copyright
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 10,
                children: [
                  Text(
                    '© 2026 DRYP Coffee & Craft. All rights reserved.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: AppTheme.textSubtle,
                    ),
                  ),
                  Text(
                    'Mix it. Sip it. DRYP.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.accentAmber,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.bgCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.accentAmber.withOpacity(0.4),
            ),
          ),
          child: Text(
            'VISIT DRYP TODAY',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: AppTheme.accentAmber,
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Your Neighborhood Midnight Sanctuary',
          style: GoogleFonts.outfit(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: AppTheme.textLight,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Whether you crave a slow V60 pour-over, our layered iced tiramisu drink, or hot caramel brownies straight from our ovens – we have a warm table waiting for you.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: AppTheme.textMuted,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildVisitActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          Icons.place_rounded,
          'Address',
          '918-B Police Station Road',
        ),
        const SizedBox(height: 16),
        _buildInfoRow(
          Icons.access_time_filled_rounded,
          'Opening Hours',
          '4:00 PM – 12:00 AM (Monday to Sunday)',
        ),
        const SizedBox(height: 16),
        _buildInfoRow(
          Icons.celebration_rounded,
          'Weekend Specials',
          'Cinnamon Rolls & Triple Choc Cookies',
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            ElevatedButton.icon(
              onPressed: _openDirections,
              icon: const Icon(Icons.directions_rounded, size: 16),
              label: Text(
                'Get Directions',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentAmber,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: onWriteReviewClick,
              icon: const Icon(Icons.rate_review_rounded, size: 16),
              label: Text(
                'Leave Google Review',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.textLight,
                side: BorderSide(color: Colors.white.withOpacity(0.2)),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.accentAmber.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.accentAmber, size: 18),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSubtle,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.textLight,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBrandIdentity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.accentAmber, AppTheme.accentCaramel],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.coffee_rounded, color: Colors.black, size: 18),
            ),
            const SizedBox(width: 12),
            Text(
              'DRYP COFFEE & CRAFT',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
                color: AppTheme.textLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Specialty coffee, custom neon ambiance, and artisan fresh bakes.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            color: AppTheme.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLinks() {
    return Row(
      children: [
        _buildSocialPill('Google Maps', Icons.map_rounded, _openDirections),
        const SizedBox(width: 12),
        _buildSocialPill('Review Us', Icons.star_rounded, onWriteReviewClick),
      ],
    );
  }

  Widget _buildSocialPill(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.bgDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: AppTheme.accentAmber),
            const SizedBox(width: 6),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
