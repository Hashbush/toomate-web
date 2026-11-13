$ErrorActionPreference = "Stop"
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$root = "C:\Users\ajara\.gemini\antigravity\scratch\toomate-web"
$matDir = "$root\materiales"
$srcDir = "$matDir\pdf-src"
$outDir = "$matDir\pdf"

New-Item -ItemType Directory -Force -Path $srcDir | Out-Null
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$pairs = @(
  @("atomo-enlace-eso", "ejercicios-atomo-enlace-eso", "Física y Química ESO"),
  @("campo-electrico-2-bach", "ejercicios-campo-electrico-2-bach", "Física 2º Bachillerato"),
  @("campo-gravitatorio-2-bach", "ejercicios-campo-gravitatorio-2-bach", "Física 2º Bachillerato"),
  @("campo-magnetico-2-bach", "ejercicios-campo-magnetico-2-bach", "Física 2º Bachillerato"),
  @("cinematica-vectorial-1-bach", "ejercicios-cinematica-vectorial-1-bach", "Física 1º Bachillerato"),
  @("derivadas-optimizacion-1-bach", "ejercicios-derivadas-optimizacion-1-bach", "Matemáticas Bachillerato"),
  @("dinamica-newton-1-bach", "ejercicios-dinamica-newton-1-bach", "Física 1º Bachillerato"),
  @("ecuaciones-inecuaciones-4eso", "ejercicios-ecuaciones-inecuaciones-4eso", "Matemáticas 4º ESO"),
  @("equilibrio-quimico-2-bach", "ejercicios-equilibrio-quimico-2-bach", "Química 2º Bachillerato"),
  @("estequiometria-disoluciones-1-bach", "ejercicios-estequiometria-disoluciones-1-bach", "Química 1º Bachillerato"),
  @("formulacion-nomenclatura", "ejercicios-formulacion-nomenclatura", "Física y Química"),
  @("geometria-espacio-2-bach", "ejercicios-geometria-espacio-2-bach", "Matemáticas II 2º Bach"),
  @("inferencia-estadistica-2-bach-ccss", "ejercicios-inferencia-estadistica-2-bach-ccss", "Matemáticas CCSS 2º Bach"),
  @("integrales-2-bach", "ejercicios-integrales-2-bach", "Matemáticas 2º Bachillerato"),
  @("limites-continuidad-2-bach-ccss", "ejercicios-limites-continuidad-2-bach-ccss", "Matemáticas 2º Bachillerato"),
  @("matematica-financiera-1-bach-ccss", "ejercicios-matematica-financiera-1-bach-ccss", "Matemáticas CCSS 1º Bach"),
  @("matrices-2-bach", "ejercicios-matrices-2-bach", "Matemáticas 2º Bachillerato"),
  @("numeros-reales-4eso-academicas", "ejercicios-numeros-reales-4eso-academicas", "Matemáticas 4º ESO"),
  @("numeros-reales-4eso-aplicadas", "ejercicios-numeros-reales-4eso-aplicadas", "Matemáticas 4º ESO"),
  @("ondas-optica-moderna-2-bach", "ejercicios-ondas-optica-moderna-2-bach", "Física 2º Bachillerato"),
  @("polinomios-fracciones-4eso", "ejercicios-polinomios-fracciones-4eso", "Matemáticas ESO"),
  @("probabilidad-normal-2-bach", "ejercicios-probabilidad-normal-2-bach", "Matemáticas 2º Bachillerato"),
  @("programacion-lineal-2-bach", "ejercicios-programacion-lineal-2-bach", "Matemáticas CCSS 2º Bach"),
  @("quimica-organica-2-bach", "ejercicios-quimica-organica-2-bach", "Química 2º Bachillerato"),
  @("reacciones-acido-base-2-bach", "ejercicios-reacciones-acido-base-2-bach", "Química 2º Bachillerato"),
  @("reacciones-redox-2-bach", "ejercicios-reacciones-redox-2-bach", "Química 2º Bachillerato"),
  @("sistemas-rouche-2-bach", "ejercicios-rouche-2-bach", "Matemáticas 2º Bachillerato"),
  @("sucesiones-eso", "ejercicios-sucesiones-eso", "Matemáticas ESO"),
  @("termoquimica-2-bach", "ejercicios-termoquimica-2-bach", "Química 2º Bachillerato"),
  @("trigonometria-1-bach", "ejercicios-trigonometria-1-bach", "Matemáticas I 1º Bach")
)

