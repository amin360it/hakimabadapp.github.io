# Implementation Plan Part 2 — Mega Dropdown Nav + Media Hub

> **Execution order:** Run each step sequentially. Each sub-step must be done before moving to the next.
> **Status codes:** `[ ]` = pending, `[~]` = in progress, `[x]` = done

---

## Step 1: CSS — Mega Dropdown + Lightbox + Modern Components
**File:** `css/styles.css`

### 1.1 Mega Dropdown Base Container
- [ ] 1.1.1 Add `.mega-dropdown` class: `position: absolute; top: 100%; left: 0; width: 100%; background: #fff; box-shadow: 0 8px 30px rgba(0,0,0,0.15); border-radius: 0 0 12px 12px; z-index: 1000; display: none;`
- [ ] 1.1.2 Add `.mega-dropdown.show`: `display: block; animation: fadeInDown 0.3s ease;`
- [ ] 1.1.3 Add `@keyframes fadeInDown`: `from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); }`
- [ ] 1.1.4 Add navbar position context: ensure `.navbar` has `position: relative;` so mega dropdown anchors correctly

### 1.2 Mega Dropdown Grid Layout
- [ ] 1.2.1 Add `.mega-dropdown-inner`: `display: grid; grid-template-columns: repeat(4, 1fr); gap: 2rem; padding: 2rem; max-width: 1200px; margin: 0 auto;`
- [ ] 1.2.2 Add `.mega-dropdown-col`: `display: flex; flex-direction: column; gap: 0.5rem;`
- [ ] 1.2.3 Add `.mega-dropdown-category`: `font-family: 'Amiri', serif; font-size: 1.1rem; color: var(--primary); font-weight: 700; border-bottom: 2px solid var(--secondary); padding-bottom: 0.5rem; margin-bottom: 0.5rem;`
- [ ] 1.2.4 Add `.mega-dropdown-links`: `list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 0.25rem;`
- [ ] 1.2.5 Add `.mega-dropdown-links li a`: `color: var(--text-dark); text-decoration: none; padding: 0.5rem 0.75rem; border-radius: 6px; font-size: 0.9rem; display: block; transition: all 0.2s;`
- [ ] 1.2.6 Add `.mega-dropdown-links li a:hover`: `background: var(--background-alt); color: var(--primary); padding-left: 1rem;`

### 1.3 Mega Dropdown Nav Trigger
- [ ] 1.3.1 Add `.mega-menu-trigger`: `position: static;` (allows full-width dropdown)
- [ ] 1.3.2 Add `.nav-item`: `position: relative; display: inline-block;`
- [ ] 1.3.3 Add `.arrow`: `font-size: 0.7rem; margin-left: 0.25rem; transition: transform 0.3s;`
- [ ] 1.3.4 Add `.mega-menu-trigger.active .arrow`: `transform: rotate(180deg);`
- [ ] 1.3.5 Add `.navbar-links a.active-page`: `color: var(--secondary);` for current page indicator

### 1.4 Lightbox Overlay
- [ ] 1.4.1 Add `.lightbox-overlay`: `position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; background: rgba(0,0,0,0.85); z-index: 10000; display: flex; align-items: center; justify-content: center; animation: fadeIn 0.3s;`
- [ ] 1.4.2 Add `@keyframes fadeIn`: `from { opacity: 0; } to { opacity: 1; }`
- [ ] 1.4.3 Add `.lightbox-content`: `position: relative; width: 90vw; max-width: 900px; height: 85vh; background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 20px 60px rgba(0,0,0,0.3);`
- [ ] 1.4.4 Add `.lightbox-content iframe`: `width: 100%; height: 100%; border: none;`
- [ ] 1.4.5 Add `.lightbox-close`: `position: absolute; top: 1rem; right: 1rem; width: 40px; height: 40px; background: rgba(0,0,0,0.5); color: white; border: none; border-radius: 50%; font-size: 1.5rem; cursor: pointer; z-index: 10; display: flex; align-items: center; justify-content: center; transition: background 0.2s;`
- [ ] 1.4.6 Add `.lightbox-close:hover`: `background: rgba(0,0,0,0.8);`
- [ ] 1.4.7 Add responsive rules: `@media (max-width: 768px) { .lightbox-content { width: 95vw; height: 60vh; } }`

