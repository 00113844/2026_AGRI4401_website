# AGRI4401 Precision Agriculture · 2026

[![GitHub Pages](https://img.shields.io/badge/GitHub-Pages-blue?logo=github)](https://00113844.github.io/2026_AGRI4401_website/)

Interactive lecture presentations for AGRI4401 Precision Agriculture course at the University of Western Australia.

## 📋 Project Structure

```
2026_AGRI4401_website/
├── docs/                        # GitHub Pages root (served at /)
│   ├── index.html              # Landing page with lecture listing
│   ├── presentations/          # RevealJS HTML slide decks
│   │   ├── lecture_01.html
│   │   ├── lecture_02.html
│   │   └── ...
│   └── assets/                 # Shared resources
│       ├── css/
│       │   └── AGRI4401_PrecisionAg.css
│       ├── images/
│       │   └── soil-structure.jpg
│       └── js/                 # Custom scripts (if needed)
└── README.md
```

## 🚀 Quick Start

### View Lectures Online
Visit: https://00113844.github.io/2026_AGRI4401_website/

### Run Locally
1. Clone the repository:
   ```bash
   git clone git@github.com:00113844/2026_AGRI4401_website.git
   cd 2026_AGRI4401_website
   ```

2. Open `docs/index.html` in a browser or use a local server:
   ```bash
   # PowerShell
   cd docs
   python -m http.server 8000
   # Visit http://localhost:8000
   ```

## 🛠️ Technology Stack

| Component | Purpose |
|-----------|---------|
| **RevealJS** | Interactive HTML slide framework (CDN-hosted v4.5.0) |
| **Mermaid** | Diagram generation for flowcharts |
| **GitHub Pages** | Static site hosting from `docs/` folder |
| **UWA Branding** | Custom CSS with official university colors |

## 📝 Editing Lectures

### For Pure RevealJS Lectures (lecture_04, 07, 08, 10, 11, 15)
These use CDN-hosted RevealJS and can be edited directly:

1. Open the HTML file in VS Code
2. Edit content within `<section>` tags
3. Preview changes locally
4. Commit and push to GitHub

### For Quarto-Generated Lectures (lecture_01, 02, 05, 06)
⚠️ **Note:** These lectures have Quarto dependencies (`site_libs/`) and may need conversion to pure RevealJS format.

**Option A:** Convert to pure RevealJS
- Remove Quarto-specific scripts and CSS
- Replace with CDN links (see lecture_10.html as template)

**Option B:** Copy `site_libs/` folder
- Copy from existing AGRI4401_website repo
- Place in `docs/` directory

## 🎨 UWA Branding Guidelines

The presentations use official UWA colors:

```css
--uwa-blue: #27348B;    /* Primary brand color */
--uwa-gold: #E2B600;    /* Accent color */
--uwa-navy: #002147;    /* Dark backgrounds */
--uwa-light-grey: #F5F5F5;
--uwa-dark-grey: #333333;
```

## 📤 Publishing Changes

1. **Make edits** to HTML files in `docs/presentations/`
2. **Test locally** in browser
3. **Commit changes:**
   ```bash
   git add docs/
   git commit -m "Update Lecture X: [description]"
   git push origin main
   ```
4. **GitHub Pages automatically deploys** within 1-2 minutes

## 🔧 GitHub Pages Configuration

1. Go to repository **Settings** → **Pages**
2. Set **Source** to: `Deploy from a branch`
3. Select **Branch**: `main`, **Folder**: `/docs`
4. Save

Site will be live at: `https://00113844.github.io/2026_AGRI4401_website/`

## 📚 Lecture List

| Lecture | Title | Status |
|---------|-------|--------|
| 01 | Introduction to Precision Agriculture | ⚠️ Needs conversion |
| 02 | Agricultural Technologies | ⚠️ Needs conversion |
| 04 | Sensing Technologies | ✅ Pure RevealJS |
| 05 | Soil and Water Spatial Variability | ⚠️ Needs conversion |
| 06 | Spatial Data Analysis | ⚠️ Needs conversion |
| 07 | Crop Spatial Variability | ✅ Pure RevealJS |
| 08 | Data Analysis | ✅ Pure RevealJS |
| 10 | Crop Growth Models: APSIM | ✅ Pure RevealJS |
| 11 | Telematics and Data Management | ✅ Pure RevealJS |
| 15 | Satellite Systems in Agriculture | ✅ Pure RevealJS |

## 🐛 Troubleshooting

### Lecture won't load / missing styles
**Problem:** Quarto-generated lectures (01, 02, 05, 06) reference `site_libs/` which doesn't exist.

**Solutions:**
1. Copy `site_libs/` from old AGRI4401_website repo to `docs/`
2. Convert to pure RevealJS format (recommended)

### Images not displaying
Check that image paths reference `../assets/images/[filename]` from presentation files.

### CSS not loading
Verify path in landing page: `href="assets/css/AGRI4401_PrecisionAg.css"`

## 👤 Author

**Gustavo Alckmin**  
School of Agriculture and Environment  
University of Western Australia

## 📄 License

University of Western Australia - AGRI4401 Course Materials
