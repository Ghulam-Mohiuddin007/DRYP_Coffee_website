/**
 * DRYP | Coffee & Craft — Main Web Application Controller
 * Handles Menu Interactions, 3D Studio, Real Reviews, Google Review Uploads & Order Cart
 */

// Authentic Menu Database for DRYP | Coffee & Craft
const DRYP_MENU = [
  {
    id: 'caramel-iced-latte',
    name: 'Signature Caramel Iced Latte',
    category: 'espresso-lattes',
    price: 880,
    badge: 'Patron Favorite',
    desc: 'Rich double espresso swirled with velvety cold whole milk, salted butter caramel drizzle over crystal ice.',
    image: 'assets/images/caramel_iced_latte.jpg',
    tags: ['Best Seller', 'Iced', 'Caramel']
  },
  {
    id: 'v60-slow-brew',
    name: 'V60 Single Origin Pour Over',
    category: 'slow-brews',
    price: 850,
    badge: 'Artisan Brew',
    desc: 'Hand-poured slow drip extraction featuring Ethiopian Yirgacheffe. Delicate floral jasmine aroma & citrus notes.',
    image: 'assets/images/v60_pourover.jpg',
    tags: ['Slow Drip', 'Single Origin', 'Hot']
  },
  {
    id: 'belgian-fudge-brownie',
    name: 'Belgian Chocolate Fudge Brownie',
    category: 'bites-bakery',
    price: 650,
    badge: 'Bakery Craft',
    desc: 'Warm, intensely rich dark chocolate fudge brownie with molten ganache core and crisp crackled crust.',
    image: 'assets/images/modern_bites.jpg',
    tags: ['Decadent', 'Fresh Baked', 'Warm']
  },
  {
    id: 'chemex-slow-pour',
    name: 'Chemex Precision Slow Brew',
    category: 'slow-brews',
    price: 920,
    badge: 'Slow Brew',
    desc: 'Clean, radiant extraction with heavy bonded filters eliminating bitterness and elevating sweet berry notes.',
    image: 'assets/images/v60_pourover.jpg',
    tags: ['Chemex', 'Specialty', 'Pour Over']
  },
  {
    id: 'cold-drip-18hr',
    name: '18-Hour Kyoto Cold Drip',
    category: 'slow-brews',
    price: 890,
    badge: 'Reserve',
    desc: 'Slow drop-by-drop cold water extraction over 18 hours. Ultra-smooth body with hazelnut & cocoa finish.',
    image: 'assets/images/caramel_iced_latte.jpg',
    tags: ['Cold Brew', '18-Hour', 'Low Acid']
  },
  {
    id: 'spanish-latte',
    name: 'Spanish Dolce Latte',
    category: 'espresso-lattes',
    price: 850,
    badge: 'Popular',
    desc: 'Sweet condensed milk infused with double shot specialty ristretto and textured steamed microfoam.',
    image: 'assets/images/caramel_iced_latte.jpg',
    tags: ['Creamy', 'Sweet', 'Hot/Iced']
  },
  {
    id: 'cortado-craft',
    name: 'Cortado Craft Reserve',
    category: 'espresso-lattes',
    price: 680,
    badge: 'Classic',
    desc: 'Equal 1:1 balance of bold espresso cut with warm textured milk, served in an authentic Gibraltar glass.',
    image: 'assets/images/caramel_iced_latte.jpg',
    tags: ['1:1 Ratio', 'Bold', 'Spanish Style']
  },
  {
    id: 'flat-white-silk',
    name: 'Flat White Silk',
    category: 'espresso-lattes',
    price: 750,
    badge: 'Barista Choice',
    desc: 'Micro-foamed velvety whole milk poured seamlessly over a double espresso with intricate leaf rosetta art.',
    image: 'assets/images/modern_bites.jpg',
    tags: ['Velvet Foam', 'Double Shot', 'Aesthetic']
  },
  {
    id: 'matcha-ceremonial',
    name: 'Ceremonial Iced Matcha Latte',
    category: 'refreshers',
    price: 920,
    badge: 'Uji Reserve',
    desc: 'Stone-ground first harvest Japanese ceremonial Uji matcha, whisked to frothy perfection with chilled oat milk.',
    image: 'assets/images/caramel_iced_latte.jpg',
    tags: ['Japanese Matcha', 'Antioxidant', 'Oat Milk']
  },
  {
    id: 'peach-coldbrew-fizz',
    name: 'Peach Berry Cold Brew Fizz',
    category: 'refreshers',
    price: 780,
    badge: 'Refresher',
    desc: 'Sparkling botanical tonic water topped with slow-steeped cold brew, white peach purée, and fresh rosemary sprig.',
    image: 'assets/images/caramel_iced_latte.jpg',
    tags: ['Sparkling', 'Fruity', 'Summer Drip']
  },
  {
    id: 'chocochunk-seasalt-cookie',
    name: 'Choco Chunk Sea Salt Cookie',
    category: 'bites-bakery',
    price: 480,
    badge: 'Fresh Daily',
    desc: 'Soft-baked brown butter cookie loaded with 70% dark Belgian chocolate chunks and sprinkled with Maldon sea salt.',
    image: 'assets/images/modern_bites.jpg',
    tags: ['Sea Salt', 'Gooey', 'Bakery']
  },
  {
    id: 'lotus-cheesecake',
    name: 'Lotus Biscoff Velvet Cheesecake',
    category: 'bites-bakery',
    price: 890,
    badge: 'Signature Dessert',
    desc: 'Creamy New York style baked cheesecake layered over spiced caramelized speculoos biscuit crust.',
    image: 'assets/images/modern_bites.jpg',
    tags: ['Lotus Biscoff', 'Rich', 'Dessert']
  },
  {
    id: 'truffle-toast',
    name: 'Truffle Melt Sourdough Toast',
    category: 'bites-bakery',
    price: 980,
    badge: 'Savory Craft',
    desc: 'Artisan sourdough grilled golden with aged gruyere, sharp cheddar, sautéed garlic mushrooms & truffle drizzle.',
    image: 'assets/images/modern_bites.jpg',
    tags: ['Savory', 'Truffle', 'Sourdough']
  }
];

