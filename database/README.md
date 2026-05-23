# Hakimabad Database

Schema and seed data for the Hakimabad Islamic Spiritual Center website.

## Files

| File | Purpose |
|------|---------|
| `database.sql` | Full schema — 12 tables, views, indexes, triggers, and seed data for reference tables |
| `current_data.sql` | All current content data — 274 audio tracks, 60 videos, books, links, GDrive files, events |

## Schema Overview

| # | Table | Content |
|---|-------|---------|
| 1 | `site_config` | Site name, colors, theme, locale |
| 2 | `pages` | HTML page metadata (slug, title, nav) |
| 3 | `audio_tracks` | Audio files from Google Drive / website / local |
| 4 | `videos` | YouTube videos |
| 5 | `playlists` / `playlist_videos` | Curated video playlists |
| 6 | `gdrive_folders` / `gdrive_files` | Google Drive media browser |
| 7 | `links` / `link_categories` | Important Links page |
| 8 | `books` / `book_categories` | Online library |
| 9 | `media_files` | Local audio/PDF files |
| 10 | `events` | Upcoming and past events |
| 11 | `faq` | Q&A page |
| 12 | `blog_posts` | Blog |
| 13 | `nav_items` | Navigation menus (desktop, mobile, mega, bottom) |
| 14 | `listening_history` | User playback analytics |

## How to Transition from Static to Dynamic

### 1. Choose a database engine

The schema targets **PostgreSQL 15+** but is compatible with **MySQL 8+** and **SQLite 3.40+** with minimal changes (remove `GENERATED ALWAYS AS IDENTITY` for MySQL or `TIMESTAMPTZ` for SQLite).

### 2. Set up the database

```bash
# PostgreSQL
createdb hakimabad
psql -d hakimabad -f database/database.sql
psql -d hakimabad -f database/current_data.sql

# SQLite
sqlite3 hakimabad.db < database/database.sql
sqlite3 hakimabad.db < database/current_data.sql
```

### 3. Build an API server

Recommended stack: **Node.js + Express** (already used in `scripts/`).

Expected API structure:

```
hakimabad-website/
├── api/
│   ├── index.js              # Express entry point
│   ├── db.js                 # Database connection
│   ├── routes/
│   │   ├── audio.js          # GET /api/audio
│   │   ├── videos.js         # GET /api/videos
│   │   ├── books.js          # GET /api/books
│   │   ├── links.js          # GET /api/links
│   │   ├── gdrive.js         # GET /api/gdrive
│   │   ├── events.js         # GET /api/events
│   │   ├── blog.js           # GET /api/blog
│   │   ├── faq.js            # GET /api/faq
│   │   ├── playlists.js      # GET /api/playlists
│   │   └── search.js         # GET /api/search?q=
│   └── middleware/
│       └── cors.js
├── database/
│   ├── database.sql
│   └── current_data.sql
└── (static HTML files)
```

### 4. Update HTML pages

Each page currently loads data from `<script src="./data/*.js">` tags.
When the API is ready, replace with `fetch('/api/...')` calls.

Example for `audio-playlist.html`:
```javascript
// Before (static):
if (window.__AUDIO_CATALOG) {
  this.catalog = window.__AUDIO_CATALOG;
} else {
  fetch('./data/audio-catalog.json')
    .then(r => r.json())
    .then(d => { this.catalog = d; });
}

// After (dynamic):
fetch('/api/audio/catalog')
  .then(r => r.json())
  .then(d => { this.catalog = d; });
```

### 5. Rebuild data JS files from the database (optional)

The `scripts/build-data-js.js` tool regenerates the `data/*.js` files
from the database for static deployment.

## Views Available

| View | Purpose |
|------|---------|
| `v_audio_overview` | Audio tracks with source/category names |
| `v_video_overview` | Videos with channel info + year extracted |
| `v_playlist_detail` | Playlists with full video details |
| `v_gdrive_overview` | GDrive files with folder hierarchy |
| `v_book_overview` | Books with category info |
| `v_link_directory` | Links with categories |
| `v_media_library` | Unified search across all media types |
| `v_search` | Full-text search across pages, audio, video, books, links, blog |
