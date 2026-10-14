$ErrorActionPreference = 'Stop'
Push-Location (Join-Path $PSScriptRoot 'site')
try {
    node node_modules/astro/astro.js check
    if ($LASTEXITCODE -ne 0) { throw 'Astro check failed' }
    node node_modules/astro/astro.js build
    if ($LASTEXITCODE -ne 0) { throw 'Astro build failed' }
    node node_modules/pagefind/lib/runner/bin.cjs --site dist
    if ($LASTEXITCODE -ne 0) { throw 'Search index build failed' }
} finally { Pop-Location }
Write-Host 'Local build complete. Commit source changes and push; GitHub Actions deploys site/dist.'
