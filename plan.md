# Hakimabad Islamic Website - Complete Implementation Plan

## Project Overview

**Project Name:** Hakimabad Islamic Website Redesign
**Original Website:** https://www.hakimabad.com/
**Google Drive Audio Folder:** https://drive.google.com/drive/folders/12yPt9wY2H0aEr2wRTM8bWBGgtddspysv
**Status:** Build complete, ready for deployment

---

## Source Links & Resources

### Original Website Pages
| URL | Content |
|-----|---------|
| https://www.hakimabad.com/ | Main Homepage |
| https://www.hakimabad.com/menubar.php | Navigation Menu |
| https://www.hakimabad.com/mahfils.php | Audio Mahfil Collection (100+ MP3s) |
| https://www.hakimabad.com/The%20Path.html | The Path - Islamic Teachings |
| https://www.hakimabad.com/banner.php | Tarika-e-Khas Mojaddedia (35+ Saints Lineage) |
| https://www.hakimabad.com/newswall.php | News & Events (Annual Mahfil, Live Streams) |

### Content from Website
- **Mahfil Audio:** 100+ MP3 files (2006-2013) categorized as:
  - Monthly Mahfil
  - Annual Mahfil
  - Doa & Milad
  - Others
- **The Path Content:** Islamic teachings on faith, Shariah, 5 pillars
- **Tarika Lineage:** 35+ saint names from Prophet to current leadership
- **Leadership:** Hakim Abdul Hakim (Founder), Mohammad Mamunur Rashid (Speaker)

### Google Drive Audio
| Folder ID | URL |
|-----------|-----|
| 12yPt9wY2H0aEr2wRTM8bWBGgtddspysv | https://drive.google.com/drive/folders/12yPt9wY2H0aEr2wRTM8bWBGgtddspysv |

### YouTube Channel
| Channel | ID | Videos |
|---------|----|--------|
| mahfil live | UCXuFIrgi5aYbAm3gVNl5-3A | 51 Hakimabad Mahfil videos |

---

## Technology Stack

| Component | Choice |
|-----------|--------|
| **Framework** | Vue 3 (Option API) via vue.global.prod CDN |
| **Styling** | Tailwind CSS (CDN) + Custom CSS |
| **Structure** | Multi-page with shared global Vue state |
| **Audio Player** | Global bottom-bar with playlist |
| **Video Player** | YouTube IFrame API integration |
| **Deployment** | Local first, then GitHub Pages / Netlify |

---

## Project Structure

```
hakimabad-website/
├── index.html                    # Home (Mosque gate hero + original content)
├── audio-website.html            # Website Audio (100+ MP3s, search, category filters)
├── audio-gdrive.html             # Google Drive Audio (placeholder, blocked)
├── video.html                    # YouTube Videos (51 videos, year filters, embed)
├── books.html                    # E-Books Collection
├── events.html                   # Events Calendar
├── blog.html                     # Blog/Articles
├── qa.html                       # Q&A Community
├── about.html                    # About + Khanka-e-Mozaddedia
├── path.html                     # The Path (Full Islamic Teachings)
├── tarika.html                   # Tarika-e-Khas Mojaddedia (Full 35-name Lineage)
├── links.html                    # External Links
├── contact.html                  # Contact Form
├── plan.md                       # This plan file
├── css/
│   └── styles.css                # Custom CSS + emerald green theme + mosque gate SVG
├── js/
│   ├── app.js                    # Vue 3 Option API (global state: audio, nav, youtube)
│   └── components/
│       ├── AudioPlayer.vue       # Global bottom-bar player (inlined in app.js)
│       ├── Navbar.vue            # Top navigation (inlined in app.js)
│       ├── MobileMenu.vue        # Off-canvas mobile menu (inlined in app.js)
│       └── BottomNav.vue         # Mobile bottom navigation (inlined in app.js)
├── data/
│   ├── config.json               # Site configuration
│   ├── audio-website.json        # 100+ MP3s from hakimabad.com
│   ├── audio-gdrive.json         # Google Drive audio (empty, needs auth)
│   ├── youtube.json              # 51 videos from mahfil live channel
│   ├── books.json                # Books data
│   ├── events.json               # Events data
│   ├── blog.json                 # Blog posts
│   ├── qa.json                   # Q&A data
│   ├── path.json                 # The Path content (full text)
│   └── tarika.json               # Tarika lineage (35+ saints)
├── scripts/
│   ├── extract-gdrive.js         # Google Drive extractor (needs auth)
│   ├── youtube-search.js         # YouTube Data API search
│   ├── youtube-scrape.js         # Web scraper fallback (used successfully)
│   ├── fetch-titles.js           # Fetch video titles from channel
│   ├── find-channel.js           # Find channel by name
│   ├── fetch-channel.js          # Fetch all videos from channel
│   ├── fetch-gdrive-html.js      # Fetch GDrive folder HTML
│   └── clean-all.js              # Clean script artifacts
└── assets/
    └── images/                   # Static images
```

