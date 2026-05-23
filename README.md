# Hakimabad Website

Hakimabad Islamic Spiritual Center — Khanka-e-Mozaddedia website.

## Structure

```
hakimabad-website/
├── index.html                  # Home page
├── about.html                  # About the center
├── events.html                 # Events calendar + Mahfil schedule tab
├── path.html                   # The Path program
├── tarika.html                 # Spiritual Lineage
├── contact.html                # Contact form
│
├── audio-playlist.html         # Audio catalog + player
├── audio-website.html          # Website audio
├── audio-gdrive.html           # GDrive audio
├── video.html                  # YouTube videos
├── video-playlist.html         # Video playlists
├── playlists.html              # Custom playlists
├── gdrive-media.html           # GDrive browser
├── links.html                  # Important links
├── books.html                  # Online library
├── blog.html                   # Blog
├── qa.html                     # Q&A
│
├── bio/
│   ├── abhakim.html            # Hakim Abdul Hakim bio
│   ├── mmrashid.html           # Mamunur Rashid bio
│   └── msakhter.html           # M S Akhter bio
│
├── css/
│   └── styles.css              # Tailwind + custom styles
│
├── js/
│   ├── app.js                  # Global Vue 3 app
│   └── components/             # Vue components
│
├── data/                       # JSON data + JS bundles
│   ├── audio-catalog.js        # Audio catalog (282 tracks)
│   ├── audio-catalog.json
│   ├── video-catalog.js        # Video playlists
│   ├── video-catalog.json
│   ├── mahfils-data.js         # Mahfil schedule (23 entries)
│   ├── mahfils.md              # Bangla mahfil source
│   ├── audio-data.js           # Audio from website & GDrive
│   ├── video-data.js           # YouTube videos (60+)
│   ├── gdrive-data.js          # GDrive folder/file listing
│   ├── links-data.js           # Link categories
│   ├── books-data.js           # Book categories
│   ├── events-data.js          # Events
│   ├── audio-playlist-data.js  # Playlist metadata
│   ├── playlists.json          # Playlist definitions
│   ├── youtube.json            # YouTube data
│   ├── gdrive.json             # GDrive metadata
│   ├── books.json              # Book metadata
│   └── ... (more JSON source files)
│
├── assets/
│   ├── vendor/                 # Local CDN copies
│   │   ├── vue.global.prod.js
│   │   ├── tailwindcss.js
│   │   └── google-fonts.css
│   ├── fonts/                  # Google Font woff2 files
│   └── images/                 # Logo, icons, photos
│
├── database/                   # SQL for future backend
│   ├── database.sql            # Full schema
│   └── current_data.sql        # Seed data
│
├── media/
│   ├── audios/                 # Local MP3 files
│   └── books/                  # The Path PDFs
│
└── scripts/                    # Build & fetch tools
    ├── build-data-js.js        # Generate JS data files
    ├── fetch-gdrive-public.js  # Fetch GDrive listings
    ├── build-gdrive-data.js    # Build GDrive JSON
    ├── sync-all.js             # Sync all data
    ├── generate-sql.js         # Generate SQL from JSON
    ├── clean-data.js           # Clean/validate data
    └── ... (30+ scripts)
```

## Features

- **Offline-first**: All dependencies (Vue 3, Tailwind, Google Fonts) downloaded locally
- **File:// compatible**: No fetch() calls in production pages; data loaded via `<script src>`
- **Mega dropdown** navigation under "Media" with Audio/Video/Books/Links
- **Mobile-first**: Fixed header, slide-in menu, bottom tab nav
- **Audio player**: Built-in player with prev/next, volume, playlist sidebar, progress bar
- **Google Drive audio**: Resolved via `docs.google.com/uc?export=open&confirm=t&id=` for reliable streaming from `file://`
- **Video browser**: Multi-channel, year filter, search, pagination, playlist sidebar
- **YouTube fallback**: Detects file:// protocol — shows "Watch on YouTube" button instead of broken embed
- **GDrive media**: Browse public GDrive folders, filter by category
- **Index page rows**: Horizontal scrolling sections for Audio, YouTube, Books, The Path
- **Events page**: Calendar/List/Mahfil Schedule views with Bangla date-to-ISO conversion
- **Database-ready**: Full SQL schema + current data for future dynamic backend

## Quick start

Open any `.html` file directly in a browser. No server needed.

To rebuild data files:
```bash
cd scripts
npm install
node fetch-gdrive-public.js <folder-id>
node build-gdrive-data.js
node build-data-js.js
```

## Contact

- **Website**: [hakimabad.com](https://hakimabad.com) · [mamunurrashid.org](https://mamunurrashid.org)
- **Email**: [info@hakimabad.com](mailto:info@hakimabad.com)
- **Dev Emails**: [hakimabadapp@gmail.com](mailto:hakimabadapp@gmail.com) · [amin360it@gmail.com](mailto:amin360it@gmail.com)
- **YouTube**: [mahfil live](https://youtube.com/@mahfillive) · [hakimabad dot com](https://youtube.com/@hakimabaddotcom)
- **Facebook**: [Page](https://www.facebook.com/hakimabad1989/) · [Group](https://www.facebook.com/groups/1495794747101462/)
- **Google Drive Audio**: [Audio Archive](https://drive.google.com/drive/folders/12yPt9wY2H0aEr2wRTM8bWBGgtddspysv)
- **Google Drive Books**: [Books & Materials](https://drive.google.com/drive/folders/1LmnqgT3uwPhPwhmbdKXps5CX_smb2KZ7)

### Addresses

**Bangladesh**: Hakimabad Khanka-e-Mozaddedia, Hakimabad, Bhuigar, Narayangonj, Bangladesh
- Phone: 01711233670, 01726288280

**Cambodia**: N. R. No.-5, Village-Andoung Chrey, Commune-Andoung Fanay, District-Rorlibhiar, Kompong Chhnang, Kingdom of Cambodia
- Phone: +85512495461

### Google Maps

https://maps.app.goo.gl/XztCAaZKNrE6kZ587

---

© 2026 Hakimabad Khanka-e-Mozaddedia. All rights reserved.
