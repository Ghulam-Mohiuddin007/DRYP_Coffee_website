import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class DrypNavBar extends StatelessWidget {
  final VoidCallback onStoryClick;
  final VoidCallback onMenuClick;
  final VoidCallback onVibeClick;
  final VoidCallback onReviewsClick;
  final VoidCallback onLocationClick;
  final VoidCallback onWriteReviewClick;
  final VoidCallback onTrayClick;
  final int trayCount;
  final double scrollProgress;

  const DrypNavBar({
    super.key,
    required this.onStoryClick,
    required this.onMenuClick,
    required this.onVibeClick,
    required this.onReviewsClick,
    required this.onLocationClick,
    required this.onWriteReviewClick,
    required this.onTrayClick,
    this.trayCount = 0,
    this.scrollProgress = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final isScrolled = scrollProgress > 40;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: isScrolled ? 14 : 6, sigmaY: isScrolled ? 14 : 6),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 40 : 20,
            vertical: isScrolled ? 12 : 20,
          ),
          decoration: BoxDecoration(
            color: isScrolled
                ? AppTheme.bgDark.withOpacity(0.88)
                : AppTheme.bgDark.withOpacity(0.45),
            border: Border(
              bottom: BorderSide(
                color: isScrolled
                    ? Colors.white.withOpacity(0.08)
                    : Colors.transparent,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              // Brand Logo & Subtitle
              InkWell(
                onTap: onStoryClick,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.accentAmber, AppTheme.accentCaramel],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.accentAmber.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.coffee_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'DRYP',
                          style: GoogleFonts.outfit(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 3,
                            color: AppTheme.textLight,
                          ),
                        ),
                        Text(
                          'COFFEE & CRAFT',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                            color: AppTheme.accentAmber,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Desktop Navigation Links
              if (isDesktop) ...[
                _NavLink(title: 'Our Story', onTap: onStoryClick),
                const SizedBox(width: 24),
                _NavLink(title: 'Craft Menu', onTap: onMenuClick),
                const SizedBox(width: 24),
                _NavLink(title: 'Ambiance', onTap: onVibeClick),
                const SizedBox(width: 24),
                _NavLink(
                  title: 'Google Reviews',
                  onTap: onReviewsClick,
                  badge: '4.9 ★',
                ),
                const SizedBox(width: 24),
                _NavLink(title: 'Visit Us', onTap: onLocationClick),
                const SizedBox(width: 28),
              ],

              // Google Rating Pill Badge
              InkWell(
                onTap: onReviewsClick,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.bgCardElevated,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: AppTheme.accentAmber.withOpacity(0.35),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Google 'G' Icon Colors representation
                      const _GoogleMiniIcon(),
                      const SizedBox(width: 8),
                      const Icon(Icons.star_rounded, color: AppTheme.starGold, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '4.9',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textLight,
                        ),
                      ),
                      if (isDesktop) ...[
                        const SizedBox(width: 4),
                        Text(
                          '(340+)',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // "Write Review" Action Button
              ElevatedButton.icon(
                onPressed: onWriteReviewClick,
                icon: const Icon(Icons.rate_review_outlined, size: 16),
                label: Text(
                  isDesktop ? 'Review Us' : 'Review',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentAmber,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 18 : 12,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Order Tray Button
              InkWell(
                onTap: onTrayClick,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 16 : 10,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: trayCount > 0
                        ? AppTheme.accentAmber.withOpacity(0.18)
                        : Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: trayCount > 0
                          ? AppTheme.accentAmber
                          : Colors.white.withOpacity(0.12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 16,
                        color: trayCount > 0
                            ? AppTheme.accentAmber
                            : AppTheme.textLight,
                      ),
                      if (trayCount > 0) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.accentAmber,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$trayCount',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                      if (isDesktop && trayCount == 0) ...[
                        const SizedBox(width: 6),
                        Text(
                          'Tray',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textLight,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final String? badge;

  const _NavLink({
    required this.title,
    required this.onTap,
    this.badge,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
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
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                  color: _isHovered ? AppTheme.accentAmber : AppTheme.textLight.withOpacity(0.85),
                ),
              ),
              if (widget.badge != null) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.accentAmber.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppTheme.accentAmber.withOpacity(0.4),
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    widget.badge!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.accentAmber,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _GoogleMiniIcon extends StatelessWidget {
  const _GoogleMiniIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(
        'G',
        style: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF4285F4),
          height: 1.1,
        ),
      ),
    );
  }
}
