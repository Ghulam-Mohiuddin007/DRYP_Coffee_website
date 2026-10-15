/**
 * DRYP | Coffee & Craft — 3D WebGL Coffee Engine
 * Three.js Procedural 3D Coffee Cup, Steam Simulation, Floating Beans & Scroll Rigging
 */

class DrypCoffeeScene {
  constructor() {
    this.container = document.getElementById('webgl-canvas-container');
    this.canvas = document.getElementById('three-canvas');
    if (!this.container || !this.canvas) return;

    this.width = window.innerWidth;
    this.height = window.innerHeight;

    // State & Config
    this.currentCupType = 'ceramic_latte'; // 'ceramic_latte' | 'iced_ribbed'
    this.currentArt = 'rosetta';
    this.steamEnabled = true;
    this.beanSpeedMultiplier = 1;
    this.isDragging = false;
    this.mouse = { x: 0, y: 0, targetX: 0, targetY: 0 };
    this.scrollProgress = 0;
    this.clock = new THREE.Clock();

    // Scene setup
    this.initScene();
    this.initLights();
    this.buildCoffeeBeans();
    this.buildSteamParticles();
    this.buildCeramicCup();
    this.buildIcedGlass();
    this.initEvents();
    this.animate();
  }

  initScene() {
    this.scene = new THREE.Scene();
    this.camera = new THREE.PerspectiveCamera(42, this.width / this.height, 0.1, 100);
    this.camera.position.set(0, 1.2, 5.8);

    this.renderer = new THREE.WebGLRenderer({
      canvas: this.canvas,
      antialias: true,
      alpha: true,
      powerPreference: 'high-performance'
    });
    this.renderer.setSize(this.width, this.height);
    this.renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
    this.renderer.shadowMap.enabled = true;
    this.renderer.shadowMap.type = THREE.PCFSoftShadowMap;

    // Main 3D Pivot Group
    this.cupPivot = new THREE.Group();
    this.cupPivot.position.set(1.4, -0.1, 0); // Hero offset (right side)
    this.scene.add(this.cupPivot);
  }

  initLights() {
    // Key Warm Light
    this.keyLight = new THREE.DirectionalLight(0xffbe76, 2.2);
    this.keyLight.position.set(4, 6, 4);
    this.keyLight.castShadow = true;
    this.scene.add(this.keyLight);

    // Cool Rim Light
    this.rimLight = new THREE.DirectionalLight(0x74b9ff, 1.2);
    this.rimLight.position.set(-5, 4, -4);
    this.scene.add(this.rimLight);

    // Warm Ambient Light
    this.ambientLight = new THREE.AmbientLight(0x3d271d, 1.4);
    this.scene.add(this.ambientLight);

    // Specular Foam Glow PointLight
    this.foamGlow = new THREE.PointLight(0xd99b5b, 1.5, 4);
    this.foamGlow.position.set(0, 1.8, 0.2);
    this.cupPivot.add(this.foamGlow);
  }

