-- ============================================================================
-- Hakimabad Database Schema
-- Comprehensive relational schema for the Hakimabad Islamic Spiritual Center
-- SPA webapp. Covers: audio tracks, videos, playlists, GDrive files,
-- books, links, media, events, blog, FAQ, site config, pages.
-- ============================================================================
-- Target: PostgreSQL 15+ / MySQL 8+ / SQLite 3.40+
-- ============================================================================

BEGIN;

-- ============================================================================
-- 1. SITE CONFIGURATION
-- ============================================================================
CREATE TABLE site_config (
    config_id    INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    site_name    VARCHAR(100) NOT NULL DEFAULT 'Hakimabad',
    tagline      VARCHAR(200) NOT NULL DEFAULT 'Khanka-e-Mozaddedia',
    primary_color     VARCHAR(7)  NOT NULL DEFAULT '#0D5C3D',
    secondary_color   VARCHAR(7)  NOT NULL DEFAULT '#C9A227',
    theme             VARCHAR(50) NOT NULL DEFAULT 'emerald',
    locale            VARCHAR(10) NOT NULL DEFAULT 'bn',
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ============================================================================
-- 2. PAGES (HTML page metadata)
-- ============================================================================
CREATE TABLE pages (
    page_id      INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug         VARCHAR(50)  NOT NULL UNIQUE,
    title        VARCHAR(200) NOT NULL,
    description  TEXT,
    nav_label    VARCHAR(50),
    nav_order    SMALLINT     NOT NULL DEFAULT 0,
    is_published BOOLEAN      NOT NULL DEFAULT true,
    show_in_nav  BOOLEAN      NOT NULL DEFAULT false,
    nav_group    VARCHAR(50),           -- 'main', 'media', 'footer'
    created_at   TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at   TIMESTAMPTZ  NOT NULL DEFAULT now()
);

-- ============================================================================
-- 3. AUDIO SYSTEM
-- ============================================================================
CREATE TABLE audio_sources (
    source_id   INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    source_name VARCHAR(50)  NOT NULL UNIQUE,  -- 'website', 'gdrive', 'local'
    label       VARCHAR(100) NOT NULL,
    description TEXT,
    icon        VARCHAR(50)
);

CREATE TABLE audio_categories (
    category_id   INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name          VARCHAR(100) NOT NULL,
    description   TEXT,
    source_id     INT REFERENCES audio_sources(source_id),
    display_order SMALLINT NOT NULL DEFAULT 0,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE audio_tracks (
    track_id      INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    source_id     INT          NOT NULL REFERENCES audio_sources(source_id),
    category_id   INT          REFERENCES audio_categories(category_id),
    external_id   VARCHAR(100),            -- GDrive file ID or website ID
    title         VARCHAR(500) NOT NULL,
    full_title    VARCHAR(500),
    url           TEXT         NOT NULL,
    size_display  VARCHAR(20),             -- human-readable size e.g. "1.4 MB"
    size_bytes    BIGINT,
    duration      INT,                     -- seconds
    date_code     VARCHAR(10),             -- YYYY-MM or YYYY
    subfolder     VARCHAR(200),
    download_url  TEXT,
    thumbnail_url TEXT,
    mime_type     VARCHAR(100),
    file_format   VARCHAR(10),             -- 'mp3', 'm4a', etc.
    play_count    INT NOT NULL DEFAULT 0,
    is_active     BOOLEAN NOT NULL DEFAULT true,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_audio_tracks_category ON audio_tracks(category_id);
CREATE INDEX idx_audio_tracks_source   ON audio_tracks(source_id);
CREATE INDEX idx_audio_tracks_title    ON audio_tracks USING gin(to_tsvector('simple', title));
CREATE INDEX idx_audio_tracks_date     ON audio_tracks(date_code);

-- ============================================================================
-- 4. VIDEO SYSTEM
-- ============================================================================
CREATE TABLE youtube_channels (
    channel_id      VARCHAR(50) PRIMARY KEY,  -- YouTube channel ID
    name            VARCHAR(200) NOT NULL,
    description     TEXT,
    url             TEXT,
    thumbnail_url   TEXT,
    subscriber_count INT,
    is_active       BOOLEAN NOT NULL DEFAULT true,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE videos (
    video_id        VARCHAR(20) PRIMARY KEY,  -- YouTube video ID (11 chars)
    channel_id      VARCHAR(50) NOT NULL REFERENCES youtube_channels(channel_id),
    title           VARCHAR(500) NOT NULL,
    description     TEXT,
    thumbnail_url   TEXT,
    published_at    TIMESTAMPTZ,
    duration        INT,               -- seconds
    view_count      INT,
    is_active       BOOLEAN NOT NULL DEFAULT true,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_videos_channel     ON videos(channel_id);
CREATE INDEX idx_videos_published   ON videos(published_at DESC);
CREATE INDEX idx_videos_title       ON videos USING gin(to_tsvector('simple', title));

CREATE TABLE playlists (
    playlist_id   INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name          VARCHAR(200) NOT NULL,
    description   TEXT,
    thumbnail_url TEXT,
    is_custom     BOOLEAN NOT NULL DEFAULT true,  -- false for YouTube auto-playlists
    display_order SMALLINT NOT NULL DEFAULT 0,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE playlist_videos (
    playlist_id   INT NOT NULL REFERENCES playlists(playlist_id) ON DELETE CASCADE,
    video_id      VARCHAR(20) NOT NULL REFERENCES videos(video_id) ON DELETE CASCADE,
    position      SMALLINT NOT NULL DEFAULT 0,
    added_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (playlist_id, video_id)
);

CREATE INDEX idx_playlist_videos_video ON playlist_videos(video_id);

-- ============================================================================
-- 5. GOOGLE DRIVE SYSTEM
-- ============================================================================
CREATE TABLE gdrive_folders (
    folder_id     VARCHAR(100) PRIMARY KEY,  -- GDrive folder ID
    name          VARCHAR(200) NOT NULL,
    parent_folder_id VARCHAR(100) REFERENCES gdrive_folders(folder_id),
    description   TEXT,
    url           TEXT,
    category      VARCHAR(50),       -- 'audio', 'books', 'general', 'images'
    file_count    INT NOT NULL DEFAULT 0,
    total_size_bytes BIGINT,
    is_public     BOOLEAN NOT NULL DEFAULT true,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_gdrive_folders_parent ON gdrive_folders(parent_folder_id);

CREATE TABLE gdrive_files (
    file_id       VARCHAR(100) PRIMARY KEY,  -- GDrive file ID
    folder_id     VARCHAR(100) NOT NULL REFERENCES gdrive_folders(folder_id),
    name          VARCHAR(500) NOT NULL,
    mime_type     VARCHAR(200),
    size_display  VARCHAR(20),
    size_bytes    BIGINT,
    modified_at   TIMESTAMPTZ,
    category      VARCHAR(50),    -- 'audio', 'pdf', 'image', 'video', 'document', 'other'
    download_url  TEXT,
    thumbnail_url TEXT,
    subfolder     VARCHAR(200),
    is_active     BOOLEAN NOT NULL DEFAULT true,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_gdrive_files_folder   ON gdrive_files(folder_id);
CREATE INDEX idx_gdrive_files_category ON gdrive_files(category);
CREATE INDEX idx_gdrive_files_name     ON gdrive_files USING gin(to_tsvector('simple', name));

-- ============================================================================
-- 6. LINKS / BOOKMARKS
-- ============================================================================
CREATE TABLE link_categories (
    category_id   INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name          VARCHAR(100) NOT NULL,
    description   TEXT,
    icon          VARCHAR(50),
    display_order SMALLINT NOT NULL DEFAULT 0,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE links (
    link_id       INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    category_id   INT NOT NULL REFERENCES link_categories(category_id) ON DELETE CASCADE,
    title         VARCHAR(300) NOT NULL,
    url           TEXT NOT NULL,
    description   TEXT,
    favicon_url   TEXT,
    is_active     BOOLEAN NOT NULL DEFAULT true,
    display_order SMALLINT NOT NULL DEFAULT 0,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_links_category ON links(category_id);

-- ============================================================================
-- 7. BOOKS / LIBRARY
-- ============================================================================
CREATE TABLE book_categories (
    category_id   INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name          VARCHAR(100) NOT NULL,
    description   TEXT,
    icon          VARCHAR(50),
    display_order SMALLINT NOT NULL DEFAULT 0,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE books (
    book_id       INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    category_id   INT NOT NULL REFERENCES book_categories(category_id) ON DELETE CASCADE,
    title         VARCHAR(500) NOT NULL,
    author        VARCHAR(300),
    url           TEXT NOT NULL,
    language      VARCHAR(50),
    type          VARCHAR(20) NOT NULL DEFAULT 'pdf',  -- 'pdf', 'epub', 'html'
    cover_url     TEXT,
    description   TEXT,
    page_count    INT,
    file_size     VARCHAR(20),
    is_local      BOOLEAN NOT NULL DEFAULT false,
    is_active     BOOLEAN NOT NULL DEFAULT true,
    display_order SMALLINT NOT NULL DEFAULT 0,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_books_category ON books(category_id);
CREATE INDEX idx_books_title    ON books USING gin(to_tsvector('simple', title));

-- ============================================================================
-- 8. LOCAL MEDIA FILES
-- ============================================================================
CREATE TABLE media_files (
    media_id      INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    media_type    VARCHAR(10) NOT NULL,  -- 'audio', 'pdf'
    title         VARCHAR(500) NOT NULL,
    file_path     TEXT NOT NULL,
    file_size     VARCHAR(20),
    size_bytes    BIGINT,
    category      VARCHAR(100),
    language      VARCHAR(50),
    description   TEXT,
    is_active     BOOLEAN NOT NULL DEFAULT true,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_media_files_type ON media_files(media_type);

-- ============================================================================
-- 9. EVENTS
-- ============================================================================
CREATE TABLE events (
    event_id      INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title         VARCHAR(300) NOT NULL,
    description   TEXT,
    event_date    DATE,
    event_time    TIME,
    location      VARCHAR(300),
    latitude      DECIMAL(10,7),
    longitude     DECIMAL(10,7),
    cover_image   TEXT,
    is_upcoming   BOOLEAN NOT NULL DEFAULT true,
    is_active     BOOLEAN NOT NULL DEFAULT true,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_events_date ON events(event_date);

-- ============================================================================
-- 10. FAQ / Q&A
-- ============================================================================
CREATE TABLE faq (
    faq_id        INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    question      TEXT NOT NULL,
    answer        TEXT NOT NULL,
    category      VARCHAR(100),
    display_order SMALLINT NOT NULL DEFAULT 0,
    is_published  BOOLEAN NOT NULL DEFAULT true,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ============================================================================
-- 11. BLOG
-- ============================================================================
CREATE TABLE blog_posts (
    post_id       INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title         VARCHAR(500) NOT NULL,
    slug          VARCHAR(200) NOT NULL UNIQUE,
    excerpt       TEXT,
    content       TEXT,
    author        VARCHAR(200),
    cover_image   TEXT,
    tags          TEXT[],                -- array of tags
    is_published  BOOLEAN NOT NULL DEFAULT false,
    published_at  TIMESTAMPTZ,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_blog_posts_published ON blog_posts(published_at DESC);
CREATE INDEX idx_blog_posts_slug     ON blog_posts(slug);

-- ============================================================================
-- 12. SITE NAVIGATION
-- ============================================================================
CREATE TABLE nav_items (
    nav_item_id   INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    parent_id     INT REFERENCES nav_items(nav_item_id),
    label         VARCHAR(100) NOT NULL,
    url           VARCHAR(300),
    page_id       INT REFERENCES pages(page_id),
    icon          VARCHAR(50),
    nav_group     VARCHAR(50) NOT NULL DEFAULT 'main', -- 'main', 'media_mega', 'mobile', 'bottom'
    display_order SMALLINT NOT NULL DEFAULT 0,
    is_active     BOOLEAN NOT NULL DEFAULT true,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_nav_items_parent ON nav_items(parent_id);

-- ============================================================================
-- 13. USER ANALYTICS / LISTENING HISTORY (optional for SPA)
-- ============================================================================
CREATE TABLE listening_history (
    history_id    INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    track_id      INT REFERENCES audio_tracks(track_id),
    video_id      VARCHAR(20) REFERENCES videos(video_id),
    session_id    VARCHAR(100),
    ip_address    INET,
    played_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
    duration_played INT,               -- seconds actually played
    completed     BOOLEAN NOT NULL DEFAULT false
);

CREATE INDEX idx_history_track ON listening_history(track_id);
CREATE INDEX idx_history_video ON listening_history(video_id);

-- ============================================================================
-- VIEWS
-- ============================================================================

-- Audio overview with source and category names
CREATE VIEW v_audio_overview AS
SELECT
    t.track_id,
    t.title,
    t.full_title,
    t.url,
    t.size_display,
    t.size_bytes,
    t.duration,
    t.date_code,
    t.subfolder,
    t.download_url,
    s.source_name,
    s.label AS source_label,
    c.name AS category_name,
    t.is_active
FROM audio_tracks t
JOIN audio_sources s ON t.source_id = s.source_id
LEFT JOIN audio_categories c ON t.category_id = c.category_id
ORDER BY t.date_code DESC NULLS LAST, t.title;

-- Video overview with channel name
CREATE VIEW v_video_overview AS
SELECT
    v.video_id,
    v.title,
    v.description,
    v.thumbnail_url,
    v.published_at,
    v.duration,
    c.name AS channel_name,
    c.url AS channel_url,
    c.channel_id,
    v.is_active,
    EXTRACT(YEAR FROM v.published_at) AS year
FROM videos v
JOIN youtube_channels c ON v.channel_id = c.channel_id
ORDER BY v.published_at DESC NULLS LAST;

-- Playlist detail with videos
CREATE VIEW v_playlist_detail AS
SELECT
    p.playlist_id,
    p.name AS playlist_name,
    p.description AS playlist_description,
    pv.position,
    v.video_id,
    v.title AS video_title,
    v.thumbnail_url,
    v.published_at,
    c.name AS channel_name
FROM playlists p
JOIN playlist_videos pv ON p.playlist_id = pv.playlist_id
JOIN videos v ON pv.video_id = v.video_id
LEFT JOIN youtube_channels c ON v.channel_id = c.channel_id
ORDER BY p.display_order, pv.position;

-- GDrive overview with folder hierarchy
CREATE VIEW v_gdrive_overview AS
SELECT
    f.file_id,
    f.name AS file_name,
    f.mime_type,
    f.size_display,
    f.size_bytes,
    f.category AS file_category,
    f.download_url,
    f.thumbnail_url,
    f.subfolder,
    fol.name AS folder_name,
    fol.category AS folder_category,
    fol.url AS folder_url
FROM gdrive_files f
JOIN gdrive_folders fol ON f.folder_id = fol.folder_id
WHERE f.is_active = true
ORDER BY fol.name, f.subfolder, f.name;

-- Books with category info
CREATE VIEW v_book_overview AS
SELECT
    b.book_id,
    b.title,
    b.author,
    b.url,
    b.language,
    b.type,
    b.cover_url,
    b.description,
    b.is_local,
    c.name AS category_name,
    c.description AS category_description
FROM books b
JOIN book_categories c ON b.category_id = c.category_id
WHERE b.is_active = true
ORDER BY c.display_order, b.display_order;

-- Links with categories
CREATE VIEW v_link_directory AS
SELECT
    l.link_id,
    l.title,
    l.url,
    l.description,
    c.name AS category_name,
    c.description AS category_description
FROM links l
JOIN link_categories c ON l.category_id = c.category_id
WHERE l.is_active = true
ORDER BY c.display_order, l.display_order;

-- Unified media library (audio + video + books + local files)
CREATE VIEW v_media_library AS
SELECT
    'audio' AS media_type,
    t.track_id AS id,
    t.title,
    t.url,
    t.size_display,
    c.name AS category,
    s.source_name AS source,
    t.date_code AS date_info,
    NULL AS language,
    t.thumbnail_url,
    t.is_active
FROM audio_tracks t
JOIN audio_sources s ON t.source_id = s.source_id
LEFT JOIN audio_categories c ON t.category_id = c.category_id
UNION ALL
SELECT
    'video',
    row_number() OVER ()::int,
    v.title,
    'https://www.youtube.com/watch?v=' || v.video_id,
    NULL,
    c.name,
    'youtube',
    EXTRACT(YEAR FROM v.published_at)::varchar,
    NULL,
    v.thumbnail_url,
    v.is_active
FROM videos v
JOIN youtube_channels c ON v.channel_id = c.channel_id
UNION ALL
SELECT
    'book',
    b.book_id,
    b.title,
    b.url,
    NULL,
    cat.name,
    CASE WHEN b.is_local THEN 'local' ELSE 'gdrive' END,
    b.language,
    b.language,
    b.cover_url,
    b.is_active
FROM books b
JOIN book_categories cat ON b.category_id = cat.category_id
UNION ALL
SELECT
    'local_' || m.media_type,
    m.media_id,
    m.title,
    m.file_path,
    m.file_size,
    m.category,
    'local',
    m.language,
    m.language,
    NULL,
    m.is_active
FROM media_files m;

-- Site search view (unified search across all content types)
CREATE VIEW v_search AS
SELECT
    'page' AS content_type, page_id AS id, title, description AS excerpt, slug AS url_path, NULL AS date_info
FROM pages WHERE is_published = true
UNION ALL
SELECT 'audio', track_id, title, full_title, url, date_code FROM audio_tracks WHERE is_active = true
UNION ALL
SELECT 'video', row_number() OVER ()::int, title, description, 'https://www.youtube.com/watch?v=' || video_id, published_at::varchar FROM videos WHERE is_active = true
UNION ALL
SELECT 'book', book_id, title, author, url, language FROM books WHERE is_active = true
UNION ALL
SELECT 'link', link_id, title, description, url, category_name FROM v_link_directory
UNION ALL
SELECT 'blog', post_id, title, excerpt, slug, published_at::varchar FROM blog_posts WHERE is_published = true;

-- ============================================================================
-- INDEXES FOR FULL-TEXT SEARCH
-- ============================================================================
CREATE INDEX idx_search_content ON audio_tracks USING gin(
    to_tsvector('simple', coalesce(title, '') || ' ' || coalesce(full_title, ''))
);

CREATE INDEX idx_books_search ON books USING gin(
    to_tsvector('simple', coalesce(title, '') || ' ' || coalesce(author, ''))
);

CREATE INDEX idx_gdrive_search ON gdrive_files USING gin(
    to_tsvector('simple', coalesce(name, '') || ' ' || coalesce(subfolder, ''))
);

-- ============================================================================
-- TRIGGER: auto-update updated_at
-- ============================================================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_site_config_updated_at
    BEFORE UPDATE ON site_config
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_pages_updated_at
    BEFORE UPDATE ON pages
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_audio_tracks_updated_at
    BEFORE UPDATE ON audio_tracks
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_videos_updated_at
    BEFORE UPDATE ON videos
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_playlists_updated_at
    BEFORE UPDATE ON playlists
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- SEED: Audio Sources (static reference data)
-- ============================================================================
INSERT INTO audio_sources (source_name, label, description, icon) VALUES
    ('website', 'Website Audio', 'Audio tracks from hakimabad.com', 'globe'),
    ('gdrive',  'GDrive Audio',  'Audio archive from Google Drive',  'cloud'),
    ('local',   'Local Audio',   'Audio files stored on device',     'folder');

-- ============================================================================
-- SEED: Site Configuration
-- ============================================================================
INSERT INTO site_config (site_name, tagline, primary_color, secondary_color, theme, locale)
VALUES ('Hakimabad', 'Khanka-e-Mozaddedia', '#0D5C3D', '#C9A227', 'emerald', 'bn');

-- ============================================================================
-- SEED: Pages
-- ============================================================================
INSERT INTO pages (slug, title, description, nav_label, nav_order, show_in_nav, nav_group) VALUES
    ('index',         'Hakimabad',          'Hakimabad Islamic Spiritual Center',           'Home',       1,  true,  'main'),
    ('about',         'About',              'About Hakimabad Khanka-e-Mozaddedia',          'About',      2,  true,  'main'),
    ('events',        'Events',             'Upcoming events and programs',                 'Events',     4,  true,  'main'),
    ('path',          'The Path',           'The Path - Spiritual program',                 'The Path',   5,  true,  'main'),
    ('tarika',        'Tarika',             'Tarika-e-Khas Mojaddedia',                     'Tarika',     6,  true,  'main'),
    ('contact',       'Contact',            'Contact Hakimabad',                            'Contact',    7,  true,  'main'),
    ('audio-website', 'Website Audio',      'Audio recordings from hakimabad.com',          NULL,         NULL,false, 'media'),
    ('audio-gdrive',  'GDrive Audio',       'Audio archive from Google Drive',              NULL,         NULL,false, 'media'),
    ('video',         'Videos',             'YouTube video library',                        NULL,         NULL,false, 'media'),
    ('playlists',     'Playlists',          'Curated video playlists',                      NULL,         NULL,false, 'media'),
    ('gdrive-media',  'GDrive Media',       'Google Drive media browser',                   NULL,         NULL,false, 'media'),
    ('links',         'Links',              'Useful Islamic links',                         NULL,         NULL,false, 'media'),
    ('books',         'Books',              'Online Islamic library',                       NULL,         NULL,false, 'media'),
    ('blog',          'Blog',               'Hakimabad blog and updates',                   NULL,         NULL,false, 'footer'),
    ('qa',            'QA',                 'Frequently asked questions',                   NULL,         NULL,false, 'footer');

-- ============================================================================
-- SEED: Link Categories
-- ============================================================================
INSERT INTO link_categories (name, description, display_order) VALUES
    ('Islamic Resources', 'Important Islamic websites and resources', 1),
    ('Lectures & Media',  'Islamic lectures and multimedia', 2);

-- ============================================================================
-- SEED: Book Categories
-- ============================================================================
INSERT INTO book_categories (name, description, display_order) VALUES
    ('Tafsir',                'Quranic exegesis and commentary', 1),
    ('Seerah & Biography',    'Life of Prophet Muhammad (SAW) and notable figures', 2),
    ('Tasawwuf & Spirituality','Books on Islamic spirituality and Sufism', 3),
    ('The Path',              'The Path book in multiple languages', 4);

-- ============================================================================
-- SEED: YouTube Channels
-- ============================================================================
INSERT INTO youtube_channels (channel_id, name, description, url) VALUES
    ('UCXuFIrgi5aYbAm3gVNl5-3A', 'mahfil live',
     'Mahfil recordings and lectures',
     'https://www.youtube.com/channel/UCXuFIrgi5aYbAm3gVNl5-3A'),
    ('UC34wiyCiKwn3gxFRMaut1Ww', 'hakimabad dot com',
     'Official Hakimabad YouTube channel',
     'https://www.youtube.com/channel/UC34wiyCiKwn3gxFRMaut1Ww');

-- ============================================================================
-- SEED: Playlists
-- ============================================================================
INSERT INTO playlists (name, description, display_order) VALUES
    ('Annual Mahfil 2025',   'Videos from the Annual Mahfil 2025 event', 1),
    ('Miladunnabi 2025',     'Miladunnabi celebrations and lectures', 2),
    ('Sufism & Tassawuf',    'Lectures on Sufism and spiritual purification', 3);

COMMIT;
