# Convert Quarto-generated lectures to pure RevealJS
# Usage: .\convert-to-revealjs.ps1

$lectures = @("lecture_01", "lecture_02", "lecture_05", "lecture_06")
$presentationsDir = "docs\presentations"

foreach ($lecture in $lectures) {
    $inputFile = Join-Path $presentationsDir "$lecture.html"
    $backupFile = Join-Path $presentationsDir "$lecture.html.bak"
    
    Write-Host "Processing $lecture.html..." -ForegroundColor Cyan
    
    # Backup original
    Copy-Item $inputFile $backupFile -Force
    
    # Read the file
    $content = Get-Content $inputFile -Raw
    
    # Extract title
    if ($content -match '<h1 class="title">([^<]+)</h1>') {
        $title = $matches[1]
    } else {
        $title = $lecture
    }
    
    # Extract subtitle
    if ($content -match '<p class="subtitle">([^<]+)</p>') {
        $subtitle = $matches[1]
    } else {
        $subtitle = "AGRI4401 · Precision Agriculture"
    }
    
    # Extract author
    if ($content -match '<div class="quarto-title-author-name">\s*([^<\s]+\s+[^<\s]+)') {
        $author = $matches[1].Trim()
    } else {
        $author = "Gustavo Alckmin"
    }
    
    # Extract date
    if ($content -match '<p class="date">([^<]+)</p>') {
        $date = $matches[1]
    } else {
        $date = "2026"
    }
    
    # Extract content between <div class="slides"> and </div> (before closing reveal)
    $startPattern = '<div class="slides">'
    $endPattern = '</div>\s*</div>\s*<script'
    
    if ($content -match "$startPattern([\s\S]*?)$endPattern") {
        $slidesContent = $matches[1]
        
        # Clean up Quarto-specific classes
        $slidesContent = $slidesContent -replace 'class="quarto-title-block center"', 'class="title-slide"'
        $slidesContent = $slidesContent -replace 'class="quarto-title-author-name"', ''
        $slidesContent = $slidesContent -replace 'class="quarto-title-affiliation"', ''
        $slidesContent = $slidesContent -replace '<div class="quarto-title-authors">.*?</div>', ''
        $slidesContent = $slidesContent -replace 'id="quarto-document-content"', ''
        
        # Build new HTML
        $newHtml = @"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="author" content="$author">
  <title>$title</title>
  
  <!-- RevealJS Core -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/reveal.js/4.5.0/reveal.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/reveal.js/4.5.0/theme/white.min.css" id="theme">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/reveal.js/4.5.0/plugin/notes/notes.min.css">
  
  <style>
    /* UWA Branding */
    :root {
      --uwa-blue: #27348B;
      --uwa-gold: #E2B600;
      --uwa-navy: #002147;
      --uwa-light-grey: #F5F5F5;
      --uwa-dark-grey: #333333;
    }

    .reveal {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      color: var(--uwa-dark-grey);
    }

    .reveal h1, .reveal h2, .reveal h3 {
      color: var(--uwa-blue);
      text-transform: none;
      font-weight: 600;
    }

    .reveal .slides section {
      text-align: left;
      font-size: 0.85em;
    }

    .reveal .title-slide {
      text-align: center;
      background: linear-gradient(135deg, var(--uwa-navy) 0%, var(--uwa-blue) 100%);
      color: white;
    }

    .reveal .title-slide h1 {
      color: var(--uwa-gold);
      text-shadow: 2px 2px 4px rgba(0,0,0,0.7);
      margin-bottom: 0.5em;
      font-size: 2.2em;
    }

    .reveal .title-slide p {
      color: var(--uwa-light-grey);
      font-size: 0.9em;
    }

    .reveal section[data-background-color="#27348B"] h2,
    .reveal section[data-background-color="#002147"] h2 {
      color: var(--uwa-gold);
      text-align: center;
      font-size: 1.8em;
      text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
    }

    .reveal ul {
      margin-left: 0;
      list-style-position: outside;
    }

    .reveal li {
      margin-bottom: 0.5em;
      line-height: 1.4;
    }

    .reveal strong {
      color: var(--uwa-blue);
      font-weight: 600;
    }

    .reveal em {
      color: var(--uwa-navy);
      font-style: italic;
    }

    .reveal a {
      color: var(--uwa-blue);
      text-decoration: underline;
    }

    .reveal a:hover {
      color: var(--uwa-gold);
    }

    .reveal code {
      background-color: rgba(39, 52, 139, 0.1);
      padding: 0.1em 0.3em;
      border-radius: 3px;
      font-family: 'Consolas', 'Monaco', monospace;
    }

    .reveal pre code {
      background-color: var(--uwa-navy);
      color: var(--uwa-light-grey);
      padding: 1em;
      border-radius: 5px;
      display: block;
    }

    .reveal .subtitle {
      color: var(--uwa-gold);
      font-size: 0.8em;
      margin-bottom: 1em;
    }

    .reveal .date {
      color: var(--uwa-light-grey);
      font-size: 0.7em;
    }

    /* Learning objectives styling */
    .learning-objectives {
      background-color: rgba(39, 52, 139, 0.05);
      padding: 1.5em;
      border-left: 4px solid var(--uwa-blue);
      margin: 1em 0;
    }

    /* Mermaid diagram styling */
    .mermaid {
      background-color: transparent;
    }
  </style>
</head>
<body>
  <div class="reveal">
    <div class="slides">
$slidesContent
    </div>
  </div>

  <!-- RevealJS Scripts -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/reveal.js/4.5.0/reveal.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/reveal.js/4.5.0/plugin/notes/notes.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/reveal.js/4.5.0/plugin/math/math.min.js"></script>
  
  <!-- Mermaid for diagrams (if needed) -->
  <script type="module">
    import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
    
    mermaid.initialize({
      startOnLoad: true,
      theme: 'base',
      themeVariables: {
        primaryColor: '#27348B',
        primaryTextColor: '#fff',
        primaryBorderColor: '#E2B600',
        lineColor: '#5577BB',
        secondaryColor: '#E2B600',
        tertiaryColor: '#F5F5F5'
      }
    });
  </script>
  
  <!-- RevealJS Initialization -->
  <script>
    Reveal.initialize({
      hash: true,
      slideNumber: 'c/t',
      controls: true,
      progress: true,
      center: false,
      width: 1280,
      height: 720,
      margin: 0.04,
      plugins: [ RevealNotes, RevealMath.KaTeX ]
    });
  </script>
</body>
</html>
"@
        
        # Write new file
        Set-Content -Path $inputFile -Value $newHtml -Encoding UTF8
        Write-Host "✓ Converted $lecture.html to pure RevealJS" -ForegroundColor Green
    } else {
        Write-Host "✗ Could not extract slides content from $lecture.html" -ForegroundColor Red
    }
}

Write-Host "`nConversion complete! Backup files saved with .bak extension" -ForegroundColor Cyan
Write-Host "To restore originals: Copy-Item docs\presentations\*.html.bak docs\presentations\*.html" -ForegroundColor Yellow
