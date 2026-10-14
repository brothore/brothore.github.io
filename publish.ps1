$ErrorActionPreference = 'Stop'
Push-Location (Join-Path $PSScriptRoot 'site')
try {
    node node_modules/astro/astro.js check
    if ($LASTEXITCODE -ne 0) { throw 'Astro check failed' }
    node node_modules/astro/astro.js build
    if ($LASTEXITCODE -ne 0) { throw 'Astro build failed' }
    node node_modules/pagefind/lib/runner/bin.cjs --site dist
    if ($LASTEXITCODE -ne 0) { throw 'Search index build failed' }
    Get-ChildItem -LiteralPath (Join-Path $PSScriptRoot 'site/dist') -Force |
        Copy-Item -Destination $PSScriptRoot -Recurse -Force
    New-Item -ItemType File -Path (Join-Path $PSScriptRoot '.nojekyll') -Force | Out-Null
} finally { Pop-Location }