---

## Design Specification

### Color Palette (Emerald Green Theme)
| Color | Hex | Usage |
|-------|-----|-------|
| Primary | `#0D5C3D` | Headers, buttons, navigation |
| Primary Dark | `#073D28` | Hover states, active elements |
| Secondary | `#C9A227` | Gold accents, highlights |
| Background | `#FFFEF8` | Cream white, page background |
| Gradient Start | `#0F4C3A` | Hero section background |
| Gradient End | `#1A7A5E` | Hero section background |
| Text Dark | `#1A1A1A` | Primary text |
| Text Light | `#FFFFFF` | Text on dark backgrounds |

### Hero Section Design
- **Background:** Emerald green gradient (`#0F4C3A` → `#1A7A5E`)
- **Visual:** Mosque gate / architectural SVG design
  - Islamic arch doorway with dome silhouette
  - Minaret accents with arabesque geometric patterns
- **Animation:** Subtle floating effect on the mosque gate SVG
- **Content:** Site name, tagline, navigation links

### Typography
- **Headings:** Amiri (Arabic), Noto Sans (English)
- **Body:** Noto Sans Bengali, Noto Sans
- **Sizes:** Responsive with Tailwind classes

---

## Audio System

### 1. Website Audio (`audio-website.html`)
- **Source:** Scraped from https://www.hakimaboad.com/mahfils.php
- **Files:** 100+ MP3 files (IDs `ws-001` through `ws-128`)
- **Categories:** Monthly Mahfil, Annual Mahfil, Doa & Milad, Others
- **Features:** Search, category filter tabs, global audio player

### 2. Google Drive Audio (`audio-gdrive.html`)
- **Folder ID:** `12yPt9wY2H0aEr2wRTM8bWBGgtddspysv`
- **Status:** Blocked — folder requires authentication
- **Resolution:** Make folder public or provide Google Cloud service account credentials

### Global Bottom-Bar Audio Player
- **Position:** Fixed bottom, z-index: 9999
- **Features:** Play/Pause/Skip, progress bar with seek, volume control, playlist toggle, track info
- **Persistence:** Separate Vue app mount per page (same initial state from JSON)

---

## YouTube Integration (`video.html`)

### Approach Used
- Channel **"mahfil live"** discovered via web search (`UCXuFIrgi5aYbAm3gVNl5-3A`)
- 51 real Hakimabad Mahfil videos extracted via web scraping (no API key needed)
- Each video has real title and YouTube ID

### Page Features
- Embedded IFrame player for selected video
- Grid display with thumbnails, titles, dates
- Year filter buttons (2025, 2024, 2021-2023)
- Pagination (12 videos per page)
- Channel info section with link

---

## Mobile Responsiveness

