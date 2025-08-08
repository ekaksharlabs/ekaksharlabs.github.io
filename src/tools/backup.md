<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EkLabs - Pioneering Industrial AI and Vision Systems</title>
    
    <!-- Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        /* Apply custom font and enable smooth scrolling */
        html {
            scroll-behavior: smooth;
        }
        body {
            font-family: 'Inter', sans-serif;
            color: white;
        }

        /* Create a container for scroll-snapping */
        .scroll-container {
            scroll-snap-type: y mandatory;
            overflow-y: scroll;
            height: 100vh;
        }

        /* Define where each section should snap */
        .scroll-section {
            scroll-snap-align: start;
        }

        /* Style for the video background container */
        .video-background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -2; /* Behind everything */
        }
        
        /* Style for each individual video */
        .video-background video {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover; /* Cover the entire area */
            opacity: 0; /* Hidden by default */
            transition: opacity 1s ease-in-out; /* Smooth fade transition */
        }

        /* Class to make a video visible */
        .video-background video.active {
            opacity: 1;
        }
        
        /* Dark overlay to ensure text is always readable */
        .dark-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.65); /* 65% black overlay */
            z-index: -1;
        }

        /* --- Updated CSS for the flip card effect --- */
        .flip-card {
            background-color: transparent;
            width: 280px; /* Made cards slightly smaller */
            height: 380px;
            perspective: 1000px; /* 3D effect */
            transition: transform 0.2s ease-in-out;
        }
        
        /* Add a subtle scale effect on hover */
        .flip-card:hover {
            transform: scale(1.05);
        }

        .flip-card-inner {
            position: relative;
            width: 100%;
            height: 100%;
            text-align: center;
            transition: transform 0.8s;
            transform-style: preserve-3d;
        }

        .flip-card:hover .flip-card-inner {
            transform: rotateY(180deg);
        }

        .flip-card-front, .flip-card-back {
            position: absolute;
            width: 100%;
            height: 100%;
            -webkit-backface-visibility: hidden; /* Safari */
            backface-visibility: hidden;
            border-radius: 0.75rem; /* rounded-xl */
            overflow: hidden;
            box-shadow: 0 10px 20px rgba(0,0,0,0.25); /* Add shadow for depth */
        }

        .flip-card-front {
            background-color: rgba(6, 9, 14, 0.8); /* gray-800 with transparency */
            backdrop-filter: blur(4px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .flip-card-back {
            /* Use a gradient for a more beautiful look */
            background-image: linear-gradient(to top right, #001b46, #af4000);
            color: white;
            transform: rotateY(180deg);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
    </style>
</head>
<body class="bg-black antialiased overflow-hidden">

    <!-- Container for all background videos -->
    <div class="video-background">
        <video id="video1" class="active" autoplay loop muted playsinline>
            <source src="./assets/videos/fireball_small.mp4" type="video/mp4">
        </video>
        <video id="video2" autoplay loop muted playsinline>
            <source src="./assets/videos/thermal.mp4" type="video/mp4">
        </video>
        <video id="video3" autoplay loop muted playsinline>
            <source src="./assets/videos/motion.mp4" type="video/mp4">
        </video>
        <video id="video4" autoplay loop muted playsinline>
            <source src="./assets/videos/robo.mp4" type="video/mp4">
        </video>
        <video id="video5" autoplay loop muted playsinline>
            <source src="./assets/videos/teams.mp4" type="video/mp4">
        </video>
        <video id="video6" autoplay loop muted playsinline>
            <source src="./assets/videos/career.mp4" type="video/mp4">
        </video>
    </div>

    <!-- Dark overlay for text readability -->
    <div class="dark-overlay"></div>

    <!-- Scrollable container for all content sections -->
    <div id="scroll-container" class="scroll-container">

        <!-- Header (fixed position) -->
        <header class="fixed top-0 left-0 right-0 z-10 py-8 px-8 sm:px-12 lg:px-16">
            <nav class="flex justify-between items-center">
                <a href="#home" class="text-xl font-bold tracking-widest uppercase">EkLabs</a>
                <ul class="hidden md:flex items-center space-x-8">
                    <li><a href="#vision" class="text-base text-gray-200 hover:text-white transition-colors">Vision</a></li>
                    <li><a href="#hyperspectral" class="text-base text-gray-200 hover:text-white transition-colors">Hyperspectral</a></li>
                    <li><a href="#robotics" class="text-base text-gray-200 hover:text-white transition-colors">Robotics</a></li>
                    <li><a href="#team" class="text-base text-gray-200 hover:text-white transition-colors">Our Team</a></li>
                    <li><a href="#careers" class="text-base text-gray-200 hover:text-white transition-colors">Careers</a></li>
                </ul>
            </nav>
        </header>

        <!-- Section 1: Hero -->
        <section id="home" data-video-target="video1" class="scroll-section h-screen flex items-center justify-center text-center px-4">
            <div class="max-w-5xl">
                <h1 class="text-5xl sm:text-6xl lg:text-7xl font-bold leading-tight tracking-tighter">
                    Advancing Industry<br>with Intelligent Perception
                </h1>
                <p class="mt-6 text-xl text-gray-300">
                    Pioneering AI-driven solutions for complex industrial challenges.
                </p>
            </div>
        </section>

        <!-- Section 2: Computer Vision -->
        <section id="vision" data-video-target="video2" class="scroll-section h-screen flex flex-col items-center justify-center text-center px-4">
            <div class="w-full max-w-6xl">
                <h2 class="text-4xl sm:text-5xl lg:text-6xl font-bold leading-tight tracking-tighter mb-12">
                    Mastery in<br>Computer Vision
                </h2>
                <p class="mt-6 text-lg text-gray-300 max-w-2xl mx-auto">
                    We develop robust computer vision models that automate quality control, enhance safety, and optimize production lines, turning visual data into actionable intelligence.
                </p>
                <br>
                <div class="flex flex-wrap justify-center gap-8">
                    <!-- Vision Card 1 -->
                    <div class="flip-card">
                        <div class="flip-card-inner">
                            <div class="flip-card-front flex flex-col">
                                <img src="https://placehold.co/280x285/111827/FFFFFF?text=QC" alt="Quality Inspection" class="w-full h-3/4 object-cover">
                                <h3 class="text-xl font-bold flex-grow flex items-center justify-center">Quality Inspection</h3>
                            </div>
                            <div class="flip-card-back">
                                <h3 class="text-2xl font-bold mb-2">Automated QC</h3>
                                <p>Detect defects and anomalies in real-time with superhuman accuracy, ensuring product excellence.</p>
                            </div>
                        </div>
                    </div>
                    <!-- Vision Card 2 -->
                    <div class="flip-card">
                        <div class="flip-card-inner">
                            <div class="flip-card-front flex flex-col">
                                <img src="https://placehold.co/280x285/1f2937/FFFFFF?text=Tracking" alt="Object Detection" class="w-full h-3/4 object-cover">
                                <h3 class="text-xl font-bold flex-grow flex items-center justify-center">Object Detection</h3>
                            </div>
                            <div class="flip-card-back">
                                <h3 class="text-2xl font-bold mb-2">Smart Tracking</h3>
                                <p>Identify, classify, and track objects to streamline logistics, inventory, and on-site safety protocols.</p>
                            </div>
                        </div>
                    </div>
                    <!-- Vision Card 3 -->
                    <div class="flip-card">
                        <div class="flip-card-inner">
                            <div class="flip-card-front flex flex-col">
                                <img src="https://placehold.co/280x285/374151/FFFFFF?text=Automation" alt="Process Automation" class="w-full h-3/4 object-cover">
                                <h3 class="text-xl font-bold flex-grow flex items-center justify-center">Process Automation</h3>
                            </div>
                            <div class="flip-card-back">
                                <h3 class="text-2xl font-bold mb-2">Optimize Flow</h3>
                                <p>Use visual data to monitor and automate complex manufacturing and assembly line processes.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Section 3: HyperSpectral Imaging -->
        <section id="hyperspectral" data-video-target="video3" class="scroll-section h-screen flex flex-col items-center justify-center text-center px-4">
            <div class="w-full max-w-6xl">
                <h2 class="text-4xl sm:text-5xl lg:text-6xl font-bold leading-tight tracking-tighter mb-12">
                    Beyond Human Sight<br>with Hyperspectral Imaging
                </h2>
                <p class="mt-6 text-lg text-gray-300 max-w-2xl mx-auto">
                    Our hyperspectral solutions analyze material compositions with incredible precision, enabling non-destructive testing and analysis in agriculture, manufacturing, and environmental monitoring.
                </p><br>
                <div class="flex flex-wrap justify-center gap-8">
                    <div class="flip-card">
                        <div class="flip-card-inner">
                            <div class="flip-card-front flex flex-col">
                                <!-- <img src="https://placehold.co/280x285/111827/FFFFFF?text=Case+Study" alt="Case Studies" class="w-full h-3/4 object-cover"> -->
                                <img src="./assets/images/foundry.gif" alt="Case Studies" class="w-full h-3/4 object-cover">
                                <h3 class="text-xl font-bold flex-grow flex items-center justify-center">Case Studies</h3>
                            </div>
                            <div class="flip-card-back">
                                <h3 class="text-2xl font-bold mb-2">Success Stories</h3>
                                <p>Explore how we've solved real-world industrial problems using advanced hyperspectral analysis.</p>
                            </div>
                        </div>
                    </div>
                    <div class="flip-card">
                        <div class="flip-card-inner">
                            <div class="flip-card-front flex flex-col">
                                <!-- <img src="https://placehold.co/280x285/1f2937/FFFFFF?text=Whitepaper" alt="Whitepapers" class="w-full h-3/4 object-cover"> -->
                                <img src="./assets/images/whitepaper.jpg" alt="Whitepapers" class="w-full h-3/4 object-cover">
                                <h3 class="text-xl font-bold flex-grow flex items-center justify-center">Whitepapers</h3>
                            </div>
                            <div class="flip-card-back">
                                <h3 class="text-2xl font-bold mb-2">In-Depth Research</h3>
                                <p>Read our detailed research on the latest breakthroughs in hyperspectral imaging methodologies.</p>
                            </div>
                        </div>
                    </div>
                    <div class="flip-card">
                        <div class="flip-card-inner">
                            <div class="flip-card-front flex flex-col">
                                <img src="https://placehold.co/280x285/374151/FFFFFF?text=Prototype" alt="Prototypes" class="w-full h-3/4 object-cover">
                                <h3 class="text-xl font-bold flex-grow flex items-center justify-center">Prototypes</h3>
                            </div>
                            <div class="flip-card-back">
                                <h3 class="text-2xl font-bold mb-2">See it in Action</h3>
                                <p>Discover our proof-of-concept prototypes that demonstrate the power of our technology</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Section 4: Robotics -->
        <section id="robotics" data-video-target="video4" class="scroll-section h-screen flex flex-col items-center justify-center text-center px-4">
             <div class="w-full max-w-6xl">
                <h2 class="text-4xl sm:text-5xl lg:text-6xl font-bold leading-tight tracking-tighter mb-12">
                    Intelligent Robotics<br>for a Smarter Workflow
                </h2>
                <p class="mt-6 text-lg text-gray-300 max-w-2xl mx-auto">
                    We integrate our advanced vision systems with robotic platforms to create autonomous solutions that handle complex tasks with speed, precision, and reliability.
                </p><br>
                <div class="flex flex-wrap justify-center gap-8">
                    <div class="flip-card">
                        <div class="flip-card-inner">
                            <div class="flip-card-front flex flex-col">
                                <img src="https://placehold.co/280x285/111827/FFFFFF?text=VGR" alt="Vision-Guided Robotics" class="w-full h-3/4 object-cover">
                                <h3 class="text-xl font-bold flex-grow flex items-center justify-center">Vision-Guided Robotics</h3>
                            </div>
                            <div class="flip-card-back">
                                <h3 class="text-2xl font-bold mb-2">Precision in Motion</h3>
                                <p>Empowering robots with advanced sight to perform complex pick-and-place, assembly, and navigation tasks.</p>
                            </div>
                        </div>
                    </div>
                    <div class="flip-card">
                        <div class="flip-card-inner">
                            <div class="flip-card-front flex flex-col">
                                <img src="https://placehold.co/280x285/1f2937/FFFFFF?text=Autonomous" alt="Autonomous Systems" class="w-full h-3/4 object-cover">
                                <h3 class="text-xl font-bold flex-grow flex items-center justify-center">Autonomous Systems</h3>
                            </div>
                            <div class="flip-card-back">
                                <h3 class="text-2xl font-bold mb-2">Full Autonomy</h3>
                                <p>Developing end-to-end autonomous solutions that operate intelligently and adapt to dynamic environments.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Section 5: Our Team -->
        <section id="team" data-video-target="video5" class="scroll-section h-screen flex flex-col items-center justify-center text-center px-4">
            <div class="w-full max-w-6xl">
                <h2 class="text-4xl sm:text-5xl lg:text-6xl font-bold leading-tight tracking-tighter mb-12">
                    The Minds Behind<br>the Mission
                </h2>
                <p class="mt-4 text-lg text-gray-300 max-w-2xl mx-auto mb-12">Meet the innovators and experts dedicated to pushing the boundaries of industrial AI.</p>
                <div class="flex flex-wrap justify-center gap-8">
                    <div class="flip-card">
                        <div class="flip-card-inner">
                            <div class="flip-card-front flex flex-col">
                                <!-- <img src="https://placehold.co/280x285/111827/FFFFFF?text=CEO" alt="Team Member 1" class="w-full h-3/4 object-cover"> -->
                                <img src="./assets/images/vaibhav.jpg" alt="Team Member 1" class="w-full h-3/4 object-cover">
                                <h3 class="text-xl font-bold flex-grow flex items-center justify-center">Engineering Head</h3>
                            </div>
                            <div class="flip-card-back">
                                <h3 class="text-2xl font-bold mb-2">Vaibhav</h3>
                                <p>Master architect of our robust software and hardware integrations, ensuring our solutions are scalable and reliable.</p>
                            </div>
                        </div>
                    </div>
                    <div class="flip-card">
                        <div class="flip-card-inner">
                            <div class="flip-card-front flex flex-col">
                                <!-- <img src="https://placehold.co/280x285/1f2937/FFFFFF?text=CTO" alt="Team Member 2" class="w-full h-3/4 object-cover"> -->
                                <img src="./assets/images/hrishi.jpg" alt="Team Member 2" class="w-full h-3/4 object-cover">
                                <h3 class="text-xl font-bold flex-grow flex items-center justify-center">Head of Research</h3>
                            </div>
                            <div class="flip-card-back">
                                <h3 class="text-2xl font-bold mb-2">Hrishikesh</h3>
                                <p>Expert in machine learning and robotics, driving our hyperspectral and sensor fusion research.</p>
                            </div>
                        </div>
                    </div>
                    <div class="flip-card">
                        <div class="flip-card-inner">
                            <div class="flip-card-front flex flex-col">
                                <!-- <img src="https://placehold.co/280x285/374151/FFFFFF?text=COO" alt="Team Member 3" class="w-full h-3/4 object-cover"> -->
                                <img src="./assets/images/aarti_sharma.jpg" alt="Team Member 3" class="w-full h-3/4 object-cover">
                                <h3 class="text-xl font-bold flex-grow flex items-center justify-center">Co-Founder</h3>
                            </div>
                            <div class="flip-card-back">
                                <h3 class="text-2xl font-bold mb-2">Aarti Sharma</h3>
                                <p>Deep-Tech Researcher with a passion for bridging the gap between theoretical AI and practical industrial application.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Section 6: Careers -->
        <section id="careers" data-video-target="video6" class="scroll-section h-screen flex items-center justify-center text-center px-4">
            <div class="max-w-4xl">
                <h2 class="text-4xl sm:text-5xl lg:text-6xl font-bold leading-tight tracking-tighter">
                    Shape the Future<br>With Us
                </h2>
                <p class="mt-6 text-lg text-gray-300 max-w-2xl mx-auto">
                    We are always looking for brilliant minds to join our mission. If you are a passionate Researcher or Engineer with a drive to solve real-world problems, we want to hear from you.
                </p>
                <a href="mailto:careers@eklabs.com" class="mt-8 inline-block bg-blue-600 text-white font-bold py-3 px-8 rounded-lg text-lg hover:bg-blue-700 transition-colors">
                    Reach Out
                </a>
            </div>
        </section>

    </div>

    <script>
        // This script handles changing the background video when a new section is scrolled into view.
        document.addEventListener('DOMContentLoaded', () => {
            const sections = document.querySelectorAll('.scroll-section');
            const videos = document.querySelectorAll('.video-background video');

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const videoId = entry.target.getAttribute('data-video-target');
                        videos.forEach(video => video.classList.remove('active'));
                        const targetVideo = document.getElementById(videoId);
                        if (targetVideo) {
                            targetVideo.classList.add('active');
                        }
                    }
                });
            }, {
                threshold: 0.5 
            });

            sections.forEach(section => {
                observer.observe(section);
            });
        });
    </script>
</body>
</html>