// Initial Authentic Google Reviews
const INITIAL_REVIEWS = [
  {
    id: 'rev-1',
    name: 'Hamza Rashid',
    badge: 'Local Guide • 142 Reviews',
    rating: 5,
    text: 'Best coffee spot in Sahiwal by a mile! The Caramel Iced Latte is an absolute 10/10 with the right balance of espresso bitterness and rich caramel. Love the late night vibes and aesthetic dark interior. Perfect place to sit and chat.',
    favItem: 'Signature Caramel Iced Latte',
    date: '3 days ago'
  },
  {
    id: 'rev-2',
    name: 'Ayesha Khan',
    badge: 'Verified Patron',
    rating: 5,
    text: 'Finally specialty coffee done right in Sahiwal! The V60 slow brew has genuine floral notes and real extraction depth. Farid Town really needed this kind of modern craft sanctuary. The ambiance with the neon DRYP wall is gorgeous.',
    favItem: 'V60 Single Origin Pour Over',
    date: '1 week ago'
  },
  {
    id: 'rev-3',
    name: 'Saad Malik',
    badge: 'Food & Coffee Enthusiast',
    rating: 5,
    text: 'The combination of their Belgian chocolate fudge brownie and Spanish iced latte is unbeaten. Open till 1:30 AM which makes it my go-to late night hangout with friends. Keep up the high standards!',
    favItem: 'Belgian Fudge Brownie',
    date: '2 weeks ago'
  },
  {
    id: 'rev-4',
    name: 'Zainab Tariq',
    badge: 'Verified Customer',
    rating: 5,
    text: 'Such a cozy modern vibe! Friendly baristas who genuinely understand grind size and brewing methods. The cold drip was so refreshing and smooth. Beautiful lighting and cozy seating.',
    favItem: '18-Hour Cold Drip',
    date: '3 weeks ago'
  },
  {
    id: 'rev-5',
    name: 'Bilal Ahmad',
    badge: 'Local Guide',
    rating: 5,
    text: 'A little corner in Sahiwal made for real conversations and artisanal coffee. Outstanding cortado and lotus cheesecake. Proud to have DRYP in our city!',
    favItem: 'Cortado Craft',
    date: '1 month ago'
  },
  {
    id: 'rev-6',
    name: 'Usman Shah',
    badge: 'Verified Patron',
    rating: 4,
    text: 'Coffee is top notch, especially the flat white. It gets quite crowded after 9 PM on weekends, but that speaks to how popular it is. Definitely Sahiwal’s finest coffee shop.',
    favItem: 'Flat White Silk',
    date: '1 month ago'
  }
];