function Get-ShortSol($solHtml) {
  $m = [regex]::Match($solHtml, '(?s)(?:Resultado|Solución|Respuesta)\s*:\s*(.*?)(?:</div>|</p>)')
  if ($m.Success) {
    $res = ($m.Groups[1].Value -replace '<[^>]+>','' -replace '\$\$','$' -replace '\s+',' ').Trim()
    if ($res.Length -gt 0) { return $res }
  }
  $bolds = [regex]::Matches($solHtml, '\\mathbf\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}')
  if ($bolds.Count -gt 0) {
    $vals = $bolds | ForEach-Object { "$" + $_.Groups[1].Value + "$" }
    return ($vals -join " ; ")
  }
  $elements = [regex]::Matches($solHtml, '(?s)<(?:p|li|div)[^>]*>((?:(?!</(?:p|li|div)>).)*?)</(?:p|li|div)>')
  if ($elements.Count -gt 0) {
    $last = $elements[$elements.Count - 1].Groups[1].Value
    $last = ($last -replace '<[^>]+>','' -replace '\$\$','$' -replace '\s+',' ').Trim()
    if ($last.Length -gt 120) {
      if ($last -match '(?:\\implies|\\rightarrow|=)\s*([^=]+)$') {
        $tail = $matches[1].Trim()
        $dollarCount = ([regex]::Matches($tail, '\$')).Count
        if ($dollarCount % 2 -eq 1) { $tail = "$" + $tail }
        return $tail
      }
      return $last.Substring(0, 110) + "..."
    }
    return $last
  }
  return "Ver desarrollo en Soluciones PDF"
}