  /**
   * Procedural Dynamic Latte Art Canvas Texture
   */
  createLatteArtTexture(type = 'rosetta') {
    const canvas = document.createElement('canvas');
    canvas.width = 512;
    canvas.height = 512;
    const ctx = canvas.getContext('2d');

    // Rich Espresso Base
    const grad = ctx.createRadialGradient(256, 256, 50, 256, 256, 256);
    grad.addColorStop(0, '#54301c');
    grad.addColorStop(0.65, '#351c0f');
    grad.addColorStop(1, '#1e0f08');
    ctx.fillStyle = grad;
    ctx.fillRect(0, 0, 512, 512);

    // Crema Microfoam Marbling
    ctx.strokeStyle = '#c68f53';
    ctx.lineWidth = 14;
    ctx.lineCap = 'round';
    for (let r = 80; r < 230; r += 35) {
      ctx.beginPath();
      ctx.arc(256, 256, r, 0, Math.PI * 2);
      ctx.stroke();
    }

    // Latte Art Foam (Ivory / Velvet Cream)
    ctx.fillStyle = '#fdf6ee';
    ctx.strokeStyle = '#f5e4d0';

    if (type === 'rosetta') {
      // Intricate Rosetta Leaves
      ctx.save();
      ctx.translate(256, 256);
      for (let i = 0; i < 9; i++) {
        const y = -140 + i * 32;
        const width = 110 - Math.abs(i - 4) * 16;
        ctx.beginPath();
        ctx.ellipse(-width * 0.45, y, width * 0.45, 12, -0.2, 0, Math.PI * 2);
        ctx.ellipse(width * 0.45, y, width * 0.45, 12, 0.2, 0, Math.PI * 2);
        ctx.fill();
      }
      // Stem cut through
      ctx.lineWidth = 8;
      ctx.strokeStyle = '#3d2012';
      ctx.beginPath();
      ctx.moveTo(0, -160);
      ctx.lineTo(0, 150);
      ctx.stroke();

      // Top Heart
      ctx.fillStyle = '#fdf6ee';
      ctx.beginPath();
      ctx.arc(-14, -145, 16, 0, Math.PI * 2);
      ctx.arc(14, -145, 16, 0, Math.PI * 2);
      ctx.fill();
      ctx.restore();
    } else if (type === 'heart') {
      // Classic Solid Pour Heart
      ctx.save();
      ctx.translate(256, 256);
      ctx.beginPath();
      ctx.arc(-40, -30, 60, 0, Math.PI * 2);
      ctx.arc(40, -30, 60, 0, Math.PI * 2);
      ctx.moveTo(-100, -10);
      ctx.lineTo(0, 110);
      ctx.lineTo(100, -10);
      ctx.fill();
      // Cut through
      ctx.lineWidth = 8;
      ctx.strokeStyle = '#3d2012';
      ctx.beginPath();
      ctx.moveTo(0, -100);
      ctx.lineTo(0, 130);
      ctx.stroke();
      ctx.restore();
    } else if (type === 'swan') {
      // Elegant Artisan Swan
      ctx.save();
      ctx.translate(256, 256);
      ctx.beginPath();
      ctx.arc(-20, -50, 45, 0, Math.PI * 2);
      ctx.arc(35, 20, 75, 0, Math.PI * 2);
      ctx.fill();
      // Swan Neck & Beak
      ctx.lineWidth = 18;
      ctx.strokeStyle = '#fdf6ee';
      ctx.beginPath();
      ctx.moveTo(0, 40);
      ctx.quadraticCurveTo(-70, -30, -50, -100);
      ctx.stroke();
      ctx.restore();
    } else {
      // Rich Golden Crema Swirl
      ctx.save();
      ctx.translate(256, 256);
      for (let i = 0; i < 6; i++) {
        ctx.rotate(Math.PI / 3);
        ctx.beginPath();
        ctx.ellipse(60, 0, 50, 20, 0, 0, Math.PI * 2);
        ctx.fillStyle = 'rgba(253, 246, 238, 0.85)';
        ctx.fill();
      }
      ctx.restore();
    }

    const texture = new THREE.CanvasTexture(canvas);
    texture.generateMipmaps = true;
    return texture;
  }