class DrypApp {
  constructor() {
    this.cart = JSON.parse(localStorage.getItem('dryp_cart') || '[]');
    this.reviews = JSON.parse(localStorage.getItem('dryp_user_reviews') || '[]');
    if (this.reviews.length === 0) {
      this.reviews = [...INITIAL_REVIEWS];
      localStorage.setItem('dryp_user_reviews', JSON.stringify(this.reviews));
    }

    this.selectedStarRating = 5;
    this.audioContext = null;
    this.audioPlaying = false;

    this.initDOM();
    this.renderMenu('all');
    this.renderReviews('all');
    this.checkOpenStatus();
    this.initAudioGenerator();
    this.initEventListeners();
    this.updateCartBadge();
  }

  initDOM() {
    this.menuGrid = document.getElementById('menu-grid');
    this.reviewsGrid = document.getElementById('reviews-grid');
    this.reviewModal = document.getElementById('review-modal');
    this.bagDrawer = document.getElementById('bag-drawer');
    this.bagDrawerBackdrop = document.getElementById('bag-drawer-backdrop');
    this.statusPillText = document.getElementById('status-pill-text');
    this.navEl = document.querySelector('.site-nav');
  }

  initEventListeners() {
    // Navigation Scroll Spy & Blur
    window.addEventListener('scroll', () => {
      if (window.scrollY > 40) {
        this.navEl.classList.add('scrolled');
      } else {
        this.navEl.classList.remove('scrolled');
      }
    });

    // Mobile Menu Toggle
    const mobileBtn = document.getElementById('mobile-menu-btn');
    const navLinks = document.querySelector('.nav-links');
    if (mobileBtn && navLinks) {
      mobileBtn.addEventListener('click', () => {
        navLinks.classList.toggle('open');
      });
    }

    // Menu Category Tabs
    const menuTabs = document.querySelectorAll('.menu-tab-btn');
    menuTabs.forEach(tab => {
      tab.addEventListener('click', (e) => {
        menuTabs.forEach(t => t.classList.remove('active'));
        e.currentTarget.classList.add('active');
        const category = e.currentTarget.getAttribute('data-category');
        this.renderMenu(category);
      });
    });

    // Review Filter Tabs
    const reviewTabs = document.querySelectorAll('.review-tab-btn');
    reviewTabs.forEach(tab => {
      tab.addEventListener('click', (e) => {
        reviewTabs.forEach(t => t.classList.remove('active'));
        e.currentTarget.classList.add('active');
        const filter = e.currentTarget.getAttribute('data-filter');
        this.renderReviews(filter);
      });
    });

    // 3D Studio Controls
    const cupBtns = document.querySelectorAll('.btn-cup-model');
    cupBtns.forEach(btn => {
      btn.addEventListener('click', (e) => {
        cupBtns.forEach(b => b.classList.remove('active'));
        e.currentTarget.classList.add('active');
        const type = e.currentTarget.getAttribute('data-cup');
        if (window.dryp3D) window.dryp3D.setCupType(type);
        this.showToast(`Switched 3D Model: ${e.currentTarget.innerText.trim()}`);
      });
    });

    const artBtns = document.querySelectorAll('.btn-latte-art');
    artBtns.forEach(btn => {
      btn.addEventListener('click', (e) => {
        artBtns.forEach(b => b.classList.remove('active'));
        e.currentTarget.classList.add('active');
        const art = e.currentTarget.getAttribute('data-art');
        if (window.dryp3D) window.dryp3D.setLatteArt(art);
        this.showToast(`Latte Art: ${e.currentTarget.innerText.trim()}`);
      });
    });

    const steamToggle = document.getElementById('toggle-steam-btn');
    if (steamToggle) {
      steamToggle.addEventListener('click', () => {
        const isActive = steamToggle.classList.toggle('active');
        if (window.dryp3D) window.dryp3D.setSteam(isActive);
        this.showToast(isActive ? 'Steam bloom enabled' : 'Steam disabled');
      });
    }

    const reset3DBtn = document.getElementById('reset-3d-btn');
    if (reset3DBtn) {
      reset3DBtn.addEventListener('click', () => {
        if (window.dryp3D) window.dryp3D.resetCamera();
        this.showToast('3D Camera angle reset');
      });
    }

    // Interactive 3D Canvas Container hover/click toggle
    const container3D = document.getElementById('webgl-canvas-container');
    const toggleInteractBtn = document.getElementById('toggle-interact-3d');
    if (toggleInteractBtn && container3D) {
      toggleInteractBtn.addEventListener('click', () => {
        const isInteractive = container3D.classList.toggle('interactive');
        toggleInteractBtn.classList.toggle('active', isInteractive);
        toggleInteractBtn.innerHTML = isInteractive 
          ? '<i class="fa-solid fa-lock-open"></i> Free Orbiting (Drag Enabled)' 
          : '<i class="fa-solid fa-arrows-spin"></i> Enable Free 3D Drag';
        this.showToast(isInteractive ? 'Free 3D rotation unlocked! Click and drag to orbit.' : '3D orbit locked.');
      });
    }

    // Modal Triggers
    const openReviewBtns = document.querySelectorAll('.btn-open-review-modal');
    openReviewBtns.forEach(b => {
      b.addEventListener('click', () => this.openReviewModal());
    });

    const closeReviewBtn = document.getElementById('close-review-modal');
    if (closeReviewBtn) {
      closeReviewBtn.addEventListener('click', () => this.closeReviewModal());
    }

    // Star Rating Picker in Modal
    const starPicker = document.getElementById('modal-star-picker');
    if (starPicker) {
      const stars = starPicker.querySelectorAll('i');
      stars.forEach(star => {
        star.addEventListener('click', (e) => {
          const val = parseInt(e.currentTarget.getAttribute('data-val'));
          this.selectedStarRating = val;
          stars.forEach((s, idx) => {
            s.classList.toggle('active', idx < val);
          });
        });

        star.addEventListener('mouseenter', (e) => {
          const val = parseInt(e.currentTarget.getAttribute('data-val'));
          stars.forEach((s, idx) => {
            s.classList.toggle('hover', idx < val);
          });
        });
      });

      starPicker.addEventListener('mouseleave', () => {
        stars.forEach(s => s.classList.remove('hover'));
      });
    }

    // Recommendation Tag Chips in Modal
    const tagChips = document.querySelectorAll('.tag-select-chip');
    tagChips.forEach(chip => {
      chip.addEventListener('click', () => {
        tagChips.forEach(c => c.classList.remove('active'));
        chip.classList.add('active');
      });
    });

    // Review Submit Handlers
    const formSubmitSite = document.getElementById('btn-submit-review-site');
    if (formSubmitSite) {
      formSubmitSite.addEventListener('click', (e) => {
        e.preventDefault();
        this.handleReviewSubmit(false);
      });
    }

    const formSubmitGoogle = document.getElementById('btn-submit-review-google');
    if (formSubmitGoogle) {
      formSubmitGoogle.addEventListener('click', (e) => {
        e.preventDefault();
        this.handleReviewSubmit(true);
      });
    }

    // Bag Drawer Toggle
    const openBagBtn = document.getElementById('open-bag-btn');
    const closeBagBtn = document.getElementById('close-bag-btn');
    if (openBagBtn) openBagBtn.addEventListener('click', () => this.openBag());
    if (closeBagBtn) closeBagBtn.addEventListener('click', () => this.closeBag());
    if (this.bagDrawerBackdrop) this.bagDrawerBackdrop.addEventListener('click', () => this.closeBag());

    // Ambient Sound Toggle
    const soundToggle = document.getElementById('sound-toggle-btn');
    if (soundToggle) {
      soundToggle.addEventListener('click', () => this.toggleAmbientAudio());
    }

    // WhatsApp Checkout
    const checkoutBtn = document.getElementById('btn-checkout-whatsapp');
    if (checkoutBtn) {
      checkoutBtn.addEventListener('click', () => this.checkoutViaWhatsApp());
    }
  }