### 1.5 Modern Component — Stat Cards
- [ ] 1.5.1 Add `.stat-card`: `background: white; border-radius: 12px; padding: 2rem; text-align: center; box-shadow: 0 4px 20px rgba(0,0,0,0.08); transition: transform 0.3s, box-shadow 0.3s;`
- [ ] 1.5.2 Add `.stat-card:hover`: `transform: translateY(-6px); box-shadow: 0 8px 30px rgba(0,0,0,0.12);`
- [ ] 1.5.3 Add `.stat-number`: `font-size: 2.5rem; font-weight: 800; color: var(--primary); font-family: 'Amiri', serif;`
- [ ] 1.5.4 Add `.stat-label`: `font-size: 0.9rem; color: #666; margin-top: 0.25rem;`

### 1.6 Modern Component — Testimonial/Quote Cards
- [ ] 1.6.1 Add `.testimonial-card`: `background: var(--background-alt); border-radius: 12px; padding: 2rem; border-left: 4px solid var(--secondary); position: relative;`
- [ ] 1.6.2 Add `.testimonial-card::before`: `content: '"'; font-size: 4rem; color: var(--secondary); opacity: 0.3; position: absolute; top: 0.5rem; left: 1rem; font-family: 'Amiri', serif;`
- [ ] 1.6.3 Add `.testimonial-text`: `font-style: italic; line-height: 1.8; color: var(--text-dark);`
- [ ] 1.6.4 Add `.testimonial-author`: `font-weight: 700; color: var(--primary); margin-top: 1rem;`

### 1.7 Modern Component — Feature Icon Grid
- [ ] 1.7.1 Add `.feature-grid`: `display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 1.5rem;`
- [ ] 1.7.2 Add `.feature-item`: `text-align: center; padding: 1.5rem; background: white; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.06); transition: all 0.3s;`
- [ ] 1.7.3 Add `.feature-item:hover`: `transform: scale(1.03); box-shadow: 0 4px 20px rgba(0,0,0,0.1);`
- [ ] 1.7.4 Add `.feature-icon`: `font-size: 2.5rem; margin-bottom: 0.75rem;`
- [ ] 1.7.5 Add `.feature-title`: `font-weight: 600; color: var(--text-dark); font-size: 1rem;`

### 1.8 Modern Component — Section Decorations
- [ ] 1.8.1 Add `.section-divider`: `width: 80px; height: 3px; background: linear-gradient(90deg, var(--primary), var(--secondary)); margin: 1rem auto; border-radius: 2px;`
- [ ] 1.8.2 Add `.bg-pattern-dots`: `background-image: radial-gradient(var(--primary) 1px, transparent 1px); background-size: 20px 20px; opacity: 0.05;`
- [ ] 1.8.3 Add `.glass-card`: `background: rgba(255,255,255,0.8); backdrop-filter: blur(10px); border: 1px solid rgba(255,255,255,0.2);`

### 1.9 Modern Component — Hover & Animation Utilities
- [ ] 1.9.1 Add `.hover-lift`: `transition: transform 0.3s, box-shadow 0.3s;`
- [ ] 1.9.2 Add `.hover-lift:hover`: `transform: translateY(-4px); box-shadow: 0 8px 25px rgba(0,0,0,0.1);`
- [ ] 1.9.3 Add `.animate-fade-in`: `animation: fadeInUp 0.6s ease both;`
- [ ] 1.9.4 Add `@keyframes fadeInUp`: `from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); }`
- [ ] 1.9.5 Add `.animate-delay-1`: `animation-delay: 0.1s;`
- [ ] 1.9.6 Add `.animate-delay-2`: `animation-delay: 0.2s;`
- [ ] 1.9.7 Add `.animate-delay-3`: `animation-delay: 0.3s;`

### 1.10 Modern Font Updates
- [ ] 1.10.1 Add Inter font import in CSS `@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');`
- [ ] 1.10.2 Update `body` font stack: `font-family: 'Inter', 'Noto Sans', 'Noto Sans Bengali', sans-serif;`
- [ ] 1.10.3 Update heading styles: `font-weight: 700; letter-spacing: -0.02em;`
- [ ] 1.10.4 Add `.font-inter` utility class

