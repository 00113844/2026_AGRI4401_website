# Clean up remaining Quarto references from converted lectures
# Usage: .\cleanup-quarto-classes.ps1

$lectures = @("lecture_01", "lecture_02", "lecture_05", "lecture_06")
$presentationsDir = "docs\presentations"

foreach ($lecture in $lectures) {
    $inputFile = Join-Path $presentationsDir "$lecture.html"
    
    Write-Host "Cleaning $lecture.html..." -ForegroundColor Cyan
    
    # Read the file
    $content = Get-Content $inputFile -Raw
    
    # Remove quarto-specific classes while keeping basic structure
    $content = $content -replace 'class="quarto-figure quarto-figure-center quarto-float"', 'class="figure"'
    $content = $content -replace 'class="quarto-float quarto-float-fig"', 'class="figure"'
    $content = $content -replace 'class="quarto-float-caption-bottom quarto-float-caption quarto-float-fig quarto-uncaptioned"', 'class="caption"'
    $content = $content -replace 'class="quarto-auto-generated-content"', ''
    $content = $content -replace '(?s)<div class="quarto-title-authors">.*?</div>', ''
    $content = $content -replace '(?s)<div class="quarto-title-author">.*?</div>', ''
    $content = $content -replace 'quarto-', ''
    
    # Write back
    Set-Content -Path $inputFile -Value $content -Encoding UTF8 -NoNewline
    Write-Host "✓ Cleaned $lecture.html" -ForegroundColor Green
}

Write-Host "`nCleanup complete!" -ForegroundColor Cyan