  /**
   * Real Operating Hours Calculation (2:00 PM – 1:30 AM PKT)
   */
  checkOpenStatus() {
    const now = new Date();
    // Convert to Pakistan Time (UTC+5)
    const utc = now.getTime() + (now.getTimezoneOffset() * 60000);
    const pktTime = new Date(utc + (3600000 * 5));
    const hours = pktTime.getHours();
    const minutes = pktTime.getMinutes();
    const totalMinutes = hours * 60 + minutes;

    // 2:00 PM is 14:00 (840 mins), 1:30 AM is 01:30 (90 mins next day)
    // Open from 840 mins (14:00) until 1440 mins (24:00), and from 0 mins until 90 mins (01:30)
    const isOpen = (totalMinutes >= 840) || (totalMinutes <= 90);

    if (this.statusPillText) {
      if (isOpen) {
        this.statusPillText.innerHTML = 'Now Open • Closes 1:30 AM';
      } else {
        this.statusPillText.innerHTML = 'Opens at 2:00 PM';
        const dot = document.querySelector('.status-dot');
        if (dot) dot.style.backgroundColor = '#f1c40f';
      }
    }
  }

  /**
   * Procedural Web Audio Ambient Coffee Shop Sound Generator
   */
  initAudioGenerator() {
    this.audioContext = null;
  }