  buildCeramicCup() {
    this.ceramicCupGroup = new THREE.Group();

    // 1. Ceramic Mug Body
    // Using CylinderGeometry with slight top taper
    const cupGeo = new THREE.CylinderGeometry(1.05, 0.82, 1.45, 48, 1, true);
    const cupMat = new THREE.MeshStandardMaterial({
      color: 0x181310, // Matte Dark Roast Obsidian Ceramic
      roughness: 0.28,
      metalness: 0.1,
      side: THREE.DoubleSide
    });
    this.cupBody = new THREE.Mesh(cupGeo, cupMat);
    this.cupBody.castShadow = true;
    this.cupBody.receiveShadow = true;
    this.ceramicCupGroup.add(this.cupBody);

    // Cup Inner Wall
    const innerGeo = new THREE.CylinderGeometry(0.98, 0.77, 1.42, 48, 1, true);
    const innerMat = new THREE.MeshStandardMaterial({
      color: 0x241c17,
      roughness: 0.2,
      metalness: 0.05,
      side: THREE.BackSide
    });
    const cupInner = new THREE.Mesh(innerGeo, innerMat);
    this.ceramicCupGroup.add(cupInner);

    // Cup Base / Floor
    const baseGeo = new THREE.CylinderGeometry(0.82, 0.82, 0.08, 48);
    const baseMesh = new THREE.Mesh(baseGeo, cupMat);
    baseMesh.position.y = -0.72;
    this.ceramicCupGroup.add(baseMesh);

    // Gold Trim on Rim
    const rimGeo = new THREE.TorusGeometry(1.03, 0.035, 16, 48);
    const rimMat = new THREE.MeshStandardMaterial({
      color: 0xd99b5b, // DRYP Warm Caramel Gold Trim
      roughness: 0.2,
      metalness: 0.85
    });
    const rimMesh = new THREE.Mesh(rimGeo, rimMat);
    rimMesh.rotation.x = Math.PI / 2;
    rimMesh.position.y = 0.725;
    this.ceramicCupGroup.add(rimMesh);

    // 2. Ergonomic Handle
    const handleGeo = new THREE.TorusGeometry(0.55, 0.11, 24, 48, Math.PI * 1.15);
    const handleMesh = new THREE.Mesh(handleGeo, cupMat);
    handleMesh.position.set(1.08, 0, 0);
    handleMesh.rotation.z = -Math.PI / 2.3;
    this.ceramicCupGroup.add(handleMesh);

    // 3. Saucer Plate
    const saucerGeo = new THREE.CylinderGeometry(1.7, 1.1, 0.12, 54);
    const saucerMat = new THREE.MeshStandardMaterial({
      color: 0x15100d,
      roughness: 0.3,
      metalness: 0.1
    });
    const saucerMesh = new THREE.Mesh(saucerGeo, saucerMat);
    saucerMesh.position.y = -0.82;
    saucerMesh.receiveShadow = true;
    this.ceramicCupGroup.add(saucerMesh);

    // Gold Rim on Saucer
    const saucerRimGeo = new THREE.TorusGeometry(1.7, 0.03, 16, 54);
    const saucerRimMesh = new THREE.Mesh(saucerRimGeo, rimMat);
    saucerRimMesh.rotation.x = Math.PI / 2;
    saucerRimMesh.position.y = -0.76;
    this.ceramicCupGroup.add(saucerRimMesh);

    // 4. Coffee Liquid Surface with Dynamic Latte Art
    const liquidGeo = new THREE.CircleGeometry(0.96, 48);
    this.latteArtTexture = this.createLatteArtTexture(this.currentArt);
    this.liquidMat = new THREE.MeshStandardMaterial({
      map: this.latteArtTexture,
      roughness: 0.18,
      metalness: 0.05
    });
    this.liquidMesh = new THREE.Mesh(liquidGeo, this.liquidMat);
    this.liquidMesh.rotation.x = -Math.PI / 2;
    this.liquidMesh.position.y = 0.58; // Just below rim
    this.ceramicCupGroup.add(this.liquidMesh);

    // Ripple Wave Ring
    const rippleGeo = new THREE.RingGeometry(0.05, 0.2, 32);
    const rippleMat = new THREE.MeshBasicMaterial({
      color: 0xd99b5b,
      transparent: true,
      opacity: 0,
      side: THREE.DoubleSide
    });
    this.rippleMesh = new THREE.Mesh(rippleGeo, rippleMat);
    this.rippleMesh.rotation.x = -Math.PI / 2;
    this.rippleMesh.position.y = 0.585;
    this.ceramicCupGroup.add(this.rippleMesh);

    this.cupPivot.add(this.ceramicCupGroup);
  }

