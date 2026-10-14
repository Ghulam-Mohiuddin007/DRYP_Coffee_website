class CraftMenuItem {
  final String id;
  final String title;
  final String category;
  final int rawPrice;
  final String description;
  final String imagePath;
  final bool isNetwork;
  final String? badge;
  final List<String> tags;
  final bool isSpecialty;

  String get price => 'Rs. $rawPrice';

  const CraftMenuItem({
    required this.id,
    required this.title,
    required this.category,
    required this.rawPrice,
    required this.description,
    required this.imagePath,
    this.isNetwork = false,
    this.badge,
    required this.tags,
    this.isSpecialty = true,
  });

  static List<CraftMenuItem> getMenuItems() {
    return const [
      // ================= DRYP SIGNATURE ICED BREWS =================
      CraftMenuItem(
        id: 'ice_tiramisu',
        title: 'Tiramisu Iced Latte',
        category: 'Iced Brews',
        rawPrice: 900,
        description:
            'Slow-steeped cold brew layered with whipped Italian mascarpone cream, dark cocoa dusting, and topped with a crisp Savoiardi ladyfinger biscuit.',
        imagePath: 'assets/images/dryp_coffee_tray.jpg',
        isNetwork: false,
        badge: 'Signature DRYP',
        tags: ['Mascarpone Cream', 'Ladyfinger Biscuit', 'Cold Brew', 'Cocoa'],
      ),
      CraftMenuItem(
        id: 'ice_red_velvet',
        title: 'Red Velvet Iced Latte',
        category: 'Iced Brews',
        rawPrice: 850,
        description:
            'Espresso layered with smooth cocoa-infused red velvet essence, chilled textured milk, and white chocolate foam.',
        imagePath: 'https://images.unsplash.com/photo-1534778101976-62847782c213?w=800&q=80',
        isNetwork: true,
        badge: 'Crowd Favorite',
        tags: ['Red Velvet', 'White Chocolate Foam', 'Double Shot'],
      ),
      CraftMenuItem(
        id: 'ice_hazel_pistachio',
        title: 'Hazelnut Pistachio Iced Latte',
        category: 'Iced Brews',
        rawPrice: 850,
        description:
            'House roasted espresso poured over nutty Sicilian pistachio puree, roasted hazelnut syrup, and chilled velvety milk.',
        imagePath: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=800&q=80',
        isNetwork: true,
        badge: 'Chef Special',
        tags: ['Pistachio Puree', 'Roasted Hazelnut', 'Creamy'],
      ),
      CraftMenuItem(
        id: 'ice_popcorn',
        title: 'Popcorn Iced Latte',
        category: 'Iced Brews',
        rawPrice: 800,
        description:
            'Toasty caramelized popcorn syrup infused with rich espresso, iced milk, and finished with salted caramel drizzle and crunchy popcorn.',
        imagePath: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=800&q=80',
        isNetwork: true,
        tags: ['Caramel Popcorn', 'Sweet & Savory', 'Espresso'],
      ),
      CraftMenuItem(
        id: 'ice_spiced_banana',
        title: 'Spiced Banana Latte',
        category: 'Iced Brews',
        rawPrice: 900,
        description:
            'Sweet caramelized banana reduction dusted with aromatic Ceylon cinnamon and nutmeg, blended with double espresso over ice.',
        imagePath: 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=800&q=80',
        isNetwork: true,
        badge: 'New Arrival',
        tags: ['Banana Reduction', 'Ceylon Spices', 'Double Shot'],
      ),
      CraftMenuItem(
        id: 'ice_blueberry_pancake',
        title: 'Blueberry Pancake Latte',
        category: 'Iced Brews',
        rawPrice: 900,
        description:
            'Artisanal wild blueberry coulis folded with warm maple notes and dark espresso, served over crushed crystal ice.',
        imagePath: 'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=800&q=80',
        isNetwork: true,
        tags: ['Wild Blueberry', 'Maple Syrup', 'Craft Cold Foam'],
      ),
      CraftMenuItem(
        id: 'ice_spanish',
        title: 'Spanish Iced Latte',
        category: 'Iced Brews',
        rawPrice: 750,
        description:
            'The beloved classic: sweet caramelized condensed milk balanced against bold double ristretto and chilled textured dairy.',
        imagePath: 'https://images.unsplash.com/photo-1517256064527-09c73fc73e38?w=800&q=80',
        isNetwork: true,
        badge: 'Best Seller',
        tags: ['Condensed Milk', 'Double Ristretto', 'Sweet & Bold'],
      ),
      CraftMenuItem(
        id: 'ice_caramel',
        title: 'Caramel Iced Latte',
        category: 'Iced Brews',
        rawPrice: 750,
        description:
            'Golden caramel ribbon swirled with espresso and cold milk, topped with a velvety cold foam and sea salt caramel drizzle.',
        imagePath: 'https://images.unsplash.com/photo-1559496417-e7f25cb247f3?w=800&q=80',
        isNetwork: true,
        tags: ['Salted Caramel', 'Silky Milk', 'Espresso'],
      ),
      CraftMenuItem(
        id: 'ice_vanilla',
        title: 'Vanilla Iced Latte',
        category: 'Iced Brews',
        rawPrice: 750,
        description:
            'Madagascar vanilla bean syrup combined with smooth chilled milk and freshly pulled espresso.',
        imagePath: 'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=800&q=80',
        isNetwork: true,
        tags: ['Madagascar Vanilla', 'House Espresso', 'Classic'],
      ),
      CraftMenuItem(
        id: 'ice_hazelnut',
        title: 'Hazelnut Iced Latte',
        category: 'Iced Brews',
        rawPrice: 750,
        description:
            'Nutty roasted hazelnut notes harmonize with bold espresso and velvety iced milk.',
        imagePath: 'https://images.unsplash.com/photo-1577968897966-3d4325b36b61?w=800&q=80',
        isNetwork: true,
        tags: ['Roasted Hazelnut', 'Smooth', 'Aromatic'],
      ),
      CraftMenuItem(
        id: 'ice_plain_latte',
        title: 'Plain Iced Latte',
        category: 'Iced Brews',
        rawPrice: 600,
        description:
            'Pure double shot specialty espresso over clean cold whole milk and handcrafted ice.',
        imagePath: 'https://images.unsplash.com/photo-1517256064527-09c73fc73e38?w=800&q=80',
        isNetwork: true,
        tags: ['Clean Milk', 'Single Origin Espresso', 'Crisp'],
      ),
      CraftMenuItem(
        id: 'ice_americano',
        title: 'Iced Americano',
        category: 'Iced Brews',
        rawPrice: 550,
        description:
            'Double shot of our Colombian specialty espresso pulled over ice and mineral water for pure roast notes.',
        imagePath: 'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=800&q=80',
        isNetwork: true,
        tags: ['Zero Sugar', 'Bold Espresso', 'Refreshing'],
      ),

      // ================= DRYP'D MATCHA =================
      CraftMenuItem(
        id: 'matcha_pinkberry',
        title: 'Pinkberry Matcha',
        category: "DRYP'd Matcha",
        rawPrice: 1000,
        description:
            'Ceremonial Japanese Uji matcha poured over sweet raspberry and pink strawberry cold puree with frothy oat milk.',
        imagePath: 'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=800&q=80',
        isNetwork: true,
        badge: 'Viral Favorite',
        tags: ['Uji Matcha', 'Raspberry Puree', 'Layered Aesthetic'],
      ),
      CraftMenuItem(
        id: 'matcha_strawberry_coconut',
        title: 'Strawberry Coconut Matcha',
        category: "DRYP'd Matcha",
        rawPrice: 1100,
        description:
            'Silky coconut milk base, macerated fresh strawberries, and an emerald green cap of premium ceremonial matcha.',
        imagePath: 'https://images.unsplash.com/photo-1515823662972-da6a2e4d3002?w=800&q=80',
        isNetwork: true,
        badge: 'House Specialty',
        tags: ['Coconut Cream', 'Fresh Strawberries', 'Uji Matcha'],
      ),
      CraftMenuItem(
        id: 'matcha_strawberry',
        title: 'Strawberry Matcha',
        category: "DRYP'd Matcha",
        rawPrice: 1000,
        description:
            'Freshly smashed strawberry compote topped with iced oat milk and whisked ceremonial green tea.',
        imagePath: 'https://images.unsplash.com/photo-1576092768241-dec231879fc3?w=800&q=80',
        isNetwork: true,
        tags: ['Strawberry Puree', 'Ceremonial Matcha', 'Layered'],
      ),
      CraftMenuItem(
        id: 'matcha_mango',
        title: 'Mango Matcha',
        category: "DRYP'd Matcha",
        rawPrice: 1000,
        description:
            'Tropical sweet Chaunsa mango pulp paired with earthy ceremonial green tea and iced whole milk.',
        imagePath: 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=800&q=80',
        isNetwork: true,
        tags: ['Sweet Mango', 'Earthy Matcha', 'Tropical'],
      ),

      // ================= DRYP HOT BREWS & CLASSICS =================
      CraftMenuItem(
        id: 'hot_tiramisu',
        title: 'Tiramisu Hot Latte',
        category: 'Hot Brews',
        rawPrice: 650,
        description:
            'Warm velvety espresso folded with steamed mascarpone cream foam, Dutch cocoa dust, and vanilla essence.',
        imagePath: 'assets/images/dryp_signature_latte.jpg',
        isNetwork: false,
        badge: 'Winter Comfort',
        tags: ['Mascarpone Foam', 'Latte Art', 'Dutch Cocoa'],
      ),
      CraftMenuItem(
        id: 'hot_pistachio',
        title: 'Pistachio Hot Latte',
        category: 'Hot Brews',
        rawPrice: 700,
        description:
            'Creamy pistachio sauce steamed with silky microfoam and espresso, topped with crushed green pistachios.',
        imagePath: 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=800&q=80',
        isNetwork: true,
        tags: ['Pistachio Crunch', 'Silky Microfoam', 'Specialty'],
      ),
      CraftMenuItem(
        id: 'hot_spanish',
        title: 'Spanish Hot Latte',
        category: 'Hot Brews',
        rawPrice: 600,
        description:
            'Rich condensed milk steamed with whole milk and folded into a hot double ristretto shot.',
        imagePath: 'https://images.unsplash.com/photo-1585494156145-1c60a4fe9d2b?w=800&q=80',
        isNetwork: true,
        tags: ['Condensed Milk', 'Smooth Sweetness', 'Warm Microfoam'],
      ),
      CraftMenuItem(
        id: 'hot_caramel',
        title: 'Caramel Hot Latte',
        category: 'Hot Brews',
        rawPrice: 650,
        description:
            'Toasted caramel syrup steamed with velvety milk and double espresso with caramel drizzle.',
        imagePath: 'https://images.unsplash.com/photo-1534778101976-62847782c213?w=800&q=80',
        isNetwork: true,
        tags: ['Caramel Drizzle', 'Latte Art', 'Warm'],
      ),
      CraftMenuItem(
        id: 'hot_hazelnut',
        title: 'Hazelnut Hot Latte',
        category: 'Hot Brews',
        rawPrice: 650,
        description:
            'Warm roasted hazelnut warmth paired with specialty double espresso and steamed milk.',
        imagePath: 'https://images.unsplash.com/photo-1577968897966-3d4325b36b61?w=800&q=80',
        isNetwork: true,
        tags: ['Roasted Hazelnut', 'Textured Foam', 'Warm'],
      ),
      CraftMenuItem(
        id: 'hot_cappuccino',
        title: 'Classic Cappuccino',
        category: 'Hot Brews',
        rawPrice: 550,
        description:
            'Equal thirds of robust espresso, steamed milk, and dense glossy foam dusted with dark chocolate.',
        imagePath: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=800&q=80',
        isNetwork: true,
        tags: ['Glossy Foam', 'Chocolate Dust', 'Classic'],
      ),
      CraftMenuItem(
        id: 'hot_chocolate',
        title: 'Signature Hot Chocolate',
        category: 'Hot Brews',
        rawPrice: 550,
        description:
            'Melted Belgian 70% dark chocolate melted into steamed milk with marshmallow cream.',
        imagePath: 'https://images.unsplash.com/photo-1542990253-0d0f5be5f0ed?w=800&q=80',
        isNetwork: true,
        tags: ['Belgian Chocolate', 'Rich & Thick', 'Marshmallow'],
      ),
      CraftMenuItem(
        id: 'hot_americano',
        title: 'Hot Americano',
        category: 'Hot Brews',
        rawPrice: 400,
        description:
            'Long black pulled with double specialty shot over hot filtered spring water.',
        imagePath: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=800&q=80',
        isNetwork: true,
        tags: ['Bold Roast', 'Zero Sugar', 'Pure Coffee'],
      ),

      // ================= SHAKES, FRAPPES & SMOOTHIES =================
      CraftMenuItem(
        id: 'frappe_crunchy_vanilla',
        title: 'Crunchy Vanilla Frappe',
        category: 'Frappes & Shakes',
        rawPrice: 850,
        description:
            'Blended ice cream and vanilla bean frappe topped with whipped cream and crushed waffle crunch.',
        imagePath: 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=800&q=80',
        isNetwork: true,
        badge: 'Bestseller',
        tags: ['Waffle Crunch', 'Whipped Cream', 'Vanilla Bean'],
      ),
      CraftMenuItem(
        id: 'frappe_pistachio',
        title: 'Pistachio Frappe',
        category: 'Frappes & Shakes',
        rawPrice: 850,
        description:
            'Blended Sicilian pistachio paste with whole milk, vanilla cream, and roasted pistachio crumb.',
        imagePath: 'https://images.unsplash.com/photo-1579954115545-a95591f28bfc?w=800&q=80',
        isNetwork: true,
        tags: ['Pistachio', 'Blended Cold', 'Whipped Cream'],
      ),
      CraftMenuItem(
        id: 'frappe_red_velvet',
        title: 'Red Velvet Frappe',
        category: 'Frappes & Shakes',
        rawPrice: 800,
        description:
            'Blended red velvet cake batter, dark chocolate chips, whipped cream, and red velvet crumbs.',
        imagePath: 'https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=800&q=80',
        isNetwork: true,
        tags: ['Red Velvet', 'Chocolate Chips', 'Thick'],
      ),
      CraftMenuItem(
        id: 'frappe_choco_fudge',
        title: 'Chocolate Fudge Frappe',
        category: 'Frappes & Shakes',
        rawPrice: 800,
        description:
            'Decadent dark fudge syrup blended with cold brew, dairy, and chocolate flakes.',
        imagePath: 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=800&q=80',
        isNetwork: true,
        tags: ['Fudge Syrup', 'Chocolate Flakes', 'Cold Brew'],
      ),
      CraftMenuItem(
        id: 'shake_choco_meltdown',
        title: 'Choco Meltdown Shake',
        category: 'Frappes & Shakes',
        rawPrice: 800,
        description:
            'Thick gourmet chocolate gelato blended with molten fudge brownie and milk chocolate drizzle.',
        imagePath: 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=800&q=80',
        isNetwork: true,
        badge: 'Ultimate Decadence',
        tags: ['Chocolate Gelato', 'Brownie Pieces', 'Molten'],
      ),
      CraftMenuItem(
        id: 'shake_banana_oreo',
        title: 'Banana Oreo Spiced Crunch',
        category: 'Frappes & Shakes',
        rawPrice: 850,
        description:
            'Fresh ripe bananas blended with crushed Oreo cookies, cinnamon spice crunch, and vanilla cream.',
        imagePath: 'https://images.unsplash.com/photo-1586985289688-ca3cf47d3e6e?w=800&q=80',
        isNetwork: true,
        tags: ['Oreo Cookies', 'Fresh Banana', 'Spiced Crunch'],
      ),
      CraftMenuItem(
        id: 'shake_strawberry_cheesecake',
        title: 'Strawberry Cheesecake Shake',
        category: 'Frappes & Shakes',
        rawPrice: 800,
        description:
            'Graham cracker crust crumbs, real cream cheese base, and strawberry compote blended thick.',
        imagePath: 'https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=800&q=80',
        isNetwork: true,
        tags: ['Cream Cheese', 'Graham Cracker', 'Strawberry'],
      ),
      CraftMenuItem(
        id: 'smoothie_strawberry',
        title: 'Strawberry Smoothie',
        category: 'Frappes & Shakes',
        rawPrice: 800,
        description:
            '100% real strawberries blended with Greek yogurt and wildflower honey.',
        imagePath: 'https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=800&q=80',
        isNetwork: true,
        tags: ['Real Fruit', 'Greek Yogurt', 'Refreshing'],
      ),
      CraftMenuItem(
        id: 'smoothie_blueberry',
        title: 'Blueberry Smoothie',
        category: 'Frappes & Shakes',
        rawPrice: 800,
        description:
            'Wild dark blueberries blended with creamy yogurt, chia seeds, and ice.',
        imagePath: 'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=800&q=80',
        isNetwork: true,
        tags: ['Antioxidant Rich', 'Wild Blueberries', 'Chia'],
      ),
      CraftMenuItem(
        id: 'smoothie_mango',
        title: 'Mango Smoothie',
        category: 'Frappes & Shakes',
        rawPrice: 800,
        description:
            'Thick golden mango puree blended cold with crushed ice and organic yogurt.',
        imagePath: 'https://images.unsplash.com/photo-1623065422902-30a2d299bbe4?w=800&q=80',
        isNetwork: true,
        tags: ['Pure Mango', 'Chilled', 'Silky'],
      ),
      CraftMenuItem(
        id: 'smoothie_coconut',
        title: 'Coconut Smoothie',
        category: 'Frappes & Shakes',
        rawPrice: 800,
        description:
            'Cream of coconut blended with toasted coconut flakes and sweet milk.',
        imagePath: 'https://images.unsplash.com/photo-1515823662972-da6a2e4d3002?w=800&q=80',
        isNetwork: true,
        tags: ['Coconut Flakes', 'Tropical', 'Creamy'],
      ),

      // ================= CRAFT REFRESHERS & MOCKTAILS =================
      CraftMenuItem(
        id: 'mocktail_watermelon',
        title: 'Watermelon Refresher',
        category: 'Mocktails',
        rawPrice: 400,
        description:
            'Freshly pressed sweet watermelon juice, crushed mint, lime, and sparkling soda over ice.',
        imagePath: 'https://images.unsplash.com/photo-1595981267035-7b04ca84a82d?w=800&q=80',
        isNetwork: true,
        badge: 'Summer Hit',
        tags: ['Fresh Watermelon', 'Mint & Lime', 'Sparkling'],
      ),
      CraftMenuItem(
        id: 'mocktail_peach',
        title: 'Peach Blossom Mocktail',
        category: 'Mocktails',
        rawPrice: 400,
        description:
            'Sweet white peach nectar with elderflower syrup, sparkling water, and fresh thyme.',
        imagePath: 'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=800&q=80',
        isNetwork: true,
        tags: ['White Peach', 'Sparkling Soda', 'Floral'],
      ),
      CraftMenuItem(
        id: 'mocktail_passion_fruit',
        title: 'Passion Fruit Refresher',
        category: 'Mocktails',
        rawPrice: 400,
        description:
            'Tart and aromatic passion fruit pulp shaken with lemon zest, mint, and mineral fizz.',
        imagePath: 'https://images.unsplash.com/photo-1536935338788-846bb9981813?w=800&q=80',
        isNetwork: true,
        tags: ['Passion Fruit Pulp', 'Tangy', 'Fizz'],
      ),
      CraftMenuItem(
        id: 'mocktail_strawberry_peach',
        title: 'Strawberry & Peach Fizz',
        category: 'Mocktails',
        rawPrice: 400,
        description:
            'Dual fruit infusion of sliced strawberries and sweet peach syrup topped with cold sparkling water.',
        imagePath: 'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=800&q=80',
        isNetwork: true,
        tags: ['Strawberry & Peach', 'Mint', 'Sparkling'],
      ),

      // ================= HANDCRAFTED BAKERY: COOKIES & BROWNIES =================
      CraftMenuItem(
        id: 'cookie_matilda',
        title: 'Matilda Bomb Cookie',
        category: 'Cookies & Brownies',
        rawPrice: 400,
        description:
            'Gooey molten dark chocolate core, crisp buttery golden perimeter, sprinkled with flaky Maldon sea salt.',
        imagePath: 'assets/images/dryp_brownies_cookies.jpg',
        isNetwork: false,
        badge: 'Famous Bakes',
        tags: ['Molten Core', 'Maldon Sea Salt', 'Fresh Baked'],
      ),
      CraftMenuItem(
        id: 'cookie_trinity',
        title: 'Chocolate Trinity Cookie',
        category: 'Cookies & Brownies',
        rawPrice: 350,
        description:
            'Triple chocolate delight crafted with white Belgian, milk chocolate, and 70% dark chocolate chunks.',
        imagePath: 'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=800&q=80',
        isNetwork: true,
        tags: ['Triple Chocolate', 'Soft Baked', 'Chunky'],
      ),
      CraftMenuItem(
        id: 'cookie_chunky_og',
        title: 'Chunky OG Cookie',
        category: 'Cookies & Brownies',
        rawPrice: 300,
        description:
            'The original brown butter cookie loaded with roasted walnuts and dark chocolate shards.',
        imagePath: 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=800&q=80',
        isNetwork: true,
        tags: ['Brown Butter', 'Roasted Walnuts', 'Classic'],
      ),
      CraftMenuItem(
        id: 'cookie_hazelnut_bloom',
        title: 'Hazelnut Bloom Cookie',
        category: 'Cookies & Brownies',
        rawPrice: 400,
        description:
            'Stuffed with warm Nutella and roasted Piedmont hazelnuts, baked until chewy and fragrant.',
        imagePath: 'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=800&q=80',
        isNetwork: true,
        badge: 'Nutella Stuffed',
        tags: ['Nutella Center', 'Piedmont Hazelnut', 'Warm'],
      ),
      CraftMenuItem(
        id: 'brownie_caramel_drizzle',
        title: 'Caramelized Lotus Brownie',
        category: 'Cookies & Brownies',
        rawPrice: 400,
        description:
            'Rich Belgian chocolate fudge brownie topped with caramelized Biscoff Lotus spread and Lotus biscuit crumble.',
        imagePath: 'assets/images/dryp_bakery_display.jpg',
        isNetwork: false,
        badge: 'Specialty Slices',
        tags: ['Lotus Biscoff', 'Fudgy Dark Choc', 'Caramelized'],
      ),
      CraftMenuItem(
        id: 'brownie_fudge_icon',
        title: 'Fudge Icon Brownie',
        category: 'Cookies & Brownies',
        rawPrice: 300,
        description:
            'Ultra-dense pure chocolate slab baked with high cacao butter for a melt-in-mouth texture.',
        imagePath: 'assets/images/dryp_bakery_display.jpg',
        isNetwork: false,
        tags: ['70% Cacao', 'Melt-in-mouth', 'Intense'],
      ),
      CraftMenuItem(
        id: 'brownie_loaded_chunk',
        title: 'Loaded Chunk Brownie',
        category: 'Cookies & Brownies',
        rawPrice: 300,
        description:
            'Packed with roasted pecans, milk chocolate blocks, and dark chocolate drizzle.',
        imagePath: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=800&q=80',
        isNetwork: true,
        tags: ['Roasted Pecans', 'Double Chunk', 'Fudge'],
      ),
      CraftMenuItem(
        id: 'brownie_midnight_oreo',
        title: 'Midnight Oreo Brownie',
        category: 'Cookies & Brownies',
        rawPrice: 350,
        description:
            'Dark cocoa brownie base baked with an entire layer of whole Oreo cookies and vanilla cream swirl.',
        imagePath: 'https://images.unsplash.com/photo-1607958996333-41aef7caef4b?w=800&q=80',
        isNetwork: true,
        badge: 'Customer Pick',
        tags: ['Whole Oreo', 'Dark Cocoa', 'Cream Swirl'],
      ),
    ];
  }
}
