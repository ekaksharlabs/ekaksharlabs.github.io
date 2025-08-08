/**
 * EkLabs Website - Main JavaScript
 * Super simple, debug-focused version
 */

console.log('🔍 DEBUG: main.js file loaded');

// Wait for DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    console.log('� DEBUG: main.js DOMContentLoaded triggered');
    
    // Initialize components with debug
    initializeVideos();
    initializeScrollEffects();
    initializeInteractiveElements();
    initializeNavigation();
    initializeMobileMenu();
    initializeTeamCards();
    
    console.log('🔍 DEBUG: All main.js components initialized');
});

/**
 * VIDEO MANAGEMENT - Super Simple with Debug
 */
function initializeVideos() {
    console.log('� DEBUG: initializeVideos() called');
    
    // Get all videos
    const backgroundVideos = document.querySelectorAll('.video-background video');
    const cardVideos = document.querySelectorAll('.vision-card video, .robotics-card video');
    const heroVideo = document.getElementById('video-hero');
    
    console.log('🔍 DEBUG: Background videos found:', backgroundVideos.length);
    console.log('🔍 DEBUG: Card videos found:', cardVideos.length);
    console.log('🔍 DEBUG: Hero video:', heroVideo ? 'found' : 'not found');
    
    // Load all videos immediately
    backgroundVideos.forEach((video, index) => {
        console.log(`🔍 DEBUG: Processing background video ${index}: ${video.id}`);
        video.load();
        
        video.addEventListener('loadeddata', () => {
            console.log(`✅ DEBUG: Background video loaded: ${video.id}`);
        });
        
        video.addEventListener('error', (e) => {
            console.error(`❌ DEBUG: Background video error: ${video.id}`, e);
        });
        
        video.addEventListener('canplay', () => {
            console.log(`📺 DEBUG: Background video can play: ${video.id}`);
        });
    });
    
    cardVideos.forEach((video, index) => {
        console.log(`🔍 DEBUG: Processing card video ${index}`);
        video.load();
        
        video.addEventListener('loadeddata', () => {
            console.log(`✅ DEBUG: Card video ${index} loaded`);
        });
        
        video.addEventListener('error', (e) => {
            console.error(`❌ DEBUG: Card video ${index} error:`, e);
        });
    });
    
    // Start hero video
    if (heroVideo) {
        console.log('🔍 DEBUG: Starting hero video...');
        heroVideo.play().catch(e => {
            console.log('🔍 DEBUG: Hero video autoplay prevented:', e);
        });
    }
    
    // Set up video switching
    setupVideoSwitching();
    
    // Auto-play card videos when visible
    setupCardVideoPlayback();
}

/**
 * Video switching based on sections - with debug
 */
function setupVideoSwitching() {
    console.log('🔍 DEBUG: Setting up video switching...');
    
    const sections = document.querySelectorAll('.section[data-video]');
    const backgroundVideos = document.querySelectorAll('.video-background video');
    
    console.log('🔍 DEBUG: Sections with data-video:', sections.length);
    console.log('🔍 DEBUG: Background videos for switching:', backgroundVideos.length);
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const videoId = entry.target.getAttribute('data-video');
                console.log(`🔍 DEBUG: Section intersecting, switching to video: ${videoId}`);
                switchToVideo(videoId, backgroundVideos);
            }
        });
    }, { threshold: 0.4 });
    
    sections.forEach(section => {
        const videoId = section.getAttribute('data-video');
        console.log(`🔍 DEBUG: Observing section with video: ${videoId}`);
        observer.observe(section);
    });
}

/**
 * Switch background video - with debug
 */
function switchToVideo(videoId, allVideos) {
    console.log(`🔍 DEBUG: switchToVideo called with: ${videoId}`);
    
    if (!videoId) {
        console.log('🔍 DEBUG: No videoId provided, returning');
        return;
    }
    
    // Deactivate all videos
    allVideos.forEach(video => {
        video.classList.remove('active');
        if (video.id !== videoId) {
            video.pause();
            console.log(`⏸️ DEBUG: Paused video: ${video.id}`);
        }
    });
    
    // Activate target video
    const targetVideo = document.getElementById(videoId);
    if (targetVideo) {
        targetVideo.classList.add('active');
        targetVideo.play().catch(e => {
            console.log(`🔍 DEBUG: Video play prevented for ${videoId}:`, e);
        });
        console.log(`🎬 DEBUG: Switched to video: ${videoId}`);
    } else {
        console.error(`❌ DEBUG: Target video not found: ${videoId}`);
    }
}

/**
 * Card video playback - with debug
 */
function setupCardVideoPlayback() {
    console.log('🔍 DEBUG: Setting up card video playback...');
    
    const cardVideos = document.querySelectorAll('.vision-card video, .robotics-card video');
    console.log('🔍 DEBUG: Card videos for playback:', cardVideos.length);
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            const video = entry.target;
            if (entry.isIntersecting) {
                console.log('🔍 DEBUG: Card video entering viewport, playing...');
                video.play().catch(e => {
                    console.log('🔍 DEBUG: Card video play prevented:', e);
                });
            } else {
                console.log('🔍 DEBUG: Card video leaving viewport, pausing...');
                video.pause();
            }
        });
    }, { threshold: 0.3 });
    
    cardVideos.forEach(video => observer.observe(video));
}

/**
 * SCROLL EFFECTS
 * Animations and effects triggered by scrolling
 */
function initializeScrollEffects() {
    console.log('📜 Setting up scroll effects...');
    
    // Scroll reveal animations
    setupScrollReveal();
    
    // Counter animations
    setupCounterAnimations();
    
    // Parallax effects
    setupParallaxEffects();
}