  buildIcedGlass() {
    this.icedGlassGroup = new THREE.Group();
    this.icedGlassGroup.visible = false;

    // Tall Ribbed Glass
    const glassGeo = new THREE.CylinderGeometry(0.85, 0.72, 2.2, 48, 1, true);
    const glassMat = new THREE.MeshPhysicalMaterial({
      color: 0xffffff,
      transparent: true,
      opacity: 0.35,
      roughness: 0.08,
      transmission: 0.88,
      ior: 1.5,
      side: THREE.DoubleSide
    });
    const glassMesh = new THREE.Mesh(glassGeo, glassMat);
    this.icedGlassGroup.add(glassMesh);

    // Glass Solid Base
    const glassBaseGeo = new THREE.CylinderGeometry(0.72, 0.72, 0.16, 48);
    const glassBaseMesh = new THREE.Mesh(glassBaseGeo, glassMat);
    glassBaseMesh.position.y = -1.1;
    this.icedGlassGroup.add(glassBaseMesh);

    // Layered Iced Caramel & Milk Coffee Liquid
    const icedLiquidGeo = new THREE.CylinderGeometry(0.81, 0.69, 1.85, 48);
    const icedLiquidMat = new THREE.MeshStandardMaterial({
      color: 0xc48243, // Rich Caramel Macchiato Tone
      roughness: 0.25,
      metalness: 0.1
    });
    const icedLiquidMesh = new THREE.Mesh(icedLiquidGeo, icedLiquidMat);
    icedLiquidMesh.position.y = -0.12;
    this.icedGlassGroup.add(icedLiquidMesh);

    // Floating Ice Cubes Inside Glass
    const iceGeo = new THREE.BoxGeometry(0.38, 0.38, 0.38);
    const iceMat = new THREE.MeshPhysicalMaterial({
      color: 0xf0f8ff,
      transparent: true,
      opacity: 0.75,
      roughness: 0.05,
      transmission: 0.85
    });

    const icePositions = [
      { x: -0.25, y: 0.5, z: 0.15, rx: 0.4, ry: 0.6 },
      { x: 0.28, y: 0.62, z: -0.1, rx: 0.8, ry: 0.2 },
      { x: 0.05, y: 0.1, z: 0.28, rx: 0.3, ry: 0.9 },
      { x: -0.2, y: -0.3, z: -0.18, rx: 0.5, ry: 0.4 }
    ];

    this.iceCubes = [];
    icePositions.forEach(p => {
      const cube = new THREE.Mesh(iceGeo, iceMat);
      cube.position.set(p.x, p.y, p.z);
      cube.rotation.set(p.rx, p.ry, 0);
      this.icedGlassGroup.add(cube);
      this.iceCubes.push(cube);
    });

    this.cupPivot.add(this.icedGlassGroup);
  }

  buildCoffeeBeans() {
    this.beansGroup = new THREE.Group();
    const beanGeo = new THREE.SphereGeometry(0.18, 16, 16);
    beanGeo.scale(1.3, 0.8, 0.65); // Realistic coffee bean oval shape

    const beanMat = new THREE.MeshStandardMaterial({
      color: 0x2b1810, // Dark Roast Coffee Bean
      roughness: 0.45,
      metalness: 0.15
    });

    this.beans = [];
    const beanCount = 32;

    for (let i = 0; i < beanCount; i++) {
      const bean = new THREE.Mesh(beanGeo, beanMat);
      const angle = (i / beanCount) * Math.PI * 2 + Math.random() * 0.5;
      const radius = 1.9 + Math.random() * 2.4;
      const height = (Math.random() - 0.5) * 3.8;

      bean.position.set(
        Math.cos(angle) * radius,
        height,
        Math.sin(angle) * radius
      );

      bean.rotation.set(
        Math.random() * Math.PI,
        Math.random() * Math.PI,
        Math.random() * Math.PI
      );

      bean.castShadow = true;
      bean.userData = {
        baseY: height,
        radius: radius,
        angle: angle,
        speed: (0.15 + Math.random() * 0.25) * (Math.random() > 0.5 ? 1 : -1),
        rotSpeedX: 0.01 + Math.random() * 0.02,
        rotSpeedY: 0.015 + Math.random() * 0.02
      };

      this.beansGroup.add(bean);
      this.beans.push(bean);
    }

    this.scene.add(this.beansGroup);
  }

