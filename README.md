# Hakimabad - Khanka-e-Mozaddedia

[![Live Site](https://img.shields.io/badge/Live-Site-green?style=for-the-badge&logo=github)](https://hakimabadapp.github.io/)
[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE)

> **Islamic Spiritual Center** - Following the Tarika-e-Khas Mojaddedia

A modern, mobile-first web application for Hakimabad Islamic Spiritual Center, providing access to spiritual teachings, audio lectures, video content, books, and community events.

## 🌟 Features

### Core Offerings
- **📖 Spiritual Path** - Comprehensive guidance on Tarika-e-Khas Mojaddedia
- **🎵 Audio Library** - Extensive collection of Islamic lectures and recitations
- **📺 Video Content** - Curated video playlists and YouTube integration
- **📚 Books & Resources** - Digital library of Islamic literature
- **👥 Leadership** - Information about spiritual guides and scholars
- **📅 Events** - Upcoming programs, mahfils, and community gatherings
- **🌳 Lineage (Shejra)** - Interactive spiritual lineage visualization

### Technical Highlights
- ✅ **Mobile-First Design** - Optimized for all screen sizes
- ✅ **Modern UI/UX** - Clean aesthetics with Islamic geometric patterns
- ✅ **Green & Gold Theme** - Professional color scheme reflecting Islamic heritage
- ✅ **Vue.js Powered** - Reactive components with Vue 3
- ✅ **Tailwind CSS** - Utility-first styling for rapid development
- ✅ **Responsive Navigation** - Desktop mega-menu + mobile slide menu + bottom nav
- ✅ **YouTube Integration** - Embedded video player with fallback support
- ✅ **PWA Ready** - Progressive Web App capabilities for app-like experience

## 🚀 Quick Start

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/hakimabadapp/hakimabadapp.github.io.git
   cd hakimabadapp.github.io
   ```

2. **Start a local server** (required for YouTube embeds and proper resource loading)
   ```bash
   # Using Python 3
   python3 -m http.server 8000
   
   # Or using Python 2
   python -m SimpleHTTPServer 8000
   
   # Or using Node.js (if http-server is installed)
   npx http-server -p 8000
   ```

3. **Open in browser**
   ```
   http://localhost:8000
   ```

> ⚠️ **Important**: Always use an HTTP server instead of opening files directly (`file://` protocol). YouTube embeds and some features require proper HTTP headers.

## 📁 Project Structure

```
hakimabadapp.github.io/
├── index.html              # Home page with hero and main sections
├── path.html               # Spiritual path guidance
├── audio-*.html            # Audio library pages
├── video.html              # Video gallery
├── video-playlist.html     # Video playlists
├── books.html              # Book library
├── events.html             # Events calendar
├── bio/                    # Biographies of spiritual leaders
│   ├── mmrashid.html
│   ├── msakhter.html
│   └── abhakim.html
├── css/
│   └── styles.css          # Custom styles
├── js/
│   └── app.js              # Main application logic
├── data/                   # JSON data files
│   ├── audio-*.json
│   ├── video-*.json
│   ├── books.json
│   └── events-data.js
├── assets/
│   ├── images/             # Static images
│   ├── fonts/              # Custom fonts
│   └── vendor/             # Third-party libraries (Vue, Tailwind)
└── media/                  # Media resources
    ├── audios/
    └── books/
```

## 🛠️ Technologies Used

| Technology | Purpose |
|------------|---------|
| [Vue.js 3](https://vuejs.org/) | Reactive frontend framework |
| [Tailwind CSS](https://tailwindcss.com/) | Utility-first CSS framework |
| [Google Fonts](https://fonts.google.com/) | Amiri, Inter, Noto Sans Bengali, Playfair Display |
| [YouTube API](https://developers.google.com/youtube) | Video embedding |
| [Babel](https://babeljs.io/) | ES6+ JavaScript transpilation |

## 🎨 Design System

### Color Palette
```css
Primary Green:      #0D5C3D
Primary Dark:       #073D28
Secondary Gold:     #C9A227
Gold Light:         #E5C76B
Cream:              #FFFEF8
Cream Alt:          #F5F5E8
```

### Typography
- **Arabic/Islamic**: Amiri
- **English Body**: Inter
- **Bengali**: Noto Sans Bengali
- **Headings**: Playfair Display

## 📱 Pages Overview

| Page | Description |
|------|-------------|
| `index.html` | Landing page with hero, welcome, quick links |
| `path.html` | Detailed spiritual path information |
| `audio-playlist.html` | Audio lecture playlists |
| `audio-gdrive.html` | Google Drive audio integration |
| `video.html` | Video gallery with YouTube embeds |
| `video-playlist.html` | Curated video playlists |
| `books.html` | Digital book library |
| `events.html` | Upcoming events and mahfils |
| `bio/*.html` | Biographies of spiritual leaders |
| `contact.html` | Contact information and form |

## 🔧 Configuration

### Tailwind Config
Custom colors and fonts are configured in `index.html`:

```javascript
tailwind.config = {
  theme: {
    extend: {
      colors: {
        primary: '#0D5C3D',
        'primary-dark': '#073D28',
        secondary: '#C9A227',
        // ...
      },
      fontFamily: {
        amiri: ['Amiri', 'serif'],
        inter: ['Inter', 'sans-serif'],
        // ...
      }
    }
  }
}
```

## 🐛 Troubleshooting

### YouTube Embed Issues
**Problem**: "Embedded player requires an HTTP server"

**Solution**: 
- Never open HTML files directly via `file://` protocol
- Always use a local development server:
  ```bash
  python3 -m http.server 8000
  ```

### Styles Not Loading
**Check**: 
- Ensure you're running from the project root
- Verify all paths are relative (`./css/styles.css`)

### Vue Components Not Rendering
**Check**:
- Browser console for errors
- Vue CDN is loading correctly
- `[v-cloak]` CSS rule is present

## 📝 TODO

Current development priorities:
- [ ] Remove backdrop blur behind Bismillah in hero section
- [ ] Final verification of all pages for styling consistency
- [ ] Test active page highlighting across all navigation elements
- [ ] Optimize images for better performance

See `TODOs.txt` for detailed task list.

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Contact

**Hakimabad - Khanka-e-Mozaddedia**

- 🌐 Website: [hakimabadapp.github.io](https://hakimabadapp.github.io/)
- 📧 Email: [Contact Form](https://hakimabadapp.github.io/contact.html)
- 📺 YouTube: [Subscribe](https://youtube.com/@hakimabad)

## 🙏 Acknowledgments

- Spiritual guidance from Hazrat Mohammad Mamunur Rashid
- Built with ❤️ for the Hakimabad community
- Inspired by Islamic art and geometric patterns

---

**بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ**

*In the name of Allah, the Most Gracious, the Most Merciful*