| Feature | Implementation |
|---------|---------------|
| **Off-canvas Menu** | Slide-in from left, 300px width, overlay |
| **Bottom Navigation** | 5 icons: Home, Audio, Video, Books, More |
| **Audio Player** | Collapsible, responsive controls |
| **Grid Layouts** | 1 col mobile, 2 col tablet, 3-4 col desktop |
| **Touch Optimized** | Min 44px tap targets |

---

## Pages Mapping (Original → New)

| Original Page | New Page | Content Preserved |
|---------------|----------|-------------------|
| Home | index.html | All main content with mosque gate hero |
| About Hakimabad | about.html | Organization info |
| Khanka-e-Mozaddedia | about.html | Combined into about |
| About Hakim Abdul Hakim | about.html | Founder biography |
| About Mohammad Mamunur Rashid | about.html | Speaker profile |
| e-Book | books.html | Book downloads |
| Mahfil | audio-website.html | Original audio files with player |
| The Path | path.html | Full Islamic teachings |
| Tarika (Banner) | tarika.html | 35+ saint lineage |
| Links | links.html | External links |
| Contact us | contact.html | Contact information |
| Newswall | events.html | Event announcements |

---

## Data Files Structure

### config.json
```json
{
  "siteName": "Hakimabad",
  "tagline": "Khanka-e-Mozaddedia - Islamic Spiritual Center",
  "colors": {
    "primary": "#0D5C3D",
    "primaryDark": "#073D28",
    "secondary": "#C9A227",
    "background": "#FFFEF8"
  },
  "contact": {
    "email": "info@hakimabad.com"
  }
}
```

### audio-website.json
```json
{
  "source": "hakimabad.com/mahfils.php",
  "playlists": [
    {
      "name": "Monthly Mahfil",
      "tracks": [
        {
          "id": "ws-001",
          "title": "Hakimabad Monthly March 2006",
          "url": "http://www.hakimabad.com/mahfil/Mp3-2.52.mp3",
          "duration": "00:00",
          "date": "2006-03"
        }
      ]
    }
  ]
}
```

### audio-gdrive.json
```json
{
  "folderId": "12yPt9wY2H0aEr2wRTM8bWBGgtddspysv",
  "generatedAt": "2026-05-14",
  "playlists": [
    {
      "name": "Monthly Mahfil",
      "folderPath": "/Monthly Mahfil",
      "tracks": []
    }
  ]
}
```

### youtube.json
```json
{
  "channelId": "UCXuFIrgi5aYbAm3gVNl5-3A",
  "channelName": "mahfil live",
  "generatedAt": "2026-05-14",
  "videos": [
    {
      "id": "N0FE1r5h3-0",
      "title": "199. Hakimabad Annual Mahfil...",
      "date": "2024-12-05"
    }
  ]
}
```

---

## Scripts

| Script | Purpose | Status |
|--------|---------|--------|
| `extract-gdrive.js` | Extract files from Google Drive folder | Blocked (needs auth) |
| `youtube-search.js` | Search YouTube via Data API | Requires API key |
| `youtube-scrape.js` | Web scrape YouTube search results | Successfully used |
| `fetch-titles.js` | Fetch video titles from a channel | Successfully used |
| `find-channel.js` | Find channel ID by name | Successfully used |
| `fetch-channel.js` | Fetch all videos from a channel | Successfully used |
| `fetch-gdrive-html.js` | Fetch GDrive folder HTML | Blocked (needs auth) |
| `clean-all.js` | Clean script artifacts | Available |

---

## Build Summary

### Phase 1: Core Infrastructure
- Project folder structure created
- Tailwind CSS (CDN) configured
- Vue 3 global app with Option API state management
- Shared components built (Navbar, AudioPlayer, MobileMenu, BottomNav)

### Phase 2: Home & Audio Pages
- `index.html` — Mosque gate SVG hero, original content cards, latest videos
- `audio-website.html` — 100+ MP3s with search and category filters
- `audio-gdrive.html` — Google Drive audio (placeholder until folder is public)

### Phase 3: Media Pages
- `video.html` — 51 real YouTube videos, year filters, pagination, embed player
- `books.html` — E-books collection