### 1.11 Mobile Responsive Mega Dropdown
- [ ] 1.11.1 Add `@media (max-width: 768px) { .mega-dropdown-inner { grid-template-columns: 1fr 1fr; gap: 1rem; padding: 1rem; } }`
- [ ] 1.11.2 Add `@media (max-width: 480px) { .mega-dropdown-inner { grid-template-columns: 1fr; } }`

---

## Step 2: JS — Global App Enhancements
**File:** `js/app.js`

### 2.1 Mega Menu State (in `data()`)
- [ ] 2.1.1 Add `megaMenuOpen: false`

### 2.2 Lightbox State (in `data()`)
- [ ] 2.2.1 Add `lightboxOpen: false`
- [ ] 2.2.2 Add `lightboxUrl: ''`

### 2.3 New Data Arrays (in `data()`)
- [ ] 2.3.1 Add `gdriveFolders: []` (for `data/gdrive.json`)
- [ ] 2.3.2 Add `localMedia: { audios: [], pdfs: [] }` (for `data/media-local.json`)
- [ ] 2.3.3 Add `playlistsData: { channels: [], customPlaylists: [] }` (for `data/playlists.json`)
- [ ] 2.3.4 Add `linksData: []` (for `data/links-website.json`)

### 2.4 Mega Menu Methods
- [ ] 2.4.1 Add `toggleMegaMenu()`: `this.megaMenuOpen = !this.megaMenuOpen;`
- [ ] 2.4.2 Add `closeMegaMenu()`: `this.megaMenuOpen = false;`
- [ ] 2.4.3 Add document click handler in `mounted()`:
  ```js
  document.addEventListener('click', (e) => {
    if (!e.target.closest('.mega-menu-trigger') && !e.target.closest('.mega-dropdown')) {
      this.closeMegaMenu();
    }
  });
  ```

### 2.5 Lightbox Methods
- [ ] 2.5.1 Add `openPdfLightbox(url)`: `this.lightboxUrl = url; this.lightboxOpen = true; document.body.style.overflow = 'hidden';`
- [ ] 2.5.2 Add `closeLightbox()`: `this.lightboxOpen = false; this.lightboxUrl = ''; document.body.style.overflow = '';`
- [ ] 2.5.3 Add Escape key listener in `mounted()`: `document.addEventListener('keydown', (e) => { if (e.key === 'Escape' && this.lightboxOpen) this.closeLightbox(); });`

### 2.6 Data Loader Methods
- [ ] 2.6.1 Add `async loadGdriveData()` — fetch `./data/gdrive.json` → `this.gdriveFolders`
- [ ] 2.6.2 Add `async loadMediaLocal()` — fetch `./data/media-local.json` → `this.localMedia`
- [ ] 2.6.3 Add `async loadPlaylistsData()` — fetch `./data/playlists.json` → `this.playlistsData`
- [ ] 2.6.4 Add `async loadLinksData()` — fetch `./data/links-website.json` → `this.linksData`
- [ ] 2.6.5 Wire all new loaders into `init()` method

### 2.7 Enhanced YouTube Multi-Channel Support
- [ ] 2.7.1 In `loadYouTubeData()`, update to expect `channels` array in `data.youtube.json`
- [ ] 2.7.2 Add `activeChannelId: null` in `data()`
- [ ] 2.7.3 Add `switchChannel(channelId)` method: sets `activeChannelId`, resets pagination
- [ ] 2.7.4 Update `init()` to call `switchChannel()` with first channel by default

### 2.8 Navbar Active Page Detection Enhancement
- [ ] 2.8.1 In `detectCurrentPage(path)`, add logic to set `.active-page` class on matching nav link
- [ ] 2.8.2 Add `activePage: ''` in `data()`
- [ ] 2.8.3 After detecting page, set `this.activePage` (e.g., `'index'`, `'about'`, etc.)

---

## Step 3: Create Data Files (4 new + 2 updates)