foreach ($p in $pairs) {
  $slug = $p[0]
  $ejSlug = $p[1]
  $cursoLabel = $p[2]

  $tPath = "$matDir\$slug.html"
  $ePath = "$matDir\$ejSlug.html"

  $tHtml = [System.IO.File]::ReadAllText($tPath, [System.Text.Encoding]::UTF8)
  $eHtml = [System.IO.File]::ReadAllText($ePath, [System.Text.Encoding]::UTF8)

  # Extract clean title from theory <h1>
  $titleMatch = [regex]::Match($tHtml, '(?s)<h1[^>]*>(.*?)</h1>')
  $topicTitle = if ($titleMatch.Success) { ($titleMatch.Groups[1].Value -replace '<[^>]+>','' -replace '\s+',' ').Trim() } else { $slug }

  # =====================================================================
  # 1. GENERATE FORMULARIO / CÓMO RESOLVER HTML (BLUE THEME)
  # =====================================================================
  $mainMatch = [regex]::Match($tHtml, '(?s)<main[^>]*>(.*?)</main>')
  $mainInner = if ($mainMatch.Success) { $mainMatch.Groups[1].Value } else { $tHtml }

  # Remove <header>...</header> inside <main>
  $mainInner = [regex]::Replace($mainInner, '(?s)<header[^>]*>.*?</header>', '')
  # Remove bottom footer nav inside <main>
  $mainInner = [regex]::Replace($mainInner, '(?s)<!--\s*FOOTER[^>]*-->.*$', '')
  $mainInner = [regex]::Replace($mainInner, '(?s)<div class="[^"]*border-t border-slate-200[^"]*">.*?</div>\s*$', '')
  # Remove formal intro callout before first <section> if it's a long paragraph
  $mainInner = [regex]::Replace($mainInner, '(?s)^\s*<div class="bg-[^"]*rounded-2xl p-5 mb-8">.*?</div>', '')
  # Remove duplicate embedded sample exercise sections at bottom of matrices / rouche
  $mainInner = [regex]::Replace($mainInner, '(?s)<section[^>]*>\s*<h2[^>]*>[^<]*(?:Ejercicios de Examen|Problema Modelo de EvAU)[^<]*</h2>.*?</section>', '')

  # Upgrade small font classes to teen-friendly sizes
  $mainInner = $mainInner -replace 'text-\[10px\]', 'text-sm'
  $mainInner = $mainInner -replace 'text-\[11px\]', 'text-sm'
  $mainInner = $mainInner -replace 'text-xs\s+sm:text-sm', 'text-base'
  $mainInner = $mainInner -replace 'text-xs', 'text-sm'

  $formHtml = @"
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Formulario y Cómo Resolver: $topicTitle | Toomate.es</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@600;700;800&family=Outfit:wght@700;800;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css">
  <script src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/contrib/auto-render.min.js"></script>
  <script src="https://unpkg.com/lucide@latest"></script>
  <style>
    @page {
      size: A4;
      margin: 10mm 12mm;
    }
    * {
      box-sizing: border-box;
      -webkit-print-color-adjust: exact !important;
      print-color-adjust: exact !important;
    }
    body {
      font-family: 'Nunito', sans-serif !important;
      font-weight: 600;
      font-size: 11.2pt;
      line-height: 1.45;
      color: #1e293b;
      margin: 0;
      padding: 0;
      background: #ffffff !important;
    }
    h1, h2, h3, h4 {
      font-family: 'Outfit', sans-serif !important;
    }
    section, .rounded-xl, .rounded-2xl {
      break-inside: avoid;
    }
    .header-box {
      display: flex;
      align-items: center;
      justify-content: space-between;
      background: #eff6ff;
      border: 2.5px solid #bfdbfe;
      border-radius: 18px;
      padding: 11px 16px;
      margin-bottom: 14px;
    }
    .header-left {
      display: flex;
      align-items: center;
      gap: 12px;
    }
    .logo-img {
      width: 52px;
      height: 52px;
      border-radius: 14px;
      border: 2.5px solid #93c5fd;
      object-fit: cover;
      background: white;
      flex-shrink: 0;
    }
    .badge-top {
      display: inline-block;
      background: #5c9ce6;
      color: white;
      font-family: 'Outfit', sans-serif;
      font-weight: 800;
      font-size: 9pt;
      padding: 2px 10px;
      border-radius: 999px;
      letter-spacing: 0.4px;
      text-transform: uppercase;
      margin-bottom: 2px;
    }
    .main-title {
      font-size: 17pt;
      font-weight: 900;
      color: #0f172a;
      margin: 0;
      line-height: 1.15;
    }
    .katex-display {
      overflow-x: auto;
      overflow-y: hidden;
      margin: 0.35em 0 !important;
      max-width: 100%;
    }
  </style>
</head>
<body>
  <div class="header-box">
    <div class="header-left">
      <img src="../../logo-tomate.jpg" class="logo-img" alt="Toomate">
      <div>
        <span class="badge-top">📋 Formulario y Cómo Resolver</span>
        <h1 class="main-title">$topicTitle</h1>
      </div>
    </div>
    <div style="text-align: right; font-family: 'Outfit', sans-serif; font-weight: 800; color: #2563eb; font-size: 12pt; flex-shrink: 0;">
      Toomate.es<br>
      <span style="font-size: 9.5pt; color: #64748b;">$cursoLabel</span>
    </div>
  </div>

  <div class="space-y-4">
    $mainInner
  </div>

  <script>
    document.addEventListener("DOMContentLoaded", function() {
      if (window.lucide) lucide.createIcons();
      renderMathInElement(document.body, {
        delimiters: [
          { left: "`$`$", right: "`$`$", display: true },
          { left: "$", right: "$", display: false }
        ]
      });
    });
  </script>
</body>
</html>
"@
  [System.IO.File]::WriteAllText("$srcDir\formulario-$slug.html", $formHtml, $utf8NoBom)

  # =====================================================================
  # 2 & 3. EXTRACT 22 EXERCISES FOR ENUNCIADOS (GREEN) & SOLUCIONES (RED)
  # =====================================================================
  $blocks = [regex]::Matches($eHtml, '(?s)<p[^>]*>((?:(?!</p>).)*?)</p>\s*<details[^>]*>\s*<summary[^>]*>.*?</summary>\s*(.*?)\s*</details>')

  $enunciadosCards = New-Object System.Text.StringBuilder
  $solucionesCards = New-Object System.Text.StringBuilder

  for ($i = 0; $i -lt $blocks.Count; $i++) {
    $num = $i + 1
    $enunciado = $blocks[$i].Groups[1].Value.Trim()
    $solucionBody = $blocks[$i].Groups[2].Value.Trim()
    $shortSol = Get-ShortSol $solucionBody

    # Level headers at 1, 9, 17
    if ($num -eq 1) {
      [void]$enunciadosCards.AppendLine('<div class="level-banner level-1"><span>🟢 NIVEL 1: Para calentar (Ejercicios 1 al 8)</span></div>')
      [void]$solucionesCards.AppendLine('<div class="level-banner level-1"><span>🟢 NIVEL 1: Para calentar (Enunciados + Solución Paso a Paso)</span></div>')
    } elseif ($num -eq 9) {
      [void]$enunciadosCards.AppendLine('<div class="level-banner level-2"><span>🟡 NIVEL 2: Nivel Examen (Ejercicios 9 al 16)</span></div>')
      [void]$solucionesCards.AppendLine('<div class="level-banner level-2"><span>🟡 NIVEL 2: Nivel Examen (Enunciados + Solución Paso a Paso)</span></div>')
    } elseif ($num -eq 17) {
      [void]$enunciadosCards.AppendLine('<div class="level-banner level-3"><span>🟣 NIVEL 3: Retos para Sacar un 10 (Ejercicios 17 al 22)</span></div>')
      [void]$solucionesCards.AppendLine('<div class="level-banner level-3"><span>🟣 NIVEL 3: Retos para Sacar un 10 (Enunciados + Solución Paso a Paso)</span></div>')
    }

    $numColorEnun = if ($num -le 8) { "#66bb6a" } elseif ($num -le 16) { "#f59e0b" } else { "#8b5cf6" }

    # Enunciado card
    $enunCard = @"
  <div class="ex-card-full">
    <div class="ex-top">
      <span class="ex-num" style="background: $numColorEnun;">$num</span>
      <div class="ex-text">$enunciado</div>
    </div>
    <div class="sol-row-end"><span class="sol-mini"><strong>Sol:</strong> $shortSol</span></div>
  </div>
"@
    [void]$enunciadosCards.AppendLine($enunCard)

    # Solución card (FULL ENUNCIADO + FULL SOLUTION)
    $solCard = @"
  <div class="sol-card">
    <div class="ex-header">
      <span class="ex-num">$num</span>
      <div class="ex-statement">$enunciado</div>
    </div>
    <div class="steps-list">
      $solucionBody
    </div>
  </div>
"@
    [void]$solucionesCards.AppendLine($solCard)
  }

  $enunFullHtml = @"
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Ejercicios (Enunciados): $topicTitle | Toomate.es</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@600;700;800&family=Outfit:wght@700;800;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css">
  <script src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/contrib/auto-render.min.js"></script>
  <style>
    @page {
      size: A4;
      margin: 9mm 12mm;
    }
    * {
      box-sizing: border-box;
      -webkit-print-color-adjust: exact !important;
      print-color-adjust: exact !important;
    }
    body {
      font-family: 'Nunito', sans-serif;
      font-weight: 600;
      font-size: 10.8pt;
      line-height: 1.4;
      color: #1e293b;
      margin: 0;
      padding: 0;
      background: #ffffff;
    }
    h1, h2, h3 {
      font-family: 'Outfit', sans-serif;
    }
    .header-box {
      display: flex;
      align-items: center;
      justify-content: space-between;
      background: #f0fdf4;
      border: 2.5px solid #bbf7d0;
      border-radius: 18px;
      padding: 10px 16px;
      margin-bottom: 12px;
    }
    .header-left {
      display: flex;
      align-items: center;
      gap: 12px;
    }
    .logo-img {
      width: 52px;
      height: 52px;
      border-radius: 14px;
      border: 2.5px solid #86efac;
      object-fit: cover;
      background: white;
      flex-shrink: 0;
    }
    .badge-top {
      display: inline-block;
      background: #66bb6a;
      color: white;
      font-family: 'Outfit', sans-serif;
      font-weight: 800;
      font-size: 9pt;
      padding: 2px 10px;
      border-radius: 999px;
      letter-spacing: 0.4px;
      text-transform: uppercase;
      margin-bottom: 2px;
    }
    .main-title {
      font-size: 17pt;
      font-weight: 900;
      color: #0f172a;
      margin: 0;
      line-height: 1.15;
    }
    .level-banner {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 6px 13px;
      border-radius: 11px;
      margin: 10px 0 7px 0;
      font-family: 'Outfit', sans-serif;
      font-weight: 800;
      font-size: 11.8pt;
    }
    .level-1 { background: #ecfdf5; color: #065f46; border: 2px solid #a7f3d0; }
    .level-2 { background: #fffbeb; color: #92400e; border: 2px solid #fde68a; }
    .level-3 { background: #f5f3ff; color: #5b21b6; border: 2px solid #ddd6fe; }

    .ex-card-full {
      background: #f8fafc;
      border: 1.8px solid #e2e8f0;
      border-radius: 13px;
      padding: 7px 11px;
      margin-bottom: 6px;
      break-inside: avoid;
    }
    .ex-top {
      display: flex;
      align-items: flex-start;
      gap: 9px;
    }
    .ex-num {
      width: 24px;
      height: 24px;
      border-radius: 7px;
      background: #66bb6a;
      color: white;
      font-family: 'Outfit', sans-serif;
      font-weight: 900;
      font-size: 10.8pt;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
      margin-top: 1px;
    }
    .ex-text {
      flex: 1;
      color: #1e293b;
    }
    .sol-row-end {
      display: flex;
      justify-content: flex-end;
      margin-top: 3px;
    }
    .sol-mini {
      font-size: 9.2pt;
      color: #475569;
      background: #ffffff;
      border: 1px solid #cbd5e1;
      border-radius: 7px;
      padding: 1.5px 8px;
      display: inline-block;
      max-width: 92%;
    }
  </style>
</head>
<body>
  <div class="header-box">
    <div class="header-left">
      <img src="../../logo-tomate.jpg" class="logo-img" alt="Toomate">
      <div>
        <span class="badge-top">📄 Hoja de Ejercicios para Practicar</span>
        <h1 class="main-title">$topicTitle</h1>
      </div>
    </div>
    <div style="text-align: right; font-family: 'Outfit', sans-serif; font-weight: 800; color: #16a34a; font-size: 12pt; flex-shrink: 0;">
      Toomate.es<br>
      <span style="font-size: 9.5pt; color: #64748b;">22 Ejercicios con solución final</span>
    </div>
  </div>

$($enunciadosCards.ToString())

  <script>
    document.addEventListener("DOMContentLoaded", function() {
      renderMathInElement(document.body, {
        delimiters: [
          { left: "`$`$", right: "`$`$", display: true },
          { left: "$", right: "$", display: false }
        ]
      });
    });
  </script>
</body>
</html>
"@
  [System.IO.File]::WriteAllText("$srcDir\enunciados-$slug.html", $enunFullHtml, $utf8NoBom)

  $solFullHtml = @"
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Ejercicios con Solución: $topicTitle | Toomate.es</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@600;700;800&family=Outfit:wght@700;800;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css">
  <script src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/contrib/auto-render.min.js"></script>
  <style>
    @page {
      size: A4;
      margin: 10mm 12mm;
    }
    * {
      box-sizing: border-box;
      -webkit-print-color-adjust: exact !important;
      print-color-adjust: exact !important;
    }
    body {
      font-family: 'Nunito', sans-serif !important;
      font-weight: 600;
      font-size: 11pt;
      line-height: 1.42;
      color: #1e293b;
      margin: 0;
      padding: 0;
      background: #ffffff !important;
    }
    h1, h2, h3 {
      font-family: 'Outfit', sans-serif !important;
    }
    .header-box {
      display: flex;
      align-items: center;
      justify-content: space-between;
      background: #fff1f2;
      border: 2.5px solid #fecdd3;
      border-radius: 18px;
      padding: 11px 16px;
      margin-bottom: 14px;
    }
    .header-left {
      display: flex;
      align-items: center;
      gap: 12px;
    }
    .logo-img {
      width: 52px;
      height: 52px;
      border-radius: 14px;
      border: 2.5px solid #fda4af;
      object-fit: cover;
      background: white;
      flex-shrink: 0;
    }
    .badge-top {
      display: inline-block;
      background: #e57373;
      color: white;
      font-family: 'Outfit', sans-serif;
      font-weight: 800;
      font-size: 9pt;
      padding: 2px 10px;
      border-radius: 999px;
      letter-spacing: 0.4px;
      text-transform: uppercase;
      margin-bottom: 2px;
    }
    .main-title {
      font-size: 17pt;
      font-weight: 900;
      color: #0f172a;
      margin: 0;
      line-height: 1.15;
    }
    .level-banner {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 7px 14px;
      border-radius: 12px;
      margin: 11px 0 8px 0;
      font-family: 'Outfit', sans-serif;
      font-weight: 800;
      font-size: 12pt;
    }
    .level-1 { background: #ecfdf5; color: #065f46; border: 2px solid #a7f3d0; }
    .level-2 { background: #fffbeb; color: #92400e; border: 2px solid #fde68a; }
    .level-3 { background: #f5f3ff; color: #5b21b6; border: 2px solid #ddd6fe; }

    .sol-card {
      background: #ffffff;
      border: 2px solid #cbd5e1;
      border-radius: 14px;
      padding: 9px 12px;
      break-inside: avoid;
      margin-bottom: 8px;
    }
    .ex-header {
      display: flex;
      align-items: flex-start;
      gap: 8px;
      margin-bottom: 6px;
      padding-bottom: 5px;
      border-bottom: 1.5px solid #e2e8f0;
    }
    .ex-num {
      width: 24px;
      height: 24px;
      border-radius: 7px;
      background: #e57373;
      color: white;
      font-family: 'Outfit', sans-serif;
      font-weight: 900;
      font-size: 10.8pt;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
      margin-top: 1px;
    }
    .ex-statement {
      font-weight: 700;
      color: #0f172a;
      font-size: 11pt;
      flex: 1;
    }
    .steps-list {
      background: #f8fafc;
      border: 1px solid #e2e8f0;
      border-radius: 10px;
      padding: 6px 10px;
      color: #334155;
      font-size: 10.6pt;
    }
    .steps-list > div {
      border: none !important;
      padding: 0 !important;
      margin: 0 !important;
      background: transparent !important;
      font-size: 10.6pt !important;
    }
    .steps-list p {
      margin: 2.5px 0;
    }
    .katex-display {
      overflow-x: auto;
      overflow-y: hidden;
      margin: 0.3em 0 !important;
      max-width: 100%;
    }
  </style>
</head>
<body>
  <div class="header-box">
    <div class="header-left">
      <img src="../../logo-tomate.jpg" class="logo-img" alt="Toomate">
      <div>
        <span class="badge-top">✅ Ejercicios con Solución Paso a Paso</span>
        <h1 class="main-title">$topicTitle</h1>
      </div>
    </div>
    <div style="text-align: right; font-family: 'Outfit', sans-serif; font-weight: 800; color: #e11d48; font-size: 12pt; flex-shrink: 0;">
      Toomate.es<br>
      <span style="font-size: 9.5pt; color: #64748b;">Enunciados + Solución</span>
    </div>
  </div>

$($solucionesCards.ToString())

  <script>
    document.addEventListener("DOMContentLoaded", function() {
      renderMathInElement(document.body, {
        delimiters: [
          { left: "`$`$", right: "`$`$", display: true },
          { left: "$", right: "$", display: false }
        ]
      });
    });
  </script>
</body>
</html>
"@
  [System.IO.File]::WriteAllText("$srcDir\soluciones-$slug.html", $solFullHtml, $utf8NoBom)
}

Write-Output "Generated HTML sources for all 30 topics (+ 2 existing = 32 topics, 96 HTML files total)!"