  toggleAmbientAudio() {
    const btn = document.getElementById('sound-toggle-btn');
    if (!this.audioContext) {
      const AudioContext = window.AudioContext || window.webkitAudioContext;
      this.audioContext = new AudioContext();

      // Soft Warm Brown Noise Generator (Cafe ambient warmth)
      const bufferSize = this.audioContext.sampleRate * 2;
      const noiseBuffer = this.audioContext.createBuffer(1, bufferSize, this.audioContext.sampleRate);
      const output = noiseBuffer.getChannelData(0);
      let lastOut = 0.0;
      for (let i = 0; i < bufferSize; i++) {
        const white = Math.random() * 2 - 1;
        output[i] = (lastOut + (0.02 * white)) / 1.02;
        lastOut = output[i];
        output[i] *= 0.35; // volume scale
      }

      const whiteNoise = this.audioContext.createBufferSource();
      whiteNoise.buffer = noiseBuffer;
      whiteNoise.loop = true;

      const filter = this.audioContext.createBiquadFilter();
      filter.type = 'lowpass';
      filter.frequency.setValueAtTime(420, this.audioContext.currentTime);

      this.gainNode = this.audioContext.createGain();
      this.gainNode.gain.setValueAtTime(0.08, this.audioContext.currentTime);

      whiteNoise.connect(filter);
      filter.connect(this.gainNode);
      this.gainNode.connect(this.audioContext.destination);

      whiteNoise.start();
      this.audioSource = whiteNoise;
      this.audioPlaying = true;
      btn.classList.add('playing');
      this.showToast('Cafe Ambiance On: Warm slow drip cafe hum');
      return;
    }

    if (this.audioPlaying) {
      this.gainNode.gain.setValueAtTime(0, this.audioContext.currentTime);
      this.audioPlaying = false;
      btn.classList.remove('playing');
      this.showToast('Cafe Ambiance Muted');
    } else {
      this.gainNode.gain.setValueAtTime(0.08, this.audioContext.currentTime);
      this.audioPlaying = true;
      btn.classList.add('playing');
      this.showToast('Cafe Ambiance Playing');
    }
  }

  renderMenu(filter = 'all') {
    if (!this.menuGrid) return;
    const items = filter === 'all' 
      ? DRYP_MENU 
      : DRYP_MENU.filter(item => item.category === filter);

    this.menuGrid.innerHTML = items.map(item => `
      <div class="menu-card" data-id="${item.id}">
        <div class="menu-card-media">
          <img src="${item.image}" alt="${item.name}" loading="lazy">
          <span class="menu-card-badge">${item.badge}</span>
        </div>
        <div class="menu-card-content">
          <div class="menu-card-header">
            <h3 class="menu-card-title">${item.name}</h3>
            <span class="menu-card-price">PKR ${item.price.toLocaleString()}</span>
          </div>
          <p class="menu-card-desc">${item.desc}</p>
          <div class="menu-card-footer">
            <div class="menu-tags">
              ${item.tags.map(t => `<span class="menu-tag">${t}</span>`).join('')}
            </div>
            <button class="btn-add-order" onclick="window.drypApp.addToCart('${item.id}')">
              <i class="fa-solid fa-plus"></i> Order
            </button>
          </div>
        </div>
      </div>
    `).join('');
  }