### 3.1 Create `data/gdrive.json`
- [ ] 3.1.1 Add folder `1kRaDLvS8OIprShsyNzJf0Msv7TYOgDG0` → name: "Hakimabad_App", autoCategory: "mixed"
- [ ] 3.1.2 Add folder `1LmnqgT3uwPhPwhmbdKXps5CX_smb2KZ7` → name: "The_Path_App", autoCategory: "books"
- [ ] 3.1.3 Add folder `12yPt9wY2H0aEr2wRTM8bWBGgtddspysv` → name: "Audio", autoCategory: "audio"

### 3.2 Create `data/media-local.json`
- [ ] 3.2.1 Verify actual files in `media/audios/` listing exact filenames
- [ ] 3.2.2 Verify actual files in `media/The_Path/` listing exact filenames
- [ ] 3.2.3 Write JSON with `"audios"` array (title + file path)
- [ ] 3.2.4 Write JSON with `"pdfs"` array (title + file path)

### 3.3 Create `data/links-website.json`
- [ ] 3.3.1 Categorize links from `Hakimabad- Important Links.html` into groups
- [ ] 3.3.2 Write JSON array of objects with `{ title, url, category, description }`

### 3.4 Create `data/playlists.json`
- [ ] 3.4.1 Add channel 1: "mahfil live", id: "UCXuFIrgi5aYbAm3gVNl5-3A", uploadPlaylistId: "UUXuFIrgi5aYbAm3gVNl5-3A"
- [ ] 3.4.2 Add channel 2: "hakimabad dot com", id: "UC34wiyCiKwn3gxFRMaut1Ww", uploadPlaylistId: "UU34wiyCiKwn3gxFRMaut1Ww"
- [ ] 3.4.3 Add `customPlaylists` array with titles + placeholder listIds

### 3.5 Update `data/audio-website.json`
- [ ] 3.5.1 Read mahfils.html reference data
- [ ] 3.5.2 Add 5 new playlists: Sirajgonj 2008, Garo Pahar 2008, Goran 2008, Shirajgonj 2007, Hakimabad Monthly Jan 2008
- [ ] 3.5.3 Add all track entries under each new playlist with correct URLs

### 3.6 Update `data/youtube.json`
- [ ] 3.6.1 Restructure to use `"channels"` array instead of flat list
- [ ] 3.6.2 Move existing 51 videos under channel "mahfil live"
- [ ] 3.6.3 Add channel 2 "hakimabad dot com" with its 8 videos and thumbnails

---

## Step 4: Mega Dropdown Navbar — Apply to All 14 Pages

### 4.1 Mega Dropdown HTML Template (reusable snippet)
- [ ] 4.1.1 Build the mega dropdown `<li>` as described in previous plan section 3a
- [ ] 4.1.2 Replace the old flat `navbar-links` Media `<a>` with the mega dropdown structure
- [ ] 4.1.3 Add Vue binding `:class="{ show: megaMenuOpen }"` on `.mega-dropdown`
- [ ] 4.1.4 Add active page class: `:class="{ active: activePage === 'page-name' }"` on each nav link
- [ ] 4.1.5 Update mobile menu to include all media sub-links (audio, video, books, links)

### 4.2 Apply to index.html
- [ ] 4.2.1 Update `navbar-links` div with mega dropdown
- [ ] 4.2.2 Update mobile menu with additional links
- [ ] 4.2.3 Verify Vue app mounts correctly

### 4.3 Apply to about.html
- [ ] 4.3.1 Update navbar-links
- [ ] 4.3.2 Update mobile menu
- [ ] 4.3.3 Update Vue app to include `megaMenuOpen` data

### 4.4 Apply to audio-website.html
- [ ] 4.4.1 Update navbar-links
- [ ] 4.4.2 Update mobile menu
- [ ] 4.4.3 Merge app data: add `megaMenuOpen` to existing Vue app

### 4.5 Apply to video.html
- [ ] 4.5.1 Update navbar-links
- [ ] 4.5.2 Update mobile menu
- [ ] 4.5.3 Merge app data: add `megaMenuOpen` to existing Vue app

### 4.6 Apply to books.html
- [ ] 4.6.1 Update navbar-links
- [ ] 4.6.2 Update mobile menu
- [ ] 4.6.3 Merge app data: add `megaMenuOpen` to existing Vue app

### 4.7 Apply to events.html
- [ ] 4.7.1 Update navbar-links
- [ ] 4.7.2 Update mobile menu
- [ ] 4.7.3 Add `megaMenuOpen` to Vue data

