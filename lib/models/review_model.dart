import 'package:flutter/material.dart';

class CustomerReview {
  final String id;
  final String authorName;
  final String initials;
  final Color avatarColor;
  final double rating;
  final String dateAgo;
  final String userBadge;
  final String category;
  final String comment;
  int likesCount;
  bool isLiked;
  final bool isVerified;
  final String? highlights;

  CustomerReview({
    required this.id,
    required this.authorName,
    required this.initials,
    required this.avatarColor,
    required this.rating,
    required this.dateAgo,
    required this.userBadge,
    required this.category,
    required this.comment,
    this.likesCount = 0,
    this.isLiked = false,
    this.isVerified = true,
    this.highlights,
  });

  static List<CustomerReview> getSampleReviews() {
    return [
      CustomerReview(
        id: 'rev_1',
        authorName: 'Hamza Khan',
        initials: 'HK',
        avatarColor: const Color(0xFFE57373),
        rating: 5.0,
        dateAgo: '3 days ago',
        userBadge: 'Local Guide • 48 reviews',
        category: 'Coffee & Brews',
        comment:
            'Hands down the best specialty coffee experience! That signature iced tiramisu drink topped with the ladyfinger biscuit is an absolute masterpiece. The curly neon light above the bar gives it a late-night Tokyo aesthetic. Staff is passionate about extraction ratios.',
        likesCount: 24,
        isVerified: true,
        highlights: 'Iced Tiramisu Brew, Aesthetic Bar',
      ),
      CustomerReview(
        id: 'rev_2',
        authorName: 'Ayesha Noor',
        initials: 'AN',
        avatarColor: const Color(0xFFBA68C8),
        rating: 5.0,
        dateAgo: '1 week ago',
        userBadge: 'Verified Customer',
        category: 'Bakery & Sweets',
        comment:
            'Their bakery display alone will make you drool! We got the caramel drizzle brownie and the chocolate chunk sea-salt cookies. Both were fresh, warm, and rich. You can smell the freshly baked batches from outside.',
        likesCount: 19,
        isVerified: true,
        highlights: 'Caramel Brownies, Fresh Cookies',
      ),
      CustomerReview(
        id: 'rev_3',
        authorName: 'Zaid Tariq',
        initials: 'ZT',
        avatarColor: const Color(0xFF4DB6AC),
        rating: 5.0,
        dateAgo: '2 weeks ago',
        userBadge: 'Local Guide • 112 reviews',
        category: 'Vibe & Atmosphere',
        comment:
            '"Come for coffee, stay for the vibe" – that chalkboard sign isn\'t exaggerating! The night outdoor seating under the lush green wall is top tier. Open till midnight which makes it the premier spot for late evening conversations with great pour-overs.',
        likesCount: 31,
        isVerified: true,
        highlights: 'Evening Outdoor Seating, Open till Midnight',
      ),
      CustomerReview(
        id: 'rev_4',
        authorName: 'Maham Siddiqui',
        initials: 'MS',
        avatarColor: const Color(0xFFFFB74D),
        rating: 5.0,
        dateAgo: '3 weeks ago',
        userBadge: 'Verified Customer',
        category: 'Coffee & Brews',
        comment:
            'Ordered a hot flat white and the latte art was pristine. Velvet texture microfoam, zero bitterness, subtle chocolatey notes. Also grabbed a weekend cinnamon roll – warm, buttery, and packed with Ceylon cinnamon.',
        likesCount: 15,
        isVerified: true,
        highlights: 'Latte Art, Weekend Cinnamon Roll',
      ),
      CustomerReview(
        id: 'rev_5',
        authorName: 'Bilal Ahmed',
        initials: 'BA',
        avatarColor: const Color(0xFF81C784),
        rating: 5.0,
        dateAgo: '1 month ago',
        userBadge: 'Local Guide • 35 reviews',
        category: 'Vibe & Atmosphere',
        comment:
            'Police Station Road really needed a high caliber craft coffee bar. DRYP hits every single mark: custom lighting, calm chill music, warm welcoming baristas, and real craftsmanship in every cup. 10/10 recommendation.',
        likesCount: 28,
        isVerified: true,
        highlights: 'Craftsmanship, Chill Music',
      ),
      CustomerReview(
        id: 'rev_6',
        authorName: 'Sana Fatima',
        initials: 'SF',
        avatarColor: const Color(0xFF64B5F6),
        rating: 4.8,
        dateAgo: '1 month ago',
        userBadge: 'Verified Customer',
        category: 'Bakery & Sweets',
        comment:
            'The Matilda triple chocolate cookie with flaky sea salt is perfection in every bite. Paired with a chilled iced Americano, it was the highlight of our weekend. Super clean and aesthetic cafe.',
        likesCount: 11,
        isVerified: true,
        highlights: 'Matilda Chocolate Cookie, Iced Americano',
      ),
    ];
  }
}