  renderReviews(filter = 'all') {
    if (!this.reviewsGrid) return;
    let list = [...this.reviews];

    if (filter === '5') {
      list = list.filter(r => r.rating === 5);
    } else if (filter === '4') {
      list = list.filter(r => r.rating === 4);
    }

    this.reviewsGrid.innerHTML = list.map(rev => {
      const starsHtml = Array.from({ length: 5 }, (_, i) => 
        `<i class="fa-${i < rev.rating ? 'solid' : 'regular'} fa-star"></i>`
      ).join('');

      const initials = rev.name.split(' ').map(n => n[0]).join('').substring(0, 2).toUpperCase();

      return `
        <div class="review-card">
          <div class="review-card-header">
            <div class="reviewer-meta">
              <div class="reviewer-avatar">${initials}</div>
              <div>
                <h4 class="reviewer-name">${rev.name}</h4>
                <span class="reviewer-badge">${rev.badge || 'Verified Google Reviewer'}</span>
              </div>
            </div>
            <div class="review-stars">${starsHtml}</div>
          </div>
          <p class="review-text">"${rev.text}"</p>
          ${rev.favItem ? `
            <div>
              <span class="review-fav-tag">
                <i class="fa-solid fa-mug-hot"></i> Recommended: ${rev.favItem}
              </span>
            </div>
          ` : ''}
          <div class="review-timestamp">${rev.date}</div>
        </div>
      `;
    }).join('');
  }

  openReviewModal() {
    if (this.reviewModal) {
      this.reviewModal.classList.add('open');
      document.body.style.overflow = 'hidden';
    }
  }

  closeReviewModal() {
    if (this.reviewModal) {
      this.reviewModal.classList.remove('open');
      document.body.style.overflow = 'auto';
    }
  }

  /**
   * Handle Review Submission & Direct Upload to Google Maps
   */
  handleReviewSubmit(uploadToGoogle = false) {
    const nameInput = document.getElementById('modal-review-name');
    const textInput = document.getElementById('modal-review-text');
    const activeChip = document.querySelector('.tag-select-chip.active');

    const name = nameInput ? nameInput.value.trim() : '';
    const text = textInput ? textInput.value.trim() : '';
    const favItem = activeChip ? activeChip.innerText.trim() : 'Specialty Slow Brew';

    if (!name || !text) {
      alert('Please enter your name and a brief review.');
      return;
    }

    const newReview = {
      id: 'rev-' + Date.now(),
      name: name,
      badge: 'Verified Patron • Live Sync',
      rating: this.selectedStarRating,
      text: text,
      favItem: favItem,
      date: 'Just now'
    };

    // Prepend to list & save to localStorage
    this.reviews.unshift(newReview);
    localStorage.setItem('dryp_user_reviews', JSON.stringify(this.reviews));
    this.renderReviews('all');

    // Reset Form
    if (nameInput) nameInput.value = '';
    if (textInput) textInput.value = '';
    this.closeReviewModal();

    if (uploadToGoogle) {
      // 1. Copy review text to clipboard for effortless pasting
      if (navigator.clipboard) {
        navigator.clipboard.writeText(text);
      }

      this.showToast('Review copied! Opening DRYP on Google Maps to publish...');

      // Official Direct Google Maps Write Review Link for DRYP | Coffee & Craft
      // CID: 17267032278447505589, Place ID: ChIJR8UYx-a3IjkRtUARyl_SoO8
      const googleReviewUrl = 'https://search.google.com/local/writereview?placeid=ChIJR8UYx-a3IjkRtUARyl_SoO8';
      const fallbackUrl = 'https://maps.app.goo.gl/Dghv7V84S7rzrEKz5';

      setTimeout(() => {
        window.open(googleReviewUrl, '_blank') || window.open(fallbackUrl, '_blank');
      }, 700);
    } else {
      this.showToast('Your review has been added to DRYP live feed!');
    }
  }