### 4.8 Apply to path.html
- [ ] 4.8.1 Update navbar-links
- [ ] 4.8.2 Update mobile menu
- [ ] 4.8.3 Add `megaMenuOpen` to Vue data

### 4.9 Apply to tarika.html
- [ ] 4.9.1 Update navbar-links
- [ ] 4.9.2 Update mobile menu
- [ ] 4.9.3 Add `megaMenuOpen` to Vue data

### 4.10 Apply to contact.html
- [ ] 4.10.1 Update navbar-links
- [ ] 4.10.2 Update mobile menu
- [ ] 4.10.3 Add `megaMenuOpen` to Vue data

### 4.11 Apply to blog.html
- [ ] 4.11.1 Update navbar-links — add 12+ links
- [ ] 4.11.2 Update mobile menu
- [ ] 4.11.3 Add `megaMenuOpen` to Vue data

### 4.12 Apply to qa.html
- [ ] 4.12.1 Update navbar-links — add 12+ links
- [ ] 4.12.2 Update mobile menu
- [ ] 4.12.3 Add `megaMenuOpen` to Vue data

### 4.13 Apply to links.html
- [ ] 4.13.1 Update navbar-links
- [ ] 4.13.2 Update mobile menu
- [ ] 4.13.3 Add `megaMenuOpen` + `linksData` to Vue data

### 4.14 Apply to audio-gdrive.html
- [ ] 4.14.1 Update navbar-links
- [ ] 4.14.2 Update mobile menu
- [ ] 4.14.3 Add `megaMenuOpen` to Vue data

---

## Step 5: Update `index.html` — PDF Lightbox + Modern Hero + Stats

### 5.1 PDF Lightbox Section
- [ ] 5.1.1 Add `<section id="path-pdfs">` after the Leadership section (before Events Preview)
- [ ] 5.1.2 Add 4 PDF cards in 2×2 grid, each with icon + title + @click handler
- [ ] 5.1.3 Load `localMedia.pdfs` from vue data
- [ ] 5.1.4 Bind `@click="openPdfLightbox(pdf.file)"` on each card
- [ ] 5.1.5 Add `<div class="lightbox-overlay">` with `v-if="lightboxOpen"` and `@click.self`
- [ ] 5.1.6 Add `<button class="lightbox-close">` inside overlay
- [ ] 5.1.7 Add `<div class="lightbox-content">` with `<iframe :src="lightboxUrl">`

### 5.2 Modern Hero Section Enhancement
- [ ] 5.2.1 Add stat row below hero: 3 `.stat-card` items (51+ Videos, 50+ Audio, 80+ Books)
- [ ] 5.2.2 Add `v-for` rendering with stagger animation classes
- [ ] 5.2.3 Add decorative section divider after hero

### 5.3 Feature Grid Section (new)
- [ ] 5.3.1 Add 6-item feature grid: Audio, Video, Books, Events, The Path, Tarika
- [ ] 5.3.2 Each feature item: icon + title + short description + link
- [ ] 5.3.3 Use `.feature-grid` and `.feature-item` classes

### 5.4 Testimonial Section (new)
- [ ] 5.4.1 Add 2 testimonial cards with Islamic quotes
- [ ] 5.4.2 Use `.testimonial-card` class
- [ ] 5.4.3 Add section title with divider

### 5.5 Youtube Channel Section Enhancement
- [ ] 5.5.1 Add both channels: mahfil live + hakimabad dot com
- [ ] 5.5.2 Two channel cards side by side with subscribe buttons

### 5.6 Footer Enhancement
- [ ] 5.6.1 Add 4-column footer with links: Quick Links, Media, Resources, Contact
- [ ] 5.6.2 Add social media icons row

---

## Step 6: Update `video.html` — Multi-Channel Support

### 6.1 Navbar + Vue App Setup
- [ ] 6.1.1 Update navbar with mega dropdown
- [ ] 6.1.2 Update mobile menu
- [ ] 6.1.3 Add `megaMenuOpen` to Vue data

### 6.2 Multi-Channel Tabs
- [ ] 6.2.1 Add channel tabs below header: "mahfil live" | "hakimabad dot com"
- [ ] 6.2.2 Tab click switches `activeChannel` and resets filter/page
- [ ] 6.2.3 Show video count for each channel in tab