### Phase 4: Additional Pages
- All 14 pages built with preserved original content
- JSON data files populated for all sections

### Phase 5: Polish & Deploy
- Mobile responsive layout complete
- Custom CSS with emerald green theme
- All pages now have complete navigation (fixed missing links on video, about, tarika, path, books, events, blog, qa, links, contact, audio-gdrive pages)
- Ready for deployment

---

## Current Status

### Completed
- All 14 HTML pages built and functional
- 100+ MP3s cataloged from hakimabad.com in `audio-website.json`
- 51 real YouTube videos from channel "mahfil live" in `youtube.json`
- Global bottom-bar audio player with playlists
- Mosque gate SVG hero section
- Mobile responsive with off-canvas menu
- All original content preserved verbatim
- 8 extraction scripts created

### Blocked
- **Google Drive audio:** Folder `12yPt9wY2H0aEr2wRTM8bWBGgtddspysv` requires authentication. Need to either make it public (Anyone with link can view) or provide Google Cloud service account credentials.
- **YouTube API key:** Not provided. Web scraper fallback was sufficient for 51 videos; API key would enable richer metadata.

### Remaining
- Deploy to Netlify Drop or GitHub Pages

---

## Deployment Options

### Option 1: Netlify Drop (Simplest)
1. Go to https://app.netlify.com/drop
2. Drag and drop the `hakimabad-website/` folder
3. Site is live immediately with a Netlify subdomain

### Option 2: GitHub Pages
1. Create a GitHub repository
2. Push the `hakimabad-website/` contents
3. Enable GitHub Pages in repo settings (source: main branch, root folder)

---

## To-Do List

- [x] Create project folder structure
- [x] Set up Tailwind CSS configuration
- [x] Build Vue 3 global app.js with audio player state
- [x] Create shared components (Navbar, AudioPlayer, MobileMenu, BottomNav)
- [x] Build index.html with mosque gate hero and original content
- [x] Extract 100+ MP3 URLs from hakimabad.com → audio-website.json
- [x] Create audio-website.html page
- [x] Create extract-gdrive.js script
- [x] Create audio-gdrive.html page (placeholder for now)
- [x] Create youtube-search.js script
- [x] Create youtube-scrape.js, fetch-channel.js, find-channel.js scripts
- [x] Fetch 51 real YouTube videos from channel "mahfil live"
- [x] Create video.html page with year filters and pagination
- [x] Create books.html page
- [x] Create about.html page
- [x] Create path.html page with full content
- [x] Create tarika.html page with 35+ saint lineage
- [x] Create events.html page
- [x] Create blog.html page
- [x] Create qa.html page
- [x] Create links.html page
- [x] Create contact.html page
- [x] Fix navigation links on all pages to include all 12 pages
- [x] Integrate downloaded Hakimabad-mahfil.html and Hakimabad-ebook.html content
- [x] Create books.json with 40+ books from ebook.html (Tafsir, Biography, Tasauf, Poems, etc.)
- [x] Update audio-website.json with actual mahfil URLs from mahfils.html
- [x] Update books.html to display all books from ebook.html in organized categories
- [ ] Deploy to GitHub Pages / Netlify
- [ ] Google Drive audio: make folder public or provide credentials

---

## Notes

- All original content from hakimabad.com preserved verbatim
- Emerald green gradient theme throughout
- Mosque gate SVG used for hero visual (no external images)
- Audio player persists across all pages via global Vue state
- Mobile-first approach with off-canvas menu and bottom nav
- JSON files used for all data (no hardcoded arrays in JS)
- Core religious content (The Path, Tarika lineage) fully preserved
- YouTube channel "mahfil live" (`UCXuFIrgi5aYbAm3gVNl5-3A`) discovered via web scraping, contains 51 Hakimabad Mahfil videos
- Google APIs module installed in `scripts/node_modules/` but requires `credentials.json`