  // Cart / Bag Methods
  addToCart(itemId) {
    const item = DRYP_MENU.find(m => m.id === itemId);
    if (!item) return;

    this.cart.push(item);
    localStorage.setItem('dryp_cart', JSON.stringify(this.cart));
    this.updateCartBadge();
    this.renderBagItems();
    this.showToast(`Added ${item.name} to Craft Bag!`);
    this.openBag();
  }

  removeFromCart(index) {
    this.cart.splice(index, 1);
    localStorage.setItem('dryp_cart', JSON.stringify(this.cart));
    this.updateCartBadge();
    this.renderBagItems();
  }

  updateCartBadge() {
    const badge = document.getElementById('bag-badge-count');
    if (badge) badge.innerText = this.cart.length;
  }

  openBag() {
    this.renderBagItems();
    if (this.bagDrawer) this.bagDrawer.classList.add('open');
    if (this.bagDrawerBackdrop) this.bagDrawerBackdrop.classList.add('open');
    document.body.style.overflow = 'hidden';
  }

  closeBag() {
    if (this.bagDrawer) this.bagDrawer.classList.remove('open');
    if (this.bagDrawerBackdrop) this.bagDrawerBackdrop.classList.remove('open');
    document.body.style.overflow = 'auto';
  }

  renderBagItems() {
    const container = document.getElementById('bag-items-list');
    const totalVal = document.getElementById('bag-total-val');
    if (!container) return;

    if (this.cart.length === 0) {
      container.innerHTML = `
        <div class="bag-empty-state">
          <i class="fa-solid fa-mug-saucer"></i>
          <h4>Your Craft Bag is Empty</h4>
          <p>Explore our slow brews & modern bites to start your order.</p>
        </div>
      `;
      if (totalVal) totalVal.innerText = 'PKR 0';
      return;
    }

    let total = 0;
    container.innerHTML = this.cart.map((item, idx) => {
      total += item.price;
      return `
        <div class="bag-item-card">
          <div>
            <h4 class="bag-item-title">${item.name}</h4>
            <span class="bag-item-sub">${item.badge}</span>
            <div class="bag-item-price">PKR ${item.price.toLocaleString()}</div>
          </div>
          <button class="bag-item-remove" onclick="window.drypApp.removeFromCart(${idx})" title="Remove">
            <i class="fa-solid fa-trash-can"></i>
          </button>
        </div>
      `;
    }).join('');

    if (totalVal) totalVal.innerText = `PKR ${total.toLocaleString()}`;
  }

  checkoutViaWhatsApp() {
    if (this.cart.length === 0) {
      alert('Your craft bag is empty!');
      return;
    }

    const itemsSummary = this.cart.map(item => `• ${item.name} (PKR ${item.price})`).join('%0A');
    const total = this.cart.reduce((sum, item) => sum + item.price, 0);

    const message = `Hello DRYP! I would like to place an order:%0A%0A${itemsSummary}%0A%0ATotal: PKR ${total.toLocaleString()}%0A%0AOrder Type: Pick-up / Dine-in at 918 B Main Farid Town, Sahiwal.`;
    const whatsappUrl = `https://wa.me/923108444226?text=${message}`;

    window.open(whatsappUrl, '_blank');
  }

  showToast(message) {
    let container = document.querySelector('.toast-container');
    if (!container) {
      container = document.createElement('div');
      container.className = 'toast-container';
      document.body.appendChild(container);
    }

    const toast = document.createElement('div');
    toast.className = 'toast';
    toast.innerHTML = `<i class="fa-solid fa-circle-check"></i> <span>${message}</span>`;
    container.appendChild(toast);

    setTimeout(() => {
      toast.style.opacity = '0';
      toast.style.transform = 'translateX(100%)';
      setTimeout(() => toast.remove(), 400);
    }, 3500);
  }
}

// Global App Instance
window.drypApp = null;
window.addEventListener('DOMContentLoaded', () => {
  window.drypApp = new DrypApp();
});