### 6.3 Data Loading
- [ ] 6.3.1 Update `mounted()` to fetch `data/youtube.json` with new structure
- [ ] 6.3.2 Load all channels from JSON
- [ ] 6.3.3 Load first channel by default

### 6.4 Video Player Integration
- [ ] 6.4.1 Keep existing iframe player
- [ ] 6.4.2 Update `playVideo(v)` to work with multi-channel data
- [ ] 6.4.3 Show channel name under video title in player

---

## Step 7: Update `links.html` — Data-Driven Categorized Links

### 7.1 Navbar + Vue App Setup
- [ ] 7.1.1 Update navbar with mega dropdown
- [ ] 7.1.2 Update mobile menu
- [ ] 7.1.3 Add `megaMenuOpen` + `linksData` + `error` to Vue data

### 7.2 Category Tabs
- [ ] 7.2.1 Add category filter tabs: All | Islamic | Educational | Resources | etc.
- [ ] 7.2.2 Compute unique categories from `linksData`
- [ ] 7.2.3 Active tab highlights

### 7.3 Link Cards Grid
- [ ] 7.3.1 Replace static HTML with `v-for` over filtered links
- [ ] 7.3.2 Each card: title, description, visit button (target=_blank)
- [ ] 7.3.3 Add category badge on each card

### 7.4 Data Loading
- [ ] 7.4.1 Fetch `data/links-website.json` in `mounted()`
- [ ] 7.4.2 Error handling with fallback message

---

## Step 8: Update `audio-website.html` — Local MP3 Support

### 8.1 Navbar + Vue App Setup
- [ ] 8.1.1 Update navbar with mega dropdown
- [ ] 8.1.2 Add mobile menu media sub-links
- [ ] 8.1.3 Add `megaMenuOpen` to existing Vue data

### 8.2 Local Media Section
- [ ] 8.2.1 Add "Local Test Audio" tab alongside Website Audio / Google Drive tabs
- [ ] 8.2.2 Load `data/media-local.json` → `localMedia.audios`
- [ ] 8.2.3 Render MP3 list with play button that calls existing audio player
- [ ] 8.2.4 Show file size/name metadata

---

## Step 9: Create `playlists.html` — YouTube Playlist Embed

### 9.1 Page Shell
- [ ] 9.1.1 Create `<html>` with tailwind + Vue CDN + css/styles.css
- [ ] 9.1.2 Add navbar with mega dropdown (from template)
- [ ] 9.1.3 Add mobile menu
- [ ] 9.1.4 Add footer + bottom nav

### 9.2 Header
- [ ] 9.2.1 "Playlists — YouTube" title
- [ ] 9.2.2 Subtitle: "Browse Hakimabad channel playlists"

### 9.3 Two-Column Layout
- [ ] 9.3.1 Sidebar (25%): list of playlists from `data/playlists.json`
- [ ] 9.3.2 Main (75%): iframe YouTube embed player

### 9.4 Vue Component
- [ ] 9.4.1 Data: `playlistsData`, `currentPlaylistId`, `megaMenuOpen`
- [ ] 9.4.2 Computed: `embedUrl` → `https://www.youtube.com/embed/videoseries?list=${currentPlaylistId}`
- [ ] 9.4.3 Method: `selectPlaylist(listId)` updates `currentPlaylistId`
- [ ] 9.4.4 Fetch `data/playlists.json` in `mounted()`

### 9.5 Styling
- [ ] 9.5.1 Playlist sidebar items with active state
- [ ] 9.5.2 Responsive: stacked on mobile (player top, list bottom)
- [ ] 9.5.3 Iframe with aspect-ratio 16:9

---

## Step 10: Create `gdrive-media.html` — GDrive Hub

### 10.1 Page Shell
- [ ] 10.1.1 Create `<html>` with tailwind + Vue CDN + css/styles.css
- [ ] 10.1.2 Add navbar with mega dropdown (from template)
- [ ] 10.1.3 Add mobile menu
- [ ] 10.1.4 Add footer + bottom nav