/**
 * Set up scroll reveal animations
 */
function setupScrollReveal() {
    const revealElements = document.querySelectorAll('.scroll-reveal, .scroll-reveal-left, .scroll-reveal-right');
    
    const revealObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('active');
            }
        });
    }, {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    });
    
    // Add staggered delays for multiple elements
    revealElements.forEach((element, index) => {
        element.style.transitionDelay = `${index * 0.1}s`;
        revealObserver.observe(element);
    });
}

/**
 * Set up counter animations
 */
function setupCounterAnimations() {
    const counters = document.querySelectorAll('.stat-counter');
    
    const counterObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const counter = entry.target;
                const target = parseInt(counter.getAttribute('data-target'));
                animateCounter(counter, target);
                counterObserver.unobserve(counter);
            }
        });
    }, { threshold: 0.5 });
    
    counters.forEach(counter => counterObserver.observe(counter));
}

/**
 * Animate counter from 0 to target value
 */
function animateCounter(element, target) {
    let current = 0;
    const increment = target / 60; // 60 steps for smooth animation
    const duration = 2000; // 2 seconds
    const stepTime = duration / 60;
    
    const timer = setInterval(() => {
        current += increment;
        if (current >= target) {
            current = target;
            clearInterval(timer);
        }
        element.textContent = Math.floor(current);
    }, stepTime);
}

/**
 * Set up parallax effects
 */
function setupParallaxEffects() {
    const parallaxElements = document.querySelectorAll('.parallax');
    
    if (parallaxElements.length > 0) {
        let ticking = false;
        
        function updateParallax() {
            const scrolled = window.pageYOffset;
            
            parallaxElements.forEach(element => {
                const speed = 0.5;
                const yPos = -(scrolled * speed);
                element.style.transform = `translateY(${yPos}px)`;
            });
            
            ticking = false;
        }
        
        window.addEventListener('scroll', () => {
            if (!ticking) {
                requestAnimationFrame(updateParallax);
                ticking = true;
            }
        });
    }
}

/**
 * INTERACTIVE ELEMENTS
 * Mouse interactions and dynamic effects
 */
function initializeInteractiveElements() {
    console.log('🎯 Setting up interactive elements...');
    
    // Interactive blob movement
    setupBlobInteraction();
}

/**
 * Set up interactive blob movement based on mouse position
 */
function setupBlobInteraction() {
    const blob1 = document.getElementById('blob1');
    const blob2 = document.getElementById('blob2');
    const blob3 = document.getElementById('blob3');
    
    if (blob1 && blob2 && blob3) {
        let ticking = false;
        
        function updateBlobs(clientX, clientY) {
            const { innerWidth, innerHeight } = window;
            const xPos = (clientX / innerWidth) - 0.5;
            const yPos = (clientY / innerHeight) - 0.5;
            
            blob1.style.transform = `translate(${clientX - 200 + xPos * 50}px, ${clientY - 200 + yPos * 50}px)`;
            blob2.style.transform = `translate(${clientX - 100 - xPos * 30}px, ${clientY - 100 - yPos * 30}px)`;
            blob3.style.transform = `translate(${clientX - 150 + xPos * 70}px, ${clientY - 150 + yPos * 70}px)`;
            
            ticking = false;
        }
        
        document.addEventListener('mousemove', (e) => {
            if (!ticking) {
                requestAnimationFrame(() => updateBlobs(e.clientX, e.clientY));
                ticking = true;
            }
        });
    }
}

/**
 * NAVIGATION
 * Smooth scrolling and navigation functionality
 */
function initializeNavigation() {
    console.log('🧭 Setting up navigation...');
    
    // Smooth scrolling for anchor links
    const anchorLinks = document.querySelectorAll('a[href^="#"]');
    
    anchorLinks.forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
}

/**
 * MOBILE MENU
 * Toggle the mobile dropdown menu on small screens
 */
function initializeMobileMenu() {
    try {
        const menuButton = document.querySelector('nav button.md\\:hidden');
        const mobileMenu = document.getElementById('mobile-menu');

        if (!menuButton || !mobileMenu) {
            console.log('🧭 Mobile menu elements not found (this page may not use mobile menu)');
            return;
        }

        menuButton.addEventListener('click', () => {
            mobileMenu.classList.toggle('hidden');
        });

        // Close menu on link click
        mobileMenu.querySelectorAll('a').forEach(a => {
            a.addEventListener('click', () => mobileMenu.classList.add('hidden'));
        });

        // Reset state on resize to desktop
        window.addEventListener('resize', () => {
            if (window.innerWidth >= 768) {
                mobileMenu.classList.add('hidden');
            }
        });
    } catch (e) {
        console.warn('Mobile menu init error:', e);
    }
}

/**
 * TEAM CARDS
 * Make profile cards clickable if data-url is set and apply hover affordances
 */
function initializeTeamCards() {
    const cards = document.querySelectorAll('.team-card');
    if (cards.length === 0) return;

    cards.forEach(card => {
        const url = card.getAttribute('data-url');
        if (url) {
            card.style.cursor = 'pointer';
            card.setAttribute('role', 'link');
            card.setAttribute('tabindex', '0');
            card.addEventListener('click', () => {
                window.open(url, '_blank', 'noopener');
            });
            card.addEventListener('keydown', (e) => {
                if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    window.open(url, '_blank', 'noopener');
                }
            });
        }
    });
}

// Debug exports (simplified)
window.EkLabsDebug = {
    switchToVideo,
    animateCounter
};
