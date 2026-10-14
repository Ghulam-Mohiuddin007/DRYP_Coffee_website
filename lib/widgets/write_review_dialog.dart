import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/review_model.dart';
import '../theme/app_theme.dart';

class WriteReviewDialog extends StatefulWidget {
  final Function(CustomerReview) onReviewSubmitted;

  const WriteReviewDialog({
    super.key,
    required this.onReviewSubmitted,
  });

  @override
  State<WriteReviewDialog> createState() => _WriteReviewDialogState();
}

class _WriteReviewDialogState extends State<WriteReviewDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();
  int _selectedRating = 5;
  String _selectedCategory = 'Coffee & Brews';
  bool _isSubmitting = false;

  final List<String> _categories = [
    'Coffee & Brews',
    'Bakery & Sweets',
    'Vibe & Atmosphere',
    'Customer Service',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 600));

    final newReview = CustomerReview(
      id: 'rev_${DateTime.now().millisecondsSinceEpoch}',
      authorName: _nameController.text.trim(),
      initials: _getInitials(_nameController.text.trim()),
      avatarColor: AppTheme.accentAmber,
      rating: _selectedRating.toDouble(),
      dateAgo: 'Just now',
      userBadge: 'Verified Google Review',
      category: _selectedCategory,
      comment: _commentController.text.trim(),
      likesCount: 1,
      isLiked: true,
      isVerified: true,
      highlights: 'Customer Experience at DRYP',
    );

    widget.onReviewSubmitted(newReview);
    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppTheme.bgCardElevated,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppTheme.accentAmber),
          ),
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: AppTheme.accentAmber),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Thank you! Your Google review has been submitted and posted.',
                  style: GoogleFonts.plusJakartaSans(
                    color: AppTheme.textLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'CU';
    final parts = name.split(' ');
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.bgCardElevated,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: AppTheme.accentAmber.withOpacity(0.4),
          width: 1.2,
        ),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 540),
        padding: const EdgeInsets.all(28),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Google G Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                          children: [
                            Text(
                              'Write a Google Review',
                              style: GoogleFonts.outfit(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textLight,
                              ),
                            ),
                            Text(
                              'DRYP Coffee & Craft • Police Station Rd',
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

                const SizedBox(height: 24),
                const Divider(color: Colors.white12),
                const SizedBox(height: 20),

                // Star Rating Selector
                Text(
                  'Your Overall Rating',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textLight,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: List.generate(5, (index) {
                    final starNum = index + 1;
                    return InkWell(
                      onTap: () => setState(() => _selectedRating = starNum),
                      borderRadius: BorderRadius.circular(30),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.star_rounded,
                          size: 36,
                          color: starNum <= _selectedRating
                              ? AppTheme.starGold
                              : Colors.white24,
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 22),

                // Name Input
                Text(
                  'Your Name',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textLight,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Please enter your name' : null,
                  style: GoogleFonts.plusJakartaSans(color: AppTheme.textLight),
                  decoration: InputDecoration(
                    hintText: 'e.g. Daniyal Farooq',
                    hintStyle: GoogleFonts.plusJakartaSans(color: AppTheme.textSubtle),
                    filled: true,
                    fillColor: AppTheme.bgDark,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppTheme.accentAmber),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Experience / Review Text
                Text(
                  'What did you like best about DRYP?',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textLight,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _commentController,
                  maxLines: 4,
                  validator: (v) => v == null || v.trim().length < 10
                      ? 'Please share a sentence about your experience (min 10 characters)'
                      : null,
                  style: GoogleFonts.plusJakartaSans(color: AppTheme.textLight),
                  decoration: InputDecoration(
                    hintText:
                        'e.g. Loved the iced tiramisu drink and the fresh caramel brownies! The late night vibe under the neon light was super cozy.',
                    hintStyle: GoogleFonts.plusJakartaSans(color: AppTheme.textSubtle),
                    filled: true,
                    fillColor: AppTheme.bgDark,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppTheme.accentAmber),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Category Tag Selector
                Text(
                  'Category',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textLight,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  children: _categories.map((c) {
                    final isSel = _selectedCategory == c;
                    return ChoiceChip(
                      label: Text(c),
                      selected: isSel,
                      onSelected: (val) {
                        if (val) setState(() => _selectedCategory = c);
                      },
                      selectedColor: AppTheme.accentAmber,
                      backgroundColor: AppTheme.bgDark,
                      labelStyle: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSel ? Colors.black : AppTheme.textMuted,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSel
                              ? AppTheme.accentAmber
                              : Colors.white.withOpacity(0.1),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 28),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentAmber,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.black,
                            ),
                          )
                        : Text(
                            'Post Google Review',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
