import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/review_model.dart';
import '../theme/app_theme.dart';
import 'write_review_dialog.dart';

class DrypReviewsSection extends StatefulWidget {
  final List<CustomerReview> reviews;
  final Function(CustomerReview) onReviewAdded;

  const DrypReviewsSection({
    super.key,
    required this.reviews,
    required this.onReviewAdded,
  });

  @override
  State<DrypReviewsSection> createState() => _DrypReviewsSectionState();
}

class _DrypReviewsSectionState extends State<DrypReviewsSection> {
  String _selectedFilter = 'All';

  final List<String> _filters = [
    'All',
    '5 Stars Only',
    'Coffee & Brews',
    'Bakery & Sweets',
    'Vibe & Atmosphere',
  ];

  void _openGoogleMaps() async {
    final uri = Uri.parse('https://maps.google.com/?q=DRYP+Coffee+%26+Craft');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _openWriteReviewModal() {
    showDialog(
      context: context,
      builder: (context) => WriteReviewDialog(
        onReviewSubmitted: (newReview) {
          widget.onReviewAdded(newReview);
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 980;

    final filteredReviews = widget.reviews.where((r) {
      if (_selectedFilter == 'All') return true;
      if (_selectedFilter == '5 Stars Only') return r.rating >= 4.9;
      return r.category == _selectedFilter;
    }).toList();

    return Container(
      width: double.infinity,
      color: AppTheme.bgDark,
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
              // Google Branding Pill
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.bgCardElevated,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.googleBlue.withOpacity(0.4),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const _GoogleSmallGLogo(),
                        const SizedBox(width: 8),
                        Text(
                          'GOOGLE VERIFIED CUSTOMER REVIEWS',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            color: AppTheme.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Title and Review Summary Score Card
              isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left: Headlines
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Loved by Coffee Connoisseurs & Midnight Vibes',
                                style: GoogleFonts.outfit(
                                  fontSize: 38,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.textLight,
                                  letterSpacing: -0.5,
                                  height: 1.15,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'Read genuine feedback from guests who visited DRYP Coffee & Craft on Police Station Road. Every sip and bite, rated with passion.',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 15,
                                  color: AppTheme.textMuted,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 40),
                        // Right: Google Score Banner
                        Expanded(
                          flex: 2,
                          child: _buildGoogleScoreWidget(isDesktop),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Loved by Coffee Connoisseurs & Midnight Vibes',
                          style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textLight,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Read genuine feedback from guests who visited DRYP Coffee & Craft on Police Station Road.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            color: AppTheme.textMuted,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildGoogleScoreWidget(isDesktop),
                      ],
                    ),

              const SizedBox(height: 40),

              // Filter Chips & Write Review Button Row
              Wrap(
                spacing: 12,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ..._filters.map((f) {
                    final isSel = _selectedFilter == f;
                    return ChoiceChip(
                      label: Text(f),
                      selected: isSel,
                      onSelected: (val) {
                        if (val) setState(() => _selectedFilter = f);
                      },
                      selectedColor: AppTheme.accentAmber,
                      backgroundColor: AppTheme.bgCard,
                      labelStyle: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                        color: isSel ? Colors.black : AppTheme.textLight.withOpacity(0.85),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide(
                          color: isSel
                              ? AppTheme.accentAmber
                              : Colors.white.withOpacity(0.08),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(width: 10),

                  // Button to trigger Write Review modal
                  ElevatedButton.icon(
                    onPressed: _openWriteReviewModal,
                    icon: const Icon(Icons.edit_note_rounded, size: 18),
                    label: Text(
                      'Leave a Review',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentAmber,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),

                  // Button to view directly on Google Maps
                  OutlinedButton.icon(
                    onPressed: _openGoogleMaps,
                    icon: const Icon(Icons.open_in_new_rounded, size: 14),
                    label: Text(
                      'View on Google Maps',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.textLight,
                      side: BorderSide(color: Colors.white.withOpacity(0.15)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              // Reviews Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 950
                      ? 3
                      : constraints.maxWidth > 640
                          ? 2
                          : 1;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredReviews.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: crossAxisCount == 1 ? 1.35 : 0.98,
                    ),
                    itemBuilder: (context, index) {
                      final rev = filteredReviews[index];
                      return _CustomerReviewCard(
                        review: rev,
                        onLikeToggle: () {
                          setState(() {
                            if (rev.isLiked) {
                              rev.likesCount--;
                              rev.isLiked = false;
                            } else {
                              rev.likesCount++;
                              rev.isLiked = true;
                            }
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleScoreWidget(bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const _GoogleSmallGLogo(),
                  const SizedBox(width: 10),
                  Text(
                    'Google Rating',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.googleGreen.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.googleGreen.withOpacity(0.4),
                  ),
                ),
                child: Text(
                  'EXCELLENT',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.googleGreen,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '4.9',
                style: GoogleFonts.outfit(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.textLight,
                  height: 1,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star_rounded,
                        color: AppTheme.starGold,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Based on 348 Google Reviews',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: AppTheme.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Rating Breakdown
          _buildRatingBar('5 Stars', 0.94, '94%'),
          const SizedBox(height: 6),
          _buildRatingBar('4 Stars', 0.05, '5%'),
          const SizedBox(height: 6),
          _buildRatingBar('3 Stars', 0.01, '1%'),
        ],
      ),
    );
  }

  Widget _buildRatingBar(String label, double fill, String percentage) {
    return Row(
      children: [
        SizedBox(
          width: 52,
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              color: AppTheme.textMuted,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fill,
              minHeight: 6,
              backgroundColor: Colors.white.withOpacity(0.08),
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accentAmber),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 28,
          child: Text(
            percentage,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.textMuted,
            ),
          ),
        ),
      ],
    );
  }
}

class _CustomerReviewCard extends StatelessWidget {
  final CustomerReview review;
  final VoidCallback onLikeToggle;

  const _CustomerReviewCard({
    required this.review,
    required this.onLikeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User info header
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: review.avatarColor,
                    child: Text(
                      review.initials,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                review.authorName,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textLight,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.verified_rounded,
                              size: 14,
                              color: AppTheme.googleBlue,
                            ),
                          ],
                        ),
                        Text(
                          review.userBadge,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Star Rating and Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (i) => const Icon(
                        Icons.star_rounded,
                        color: AppTheme.starGold,
                        size: 16,
                      ),
                    ),
                  ),
                  Text(
                    review.dateAgo,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      color: AppTheme.textSubtle,
                    ),
                  ),
                ],
              ),

              if (review.highlights != null) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppTheme.accentAmber.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.accentAmber.withOpacity(0.25),
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    review.highlights!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.accentAmber,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 12),

              // Comment text
              Text(
                review.comment,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: AppTheme.textLight.withOpacity(0.85),
                  height: 1.55,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          // Footer: Category chip & Helpful button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  review.category,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    color: AppTheme.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              InkWell(
                onTap: onLikeToggle,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        review.isLiked
                            ? Icons.thumb_up_rounded
                            : Icons.thumb_up_alt_outlined,
                        size: 13,
                        color: review.isLiked
                            ? AppTheme.accentAmber
                            : AppTheme.textMuted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${review.likesCount}',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: review.isLiked
                              ? AppTheme.accentAmber
                              : AppTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GoogleSmallGLogo extends StatelessWidget {
  const _GoogleSmallGLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Text(
        'G',
        style: GoogleFonts.outfit(
          fontSize: 15,
          fontWeight: FontWeight.w900,
          color: const Color(0xFF4285F4),
          height: 1.0,
        ),
      ),
    );
  }
}