### 10.2 Header
- [ ] 10.2.1 "Google Drive Media Hub" title
- [ ] 10.2.2 Subtitle: "Automatically categorized media from Google Drive folders"

### 10.3 Category Tabs
- [ ] 10.3.1 All | Audio | Books | Video | Mixed
- [ ] 10.3.2 Clicking tab filters the folder cards
- [ ] 10.3.3 Active tab highlighted

### 10.4 Folder Cards Grid
- [ ] 10.4.1 `v-for` over `filteredFolders` from `data/gdrive.json`
- [ ] 10.4.2 Each card: folder name, autoCategory badge, "Open in Drive" button
- [ ] 10.4.3 Badge colors: audio=blue, books=green, video=red, mixed=gray
- [ ] 10.4.4 Cards link to `folder.url` with target=_blank

### 10.5 Auto-Categorization Display
- [ ] 10.5.1 Show the auto-category logic explanation below cards
- [ ] 10.5.2 Small note: "Folders categorized by name keywords"

### 10.6 Vue Component
- [ ] 10.6.1 Data: `gdriveFolders`, `activeCategory`, `megaMenuOpen`
- [ ] 10.6.2 Computed: `filteredFolders` based on `activeCategory`
- [ ] 10.6.3 Fetch `data/gdrive.json` in `mounted()`

---

## Step 11: Modernize All Pages — New Components & Polish

### 11.1 Page-by-page component additions
- [ ] 11.1.1 **about.html**: Add stat cards (years active, videos, audios, books), testimonial section
- [ ] 11.1.2 **events.html**: Add featured event countdown, recurring schedule table
- [ ] 11.1.3 **path.html**: Add reading progress indicator, section navigation sidebar
- [ ] 11.1.4 **tarika.html**: Add spiritual chain visualization, interactive lineage viewer
- [ ] 11.1.5 **contact.html**: Add map placeholder, social media card grid
- [ ] 11.1.6 **blog.html**: Add blog post cards (placeholder data)
- [ ] 11.1.7 **qa.html**: Add FAQ accordion component
- [ ] 11.1.8 **books.html**: Add search, category filter, book count stats
- [ ] 11.1.9 **audio-website.html**: Add recently played list, playlist progress
- [ ] 11.1.10 **links.html**: Add link count, category stats
- [ ] 11.1.11 **audio-gdrive.html**: Add connection status indicator
- [ ] 11.1.12 **video.html**: Add total view count estimate, most recent video badge

### 11.2 Global Polish
- [ ] 11.2.1 Add smooth scroll behavior: `html { scroll-behavior: smooth; }`
- [ ] 11.2.2 Add loading skeleton animation for data-driven sections
- [ ] 11.2.3 Add LazyLoad for iframes and images
- [ ] 11.2.4 Add CSS custom properties for easier theming
- [ ] 11.2.5 Add focus-visible outline for keyboard accessibility
- [ ] 11.2.6 Add print styles for content pages

---

## Implementation Order (Linear Flow)

```
01 → Step 1: CSS (all sub-steps: 1.1 → 1.11)
02 → Step 2: JS (all sub-steps: 2.1 → 2.8)
03 → Step 3: Data Files (all sub-steps: 3.1 → 3.6)
04 → Step 4: Navbar Update — index.html
05 → Step 4: Navbar Update — about.html, events.html, path.html, tarika.html, contact.html
06 → Step 4: Navbar Update — audio-website.html, video.html, books.html, audio-gdrive.html
07 → Step 4: Navbar Update — blog.html, qa.html, links.html
08 → Step 5: Update index.html with PDF lightbox + components
09 → Step 6: Update video.html with multi-channel support
10 → Step 7: Update links.html with data-driven links
11 → Step 8: Update audio-website.html with local MP3
12 → Step 9: Create playlists.html
13 → Step 10: Create gdrive-media.html
14 → Step 11: Modernize all pages (sub-steps 11.1 → 11.2)
```

## Notes
- Each sub-step number corresponds to a single find-and-edit operation
- Mark `[x]` as you complete each sub-step to track progress visually in the plan file
- For navbar mega dropdown: copy the same HTML snippet to all 14 pages, only vary `active-page` class
- Test each page after edits to ensure no JS errors break the Vue app
- The `#app` mount must exist exactly once per page