  buildSteamParticles() {
    this.steamGroup = new THREE.Group();
    const particleCount = 45;

    // Steam billboard particle
    const steamGeo = new THREE.PlaneGeometry(0.4, 0.4);
    
    // Procedural soft cloud texture
    const canvas = document.createElement('canvas');
    canvas.width = 128;
    canvas.height = 128;
    const ctx = canvas.getContext('2d');
    const grad = ctx.createRadialGradient(64, 64, 5, 64, 64, 64);
    grad.addColorStop(0, 'rgba(255, 248, 240, 0.65)');
    grad.addColorStop(0.5, 'rgba(230, 215, 200, 0.25)');
    grad.addColorStop(1, 'rgba(200, 180, 160, 0)');
    ctx.fillStyle = grad;
    ctx.fillRect(0, 0, 128, 128);

    const steamTex = new THREE.CanvasTexture(canvas);
    const steamMat = new THREE.MeshBasicMaterial({
      map: steamTex,
      transparent: true,
      opacity: 0.28,
      depthWrite: false,
      blending: THREE.AdditiveBlending
    });

    this.steamParticles = [];
    for (let i = 0; i < particleCount; i++) {
      const p = new THREE.Mesh(steamGeo, steamMat.clone());
      this.resetSteamParticle(p);
      p.position.y = 0.65 + Math.random() * 1.5;
      this.steamGroup.add(p);
      this.steamParticles.push(p);
    }

    this.cupPivot.add(this.steamGroup);
  }

  resetSteamParticle(p) {
    p.position.set(
      (Math.random() - 0.5) * 0.6,
      0.65,
      (Math.random() - 0.5) * 0.6
    );
    p.scale.setScalar(0.4 + Math.random() * 0.5);
    p.material.opacity = 0.35;
    p.userData = {
      vy: 0.012 + Math.random() * 0.018,
      vx: (Math.random() - 0.5) * 0.006,
      vz: (Math.random() - 0.5) * 0.006,
      vRot: (Math.random() - 0.5) * 0.02
    };
  }

  initEvents() {
    window.addEventListener('resize', () => this.onResize());

    // Mouse movement parallax
    window.addEventListener('mousemove', (e) => {
      this.mouse.targetX = (e.clientX / this.width - 0.5) * 2;
      this.mouse.targetY = -(e.clientY / this.height - 0.5) * 2;
    });

    // Scroll progress listener
    window.addEventListener('scroll', () => {
      const maxScroll = document.documentElement.scrollHeight - window.innerHeight;
      this.scrollProgress = maxScroll > 0 ? window.scrollY / maxScroll : 0;
      this.handleScrollTransition();
    });

    // Interactive Drag on 3D Container
    let startX = 0;
    let startY = 0;
    const canvasWrap = this.container;

    canvasWrap.addEventListener('mousedown', (e) => {
      this.isDragging = true;
      startX = e.clientX;
      startY = e.clientY;
    });

    window.addEventListener('mouseup', () => {
      this.isDragging = false;
    });

    window.addEventListener('mousemove', (e) => {
      if (this.isDragging) {
        const dx = e.clientX - startX;
        const dy = e.clientY - startY;
        this.cupPivot.rotation.y += dx * 0.008;
        this.cupPivot.rotation.x += dy * 0.005;
        startX = e.clientX;
        startY = e.clientY;
      }
    });

    // Touch events for mobile
    canvasWrap.addEventListener('touchstart', (e) => {
      if (e.touches.length === 1) {
        this.isDragging = true;
        startX = e.touches[0].clientX;
        startY = e.touches[0].clientY;
      }
    });

    window.addEventListener('touchend', () => {
      this.isDragging = false;
    });

    window.addEventListener('touchmove', (e) => {
      if (this.isDragging && e.touches.length === 1) {
        const dx = e.touches[0].clientX - startX;
        const dy = e.touches[0].clientY - startY;
        this.cupPivot.rotation.y += dx * 0.008;
        this.cupPivot.rotation.x += dy * 0.005;
        startX = e.touches[0].clientX;
        startY = e.touches[0].clientY;
      }
    });
  }

