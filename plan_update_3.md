# Hakimabad Media Update Plan - Part 3

## Context
All 3 GDrive folders are now public with "Anyone with the link" → "Viewer" access.
API Key available: `AIzaSyAPtct1ZvXnwQM73jgZ6jrqUdk9On18A3Q`

### Public GDrive Folders
| Folder ID | Name | Purpose |
|---|---|---|
| `12yPt9wY2H0aEr2wRTM8bWBGgtddspysv` | Audio | Mahfil audio recordings |
| `1kRaDLvS8OIprShsyNzJf0Msv7TYOgDG0` | Hakimabad_App | General app files |
| `1LmnqgT3uwPhPwhmbdKXps5CX_smb2KZ7` | The_Path_App | The Path PDFs |

### Google Cloud Project
- Project ID: `hakimabad-app`
- Project Number: `301286644104`

---

## TASKS

### T1: Create GDrive API Script (`scripts/fetch-gdrive-public.js`)
Node.js script using Google Drive API v3 to:
- List all files in a public folder using `?key=API_KEY`
- Recursively traverse subfolders
- Generate `?export=download&id=FILE_ID` URLs
- Output structured JSON

```js
// API call format for public folders
GET https://www.googleapis.com/drive/v3/files?q="'FOLDER_ID'+in+parents"&key=API_KEY
```

### T2: Test API Key Access
Verify the API key works on public folders. If not, fall back to Apps Script.

### T3: Extract Audio Folder (`12yPt9wY2H0aEr2wRTM8bWBGgtddspysv`)
- Fetch all files (MP3, audio types)
- Categorize by subfolder name (Monthly Mahfil, Annual Mahfil, Doa & Milad, etc.)
- Generate download URLs
- Update `data/audio-gdrive.json` with real tracks

### T4: Extract Hakimabad_App Folder (`1kRaDLvS8OIprShsyNzJf0Msv7TYOgDG0`)
- Fetch all files
- Categorize by type (PDF, image, video, audio, document)
- Update `data/gdrive.json` with file list

### T5: Extract The_Path_App Folder (`1LmnqgT3uwPhPwhmbdKXps5CX_smb2KZ7`)
- Fetch all files (likely PDFs)
- Add to `data/gdrive.json` under Books category
- Cross-reference with `media/The_Path/` local PDFs to avoid duplicates

### T6: Update `audio-website.html`
- Add 3-tab system: Website Audio | GDrive Audio | Local Audio
- Website Audio: existing tracks from `audio-website.json`
- GDrive Audio: new tracks from `audio-gdrive.json`
- Local Audio: tracks from `media-local.json` (4 files in `media/audios/`)
- Unified player that works across all 3 sources

### T7: Update `audio-gdrive.html`
- Display real tracks instead of placeholder
- Add folder info panel showing total files, categories
- Add link to open folder in GDrive

### T8: Update `video.html`
- Add second channel switcher: "mahfil live" | "hakimabad dot com"
- Load both channels' videos
- Use `playlists.json` to show playlist badges on video cards
- Update `data/youtube.json` to include both channels
- Add channel banner with subscriber video count

### T9: Create `playlists.html`
- YouTube embed player area (left 65%)
- Playlist sidebar (right 35%)
  - Channel upload playlists (All, 2025, 2024, 2021-2023)
  - Custom playlists (Annual Mahfil 2025, Miladunnabi 2025, Sufism)
- Click playlist → loads videos into embed
- Active playlist highlighted

### T10: Create `gdrive-media.html`
- Grid of 3 folder cards
- Each card shows: folder name, description, file count, category badge
- Click → modal with file list
- Category filter tabs: All | Audio | Books | General
- Add "Open in GDrive" button to each folder

### T11: Create `scripts/refresh-all.js`
- Master script that runs all extractions in sequence
- `node scripts/refresh-all.js` → updates all 4 data files
- Add to package.json as `npm run refresh`

---

## Data Files to Update

### `data/audio-gdrive.json`
```json
{
  "folderId": "12yPt9wY2H0aEr2wRTM8bWBGgtddspysv",
  "name": "Audio",
  "url": "https://drive.google.com/drive/folders/12yPt9wY2H0aEr2wRTM8bWBGgtddspysv",
  "lastFetched": "2026-05-17",
  "playlists": [
    { "name": "Monthly Mahfil", "tracks": [...] },
    { "name": "Annual Mahfil", "tracks": [...] },
    { "name": "Doa & Milad", "tracks": [...] },
    { "name": "Others", "tracks": [...] }
  ]
}
```

### `data/gdrive.json`
```json
{
  "lastFetched": "2026-05-17",
  "folders": [
    {
      "name": "Hakimabad_App",
      "folderId": "1kRaDLvS8OIprShsyNzJf0Msv7TYOgDG0",
      "url": "https://drive.google.com/drive/folders/1kRaDLvS8OIprShsyNzJf0Msv7TYOgDG0",
      "category": "General",
      "files": [
        { "name": "file.pdf", "type": "pdf", "size": "2MB", "url": "..." },
        ...
      ]
    },
    {
      "name": "The_Path_App",
      "folderId": "1LmnqgT3uwPhPwhmbdKXps5CX_smb2KZ7",
      "url": "https://drive.google.com/drive/folders/1LmnqgT3uwPhPwhmbdKXps5CX_smb2KZ7",
      "category": "Books",
      "files": [...]
    }
  ]
}
```

### `data/youtube.json` — Update structure
```json
{
  "channels": [
    {
      "id": "UCXuFIrgi5aYbAm3gVNl5-3A",
      "name": "mahfil live",
      "url": "https://www.youtube.com/channel/UCXuFIrgi5aYbAm3gVNl5-3A",
      "totalResults": 51,
      "videos": [...]
    },
    {
      "id": "UC34wiyCiKwn3gxFRMaut1Ww",
      "name": "hakimabad dot com",
      "url": "https://www.youtube.com/channel/UC34wiyCiKwn3gxFRMaut1Ww",
      "totalResults": 8,
      "videos": [...]
    }
  ],
  "playlists": [...]
}
```

---

## Implementation Order

1. **T1** → Create the GDrive fetch script
2. **T2** → Test API key (quick verification)
3. **T3** → Extract audio folder → `audio-gdrive.json`
4. **T4** → Extract Hakimabad_App → `gdrive.json`
5. **T5** → Extract The_Path_App → `gdrive.json`
6. **T6** → Update `audio-website.html` (3 tabs)
7. **T7** → Update `audio-gdrive.html` (real data)
8. **T8** → Update `video.html` (2 channels)
9. **T9** → Create `playlists.html`
10. **T10** → Create `gdrive-media.html`
11. **T11** → Create `refresh-all.js`

---

## Technical Notes

### GDrive API for Public Folders
Use `key` parameter instead of OAuth:
```
GET https://www.googleapis.com/drive/v3/files?q='FOLDER_ID'+in+parents&key=API_KEY
```

### Download URL Format
```
https://drive.google.com/uc?export=download&id=FILE_ID
```

### MIME Types to Filter
- Audio: `audio/mpeg`, `audio/wav`, `audio/ogg`, `audio/*`
- PDF: `application/pdf`
- Images: `image/*`
- Documents: `application/vnd.google-apps.document`, `application/msword`, `application/vnd.openxmlformats-officedocument.*`

### File Size Format
Convert bytes to human readable (KB, MB, GB)