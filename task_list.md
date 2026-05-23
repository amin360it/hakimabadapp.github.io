# Hakimabad Website - Task List

## Media & Mega Menu Restructure

### Completed Tasks

### Pending Tasks

#### Phase 1: Data Consolidation & JSON Updates
- [ ] Create consolidated `audio-catalog.json` — merge audio-playlist.json, audio-gdrive.json, audio-website.json, media-local.json into one master catalog with year-based categories
- [ ] Create consolidated `video-catalog.json` — merge youtube.json, playlists.json, gdrive videos into one master catalog with categories
- [ ] Create `media-sources.json` — track all media sources (GDrive folder IDs, YouTube channel IDs, local folder paths) for auto-sync scripts
- [ ] Update gdrive.json with full audio file listings (already has images, needs audio)

#### Phase 2: Audio Playlist Page with Player
- [ ] Create `audio-playlist.html` — new page with:
  - Year-based category filter (2002, 2003, 2005, 2006, 2007, 2008, 2009, 2011, 2012, 2013, 2014, 2015)
  - Location/category tags from filenames
  - Real HTML5 Audio player with playlist queue
  - Play/pause, progress bar, volume, next/prev
  - Source switching (Website Audio / GDrive Audio)
  - Search & filter by year, category, location

#### Phase 3: Video Playlist Page with Player
- [ ] Create `video-playlist.html` — new page with:
  - YouTube playlist integration with iframe player
  - YouTube channel video listing
  - Custom playlists from playlists.json
  - Real video player (YouTube iframe API)
  - Categories: Mahfil, Maktubat, Sufism, Miladunnabi, Archive

#### Phase 4: Mega Menu Updates
- [ ] Update `index.html` mega menu — add Audio Playlist & Video Playlist links
- [ ] Update `audio-website.html` mega menu
- [ ] Update `audio-gdrive.html` mega menu
- [ ] Update `video.html` mega menu
- [ ] Update `gdrive-media.html` mega menu
- [ ] Update `contact.html` mega menu
- [ ] Update `playlists.html` mega menu (or deprecate in favor of new pages)

#### Phase 5: Auto-Sync Scripts
- [ ] Create `scripts/sync-all.js` — master sync orchestrator
- [ ] Create `scripts/auto-fetch-gdrive.js` — fetch new files from Google Drive folders
- [ ] Create `scripts/auto-fetch-youtube.js` — fetch new videos from YouTube channel
- [ ] Create `scripts/auto-scan-local.js` — scan local media folder for new files
- [ ] Create `scripts/auto-generate-json.js` — regenerate JSON catalogs from all sources
- [ ] Add documentation for auto-sync in README or scripts README

#### Phase 6: Google Maps + Professional Contact Page
- [ ] Update `contact.html`:
  - Add Google Maps iframe with Hakimabad location
  - Add real contact info from old website (Mohammad Mamunur Rashid)
  - Cambodia address: N. R. No.-5, Village-Andoung Chrey, Commune-Andoung Fanay, District-Rorlibhiar, Kompong Chhnang, Kingdom of Cambodia
  - Bangladesh address: Hakimabad Khanka-e-Mozaddedia, Bhuigar, Narayangonj, Bangladesh
  - Phone: +85512495461, 01711233670, 01726288280
  - Professional design with cards, icons, gradients
  - Social media links (Facebook, YouTube)
  - Working contact form (or mailto link)

#### Phase 7: Testing & Verification
- [ ] Verify all pages load correctly
- [ ] Test audio player with local and GDrive sources
- [ ] Test video player with YouTube embeds
- [ ] Verify mega menu navigation works on all pages
- [ ] Test responsive layout (mobile/desktop)
- [ ] Verify contact page Google Maps renders

## Notes
- Don't look inside `scripts/node_modules/`
- Use data from `Resources for AI/` folder for contact info, links, addresses
- Audio filenames contain year patterns: 2002, 2003, 2005, 2006, 2007, 2008, 2009, 2011, 2012, 2013, 2014, 2015
- File names also contain location/category names like: Chittagong, Garo Pahar, Sirajgonj, Jahangirnogor, Hakimabad, etc.
- YouTube channel: UCXuFIrgi5aYbAm3gVNl5-3A (mahfil live)
- GDrive audio folder: 12yPt9wY2H0aEr2wRTM8bWBGgtddspysv