  onResize() {
    this.width = window.innerWidth;
    this.height = window.innerHeight;
    this.camera.aspect = this.width / this.height;
    this.camera.updateProjectionMatrix();
    this.renderer.setSize(this.width, this.height);
  }

  handleScrollTransition() {
    const p = this.scrollProgress;

    // Responsive pivot positioning
    const isMobile = this.width < 768;

    if (p < 0.2) {
      // Phase 0: Hero Section (Right anchored)
      const t = p / 0.2;
      this.cupPivot.position.x = isMobile ? 0 : 1.4 - t * 0.4;
      this.cupPivot.position.y = isMobile ? -0.4 : -0.1 + t * 0.2;
      this.cupPivot.position.z = 0 - t * 0.3;
      this.cupPivot.rotation.x = 0.35 + t * 0.3;
      this.camera.position.z = 5.8 - t * 0.8;
    } else if (p < 0.45) {
      // Phase 1: The Craft / Pour Over (Center Focus, Looking Down into Brew)
      const t = (p - 0.2) / 0.25;
      this.cupPivot.position.x = isMobile ? 0 : 1.0 - t * 1.8; // Slides towards left
      this.cupPivot.position.y = 0.1 - t * 0.3;
      this.cupPivot.rotation.x = 0.65 + t * 0.25; // Tilt to see latte art
      this.cupPivot.rotation.y = t * Math.PI * 0.7;
      this.camera.position.z = 5.0 - t * 0.6;
    } else if (p < 0.75) {
      // Phase 2: Menu & 3D Studio (Full Center Stage)
      const t = (p - 0.45) / 0.3;
      this.cupPivot.position.x = isMobile ? 0 : -0.8 + t * 0.8;
      this.cupPivot.position.y = -0.2;
      this.cupPivot.position.z = -0.3 + t * 0.5;
      this.cupPivot.rotation.x = 0.9 - t * 0.45;
      this.cupPivot.rotation.y = Math.PI * 0.7 + t * Math.PI * 0.9;
      this.camera.position.z = 4.4 + t * 0.6;
    } else {
      // Phase 3: Reviews & Visit (Atmospheric background anchor)
      const t = (p - 0.75) / 0.25;
      this.cupPivot.position.x = isMobile ? 0 : 1.2 * t;
      this.cupPivot.position.y = -0.2 - t * 0.3;
      this.cupPivot.position.z = 0.2 - t * 0.8;
      this.cupPivot.rotation.x = 0.45;
      this.camera.position.z = 5.0 + t * 1.2;
    }
  }

  // Public Methods for Customizer UI
  setCupType(type) {
    this.currentCupType = type;
    if (type === 'iced_ribbed') {
      this.ceramicCupGroup.visible = false;
      this.icedGlassGroup.visible = true;
      this.steamGroup.visible = false;
    } else {
      this.ceramicCupGroup.visible = true;
      this.icedGlassGroup.visible = false;
      this.steamGroup.visible = this.steamEnabled;
    }
  }

