// Hakimabad Vue 3 Application - Global State Management
// Uses Option API via CDN (vue.global.prod.js)

// Create global Vue application
const app = Vue.createApp({
  data() {
    return {
      // Site configuration
      config: {
        siteName: 'Hakimabad',
        tagline: 'Khanka-e-Mozaddedia',
        primary: '#0D5C3D',
        secondary: '#C9A227'
      },

      // Navigation state
      currentPage: 'home',
      mobileMenuOpen: false,
      megaMenuOpen: false,
      moreSheetOpen: false,
      activePage: '',

      // Lightbox state
      lightboxOpen: false,
      lightboxUrl: '',

      // New data stores
      gdriveFolders: [],
      localMedia: { audios: [], pdfs: [] },
      playlistsData: { channels: [], customPlaylists: [] },
      linksData: [],

      // Audio Player State
      audioPlayer: {
        active: false,
        isPlaying: false,
        currentTrack: null,
        currentPlaylist: [],
        currentIndex: 0,
        volume: 0.8,
        progress: 0,
        duration: 0,
        currentTime: 0,
        showPlaylist: false,
        isExpanded: true
      },

      // Audio Source (website or gdrive)
      audioSource: 'website',

      // Audio Data (loaded from JSON)
      audioData: {
        website: [],
        gdrive: []
      },

      // YouTube Data
      youtubeData: {
        videos: [],
        playlists: []
      },

      // Current playing audio element
      audioElement: null,

      // UI State
      isLoading: true,
      activeTab: 'all',

      // Search
      searchQuery: ''
    };
  },

  computed: {
    // Filtered audio based on search
    filteredAudio() {
      const source = this.audioSource === 'website' ? this.audioData.website : this.audioData.gdrive;
      if (!this.searchQuery) return source;

      return source.filter(item =>
        item.title.toLowerCase().includes(this.searchQuery.toLowerCase())
      );
    },

    // Format time helper
    formatTime(seconds) {
      if (!seconds || isNaN(seconds)) return '0:00';
      const mins = Math.floor(seconds / 60);
      const secs = Math.floor(seconds % 60);
      return `${mins}:${secs.toString().padStart(2, '0')}`;
    }
  },

  methods: {
    // Initialize app
    async init() {
      this.isLoading = true;
      await this.loadConfig();
      await this.loadAudioData();
      await this.loadYouTubeData();
      await this.loadGdriveData();
      await this.loadMediaLocal();
      await this.loadPlaylistsData();
      await this.loadLinksData();
      this.isLoading = false;

      // Initialize audio element
      this.initAudioElement();

      // Check URL for current page
      const path = window.location.pathname;
      this.detectCurrentPage(path);
    },

    // Load configuration
    async loadConfig() {
      try {
        const response = await fetch('./data/config.json');
        const data = await response.json();
        this.config = { ...this.config, ...data };
      } catch (e) {
        console.warn('Could not load config, using defaults');
      }
    },

    // Load audio data from JS files or JSON
    async loadAudioData() {
      if (window.audioData) {
        this.audioData.website = window.audioData.websiteTracks || [];
        this.audioData.gdrive = window.audioData.gdriveTracks || [];
        return;
      }
      try {
        const wsResponse = await fetch('./data/audio-website.json');
        const wsData = await wsResponse.json();
        this.audioData.website = this.flattenPlaylists(wsData.playlists || []);
      } catch (e) {
        console.warn('Could not load website audio data');
        this.audioData.website = this.getDefaultAudioData();
      }

      try {
        const gdResponse = await fetch('./data/audio-gdrive.json');
        const gdData = await gdResponse.json();
        this.audioData.gdrive = this.flattenPlaylists(gdData.playlists || []);
      } catch (e) {
        console.warn('Could not load Google Drive audio data');
        this.audioData.gdrive = [];
      }
    },

    // Flatten playlists to single array
    flattenPlaylists(playlists) {
      const tracks = [];
      playlists.forEach(playlist => {
        if (playlist.tracks) {
          playlist.tracks.forEach(track => {
            tracks.push({
              ...track,
              playlistName: playlist.name
            });
          });
        }
      });
      return tracks;
    },

    // Default audio data (fallback)
    getDefaultAudioData() {
      return [
        { id: 'ws-001', title: 'Hakimabad Monthly March 2006', url: 'http://www.hakimabad.com/mahfil/Mp3-2.52.mp3', date: '2006-03', category: 'Monthly Mahfil' },
        { id: 'ws-002', title: 'Hakimabad Monthly January 2007', url: 'http://www.hakimabad.com/mahfil/Mp3-2.59.mp3', date: '2007-01', category: 'Monthly Mahfil' },
        { id: 'ws-003', title: 'Hakimabad Annual Mahfil February 2007', url: 'http://www.hakimabad.com/mahfil/Mp3-2.62.mp3', date: '2007-02', category: 'Annual Mahfil' }
      ];
    },

    // Load YouTube data
    async loadYouTubeData() {
      try {
        const response = await fetch('./data/youtube.json');
        const data = await response.json();
        this.youtubeData.videos = data.videos || [];
        this.youtubeData.playlists = data.playlists || [];
      } catch (e) {
        console.warn('Could not load YouTube data');
        this.youtubeData.videos = [];
      }
    },

    // Initialize audio element
    initAudioElement() {
      this.audioElement = new Audio();
      this.audioElement.volume = this.audioPlayer.volume;

      // Audio events
      this.audioElement.addEventListener('timeupdate', () => {
        this.audioPlayer.currentTime = this.audioElement.currentTime;
        this.audioPlayer.progress = (this.audioElement.currentTime / this.audioElement.duration) * 100 || 0;
      });

      this.audioElement.addEventListener('loadedmetadata', () => {
        this.audioPlayer.duration = this.audioElement.duration;
      });

      this.audioElement.addEventListener('ended', () => {
        this.nextTrack();
      });

      this.audioElement.addEventListener('play', () => {
        this.audioPlayer.isPlaying = true;
      });

      this.audioElement.addEventListener('pause', () => {
        this.audioPlayer.isPlaying = false;
      });
    },

    // Play a track
    playTrack(track, playlist = null) {
      this.audioPlayer.active = true;
      this.audioPlayer.currentTrack = track;

      if (playlist) {
        this.audioPlayer.currentPlaylist = playlist;
        this.audioPlayer.currentIndex = playlist.indexOf(track);
      } else {
        // Single track mode
        this.audioPlayer.currentPlaylist = [track];
        this.audioPlayer.currentIndex = 0;
      }

      this.audioElement.src = track.url;
      this.audioElement.play().catch(e => console.warn('Playback failed:', e));
    },

    // Toggle play/pause
    togglePlay() {
      if (!this.audioPlayer.currentTrack) return;

      if (this.audioPlayer.isPlaying) {
        this.audioElement.pause();
      } else {
        this.audioElement.play();
      }
    },

    // Next track
    nextTrack() {
      if (this.audioPlayer.currentIndex < this.audioPlayer.currentPlaylist.length - 1) {
        this.audioPlayer.currentIndex++;
        this.playTrack(this.audioPlayer.currentPlaylist[this.audioPlayer.currentIndex]);
      }
    },

    // Previous track
    prevTrack() {
      if (this.audioPlayer.currentIndex > 0) {
        this.audioPlayer.currentIndex--;
        this.playTrack(this.audioPlayer.currentPlaylist[this.audioPlayer.currentIndex]);
      }
    },

    // Set volume
    setVolume(level) {
      this.audioPlayer.volume = level;
      this.audioElement.volume = level;
    },

    // Seek to position
    seekTo(percent) {
      if (this.audioPlayer.duration) {
        this.audioElement.currentTime = (percent / 100) * this.audioPlayer.duration;
      }
    },

    // Toggle playlist
    togglePlaylist() {
      this.audioPlayer.showPlaylist = !this.audioPlayer.showPlaylist;
    },

    // Toggle player expanded
    togglePlayerExpanded() {
      this.audioPlayer.isExpanded = !this.audioPlayer.isExpanded;
    },

    // Close player
    closePlayer() {
      this.audioElement.pause();
      this.audioPlayer.active = false;
      this.audioPlayer.currentTrack = null;
    },

    // Detect current page from URL
    detectCurrentPage(path) {
      const page = path.split('/').pop().replace('.html', '') || 'index';
      this.currentPage = page;
      this.activePage = page;
    },

    // Navigation
    navigateTo(page) {
      window.location.href = page;
    },

    // Mobile menu
    toggleMobileMenu() {
      this.mobileMenuOpen = !this.mobileMenuOpen;
    },

    closeMobileMenu() {
      this.mobileMenuOpen = false;
    },

    // Mega menu
    toggleMegaMenu() {
      this.megaMenuOpen = !this.megaMenuOpen;
    },

    closeMegaMenu() {
      this.megaMenuOpen = false;
    },

    // Lightbox
    openPdfLightbox(url) {
      this.lightboxUrl = url;
      this.lightboxOpen = true;
      document.body.style.overflow = 'hidden';
    },

    closeLightbox() {
      this.lightboxOpen = false;
      this.lightboxUrl = '';
      document.body.style.overflow = '';
    },

    // New data loaders
    async loadGdriveData() {
      if (window.gdriveData) {
        this.gdriveFolders = window.gdriveData.folders || [];
        return;
      }
      try {
        const res = await fetch('./data/gdrive.json');
        const data = await res.json();
        this.gdriveFolders = data.folders || [];
      } catch (e) {
        console.warn('Could not load GDrive data');
        this.gdriveFolders = [];
      }
    },

    async loadMediaLocal() {
      try {
        const res = await fetch('./data/media-local.json');
        const data = await res.json();
        this.localMedia = { audios: data.audios || [], pdfs: data.pdfs || [] };
      } catch (e) {
        console.warn('Could not load local media data');
        this.localMedia = { audios: [], pdfs: [] };
      }
    },

    async loadPlaylistsData() {
      if (window.videoData) {
        this.playlistsData = { channels: window.videoData.channels || [], customPlaylists: window.videoData.playlists || [] };
        return;
      }
      try {
        const res = await fetch('./data/playlists.json');
        const data = await res.json();
        this.playlistsData = { channels: data.channels || [], customPlaylists: data.customPlaylists || [] };
      } catch (e) {
        console.warn('Could not load playlists data');
        this.playlistsData = { channels: [], customPlaylists: [] };
      }
    },

    async loadLinksData() {
      if (window.linksData) {
        this.linksData = window.linksData;
        return;
      }
      try {
        const res = await fetch('./data/links-website.json');
        const data = await res.json();
        this.linksData = data.links || [];
      } catch (e) {
        console.warn('Could not load links data');
        this.linksData = [];
      }
    },

    // Switch audio source
    switchAudioSource(source) {
      this.audioSource = source;
    },

    // Play YouTube video
    playYouTubeVideo(videoId) {
      const player = document.getElementById('youtube-player');
      if (!player) return;
      const isFileProtocol = window.location.protocol === 'file:';
      if (isFileProtocol) {
        window.open(`https://www.youtube.com/watch?v=${videoId}`, '_blank');
        return;
      }
      player.src = `https://www.youtube-nocookie.com/embed/${videoId}`;
    }
  },

  mounted() {
    this.init();

    // Document click: close mega menu when clicking outside
    document.addEventListener('click', (e) => {
      if (!e.target.closest('.mega-menu-trigger') && !e.target.closest('.mega-dropdown')) {
        if (this.megaMenuOpen) this.closeMegaMenu();
      }
    });

    // Escape key: close lightbox
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && this.lightboxOpen) this.closeLightbox();
    });
  }
});

// Mount app
app.mount('#app');

// Export for use in components
window.hakimabadApp = app;