  setLatteArt(art) {
    this.currentArt = art;
    if (this.liquidMesh) {
      this.latteArtTexture = this.createLatteArtTexture(art);
      this.liquidMesh.material.map = this.latteArtTexture;
      this.liquidMesh.material.needsUpdate = true;
    }
  }

  setSteam(enabled) {
    this.steamEnabled = enabled;
    if (this.steamGroup) {
      this.steamGroup.visible = enabled && this.currentCupType !== 'iced_ribbed';
    }
  }

  setBeanSpeed(speed) {
    this.beanSpeedMultiplier = speed;
  }

  resetCamera() {
    gsap.to(this.cupPivot.rotation, { x: 0.35, y: 0, z: 0, duration: 1, ease: 'power2.out' });
    gsap.to(this.camera.position, { x: 0, y: 1.2, z: 5.8, duration: 1, ease: 'power2.out' });
  }

  animate() {
    requestAnimationFrame(() => this.animate());

    const delta = this.clock.getDelta();
    const time = this.clock.getElapsedTime();

    // Smooth Mouse Parallax Interpolation
    this.mouse.x += (this.mouse.targetX - this.mouse.x) * 0.05;
    this.mouse.y += (this.mouse.targetY - this.mouse.y) * 0.05;

    // Apply gentle idle tilt if not dragging
    if (!this.isDragging) {
      this.cupPivot.rotation.y += 0.004;
      this.cupPivot.position.x += (this.mouse.x * 0.15 - (this.cupPivot.position.x - (this.width < 768 ? 0 : 1.2))) * 0.02;
      this.cupPivot.position.y += Math.sin(time * 1.5) * 0.001;
    }

    // Floating 3D Coffee Beans Animation
    if (this.beans) {
      this.beans.forEach((b) => {
        b.userData.angle += b.userData.speed * delta * this.beanSpeedMultiplier;
        b.position.x = Math.cos(b.userData.angle) * b.userData.radius;
        b.position.z = Math.sin(b.userData.angle) * b.userData.radius;
        b.position.y = b.userData.baseY + Math.sin(time * 2 + b.userData.angle) * 0.18;
        b.rotation.x += b.userData.rotSpeedX;
        b.rotation.y += b.userData.rotSpeedY;
      });
    }

    // Steam Simulation
    if (this.steamEnabled && this.steamParticles && this.steamGroup.visible) {
      this.steamParticles.forEach((p) => {
        p.position.y += p.userData.vy;
        p.position.x += Math.sin(time * 3 + p.position.y * 4) * 0.003 + p.userData.vx;
        p.position.z += Math.cos(time * 3 + p.position.y * 4) * 0.003 + p.userData.vz;
        p.rotation.z += p.userData.vRot;

        // Fade out as it climbs
        const progress = (p.position.y - 0.65) / 1.8;
        p.material.opacity = Math.max(0, (1 - progress) * 0.32);
        p.scale.setScalar(0.4 + progress * 0.8);

        if (p.position.y > 2.45 || p.material.opacity <= 0.01) {
          this.resetSteamParticle(p);
        }
      });
    }

    // Liquid Ripple Wave Pulse
    if (this.rippleMesh) {
      const ripplePhase = (time * 1.2) % 3;
      if (ripplePhase < 1.4) {
        this.rippleMesh.scale.setScalar(1 + ripplePhase * 2.8);
        this.rippleMesh.material.opacity = (1 - ripplePhase / 1.4) * 0.45;
      } else {
        this.rippleMesh.material.opacity = 0;
      }
    }

    // Render Scene
    this.renderer.render(this.scene, this.camera);
  }
}

// Global scene instance attached on DOM ready
window.dryp3D = null;
window.addEventListener('DOMContentLoaded', () => {
  window.dryp3D = new DrypCoffeeScene();
});
