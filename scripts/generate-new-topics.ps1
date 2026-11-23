$ErrorActionPreference = "Stop"
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$root = "C:\Users\ajara\.gemini\antigravity\scratch\toomate-web"
$srcDir = "$root\materiales\pdf-src"
$outDir = "$root\materiales\pdf"

New-Item -ItemType Directory -Force -Path $srcDir | Out-Null
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

function Write-TopicHtmlFiles($slug, $title, $cursoLabel, $formularioBody, $exercises) {
  # 1. FORMULARIO HTML (BLUE)
  $formHtml = @"
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Formulario y Cómo Resolver: $title | Toomate.es</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@600;700;800&family=Outfit:wght@700;800;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css">
  <script src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/contrib/auto-render.min.js"></script>
  <style>
    @page { size: A4; margin: 10mm 12mm; }
    * { box-sizing: border-box; -webkit-print-color-adjust: exact !important; print-color-adjust: exact !important; }
    body { font-family: 'Nunito', sans-serif; font-weight: 600; font-size: 11.2pt; line-height: 1.42; color: #1e293b; margin: 0; padding: 0; background: #ffffff; }
    h1, h2, h3, .font-title { font-family: 'Outfit', sans-serif; }
    .header-box { display: flex; align-items: center; justify-content: space-between; background: #eff6ff; border: 2.5px solid #bfdbfe; border-radius: 18px; padding: 10px 16px; margin-bottom: 12px; }
    .header-left { display: flex; align-items: center; gap: 12px; }
    .logo-img { width: 52px; height: 52px; border-radius: 14px; border: 2.5px solid #93c5fd; object-fit: cover; background: white; }
    .badge-top { display: inline-block; background: #5c9ce6; color: white; font-family: 'Outfit', sans-serif; font-weight: 800; font-size: 9pt; padding: 2px 10px; border-radius: 999px; letter-spacing: 0.4px; text-transform: uppercase; margin-bottom: 2px; }
    .main-title { font-size: 17pt; font-weight: 900; color: #0f172a; margin: 0; line-height: 1.15; }
    .section-card { border: 2px solid #e2e8f0; border-radius: 18px; padding: 11px 14px; margin-bottom: 10px; break-inside: avoid; background: #ffffff; }
    .section-title { display: flex; align-items: center; gap: 9px; font-size: 13pt; font-weight: 900; color: #0f172a; margin: 0 0 8px 0; padding-bottom: 5px; border-bottom: 2px solid #f1f5f9; }
    .num-circle { width: 26px; height: 26px; border-radius: 8px; background: #5c9ce6; color: white; display: inline-flex; align-items: center; justify-content: center; font-family: 'Outfit', sans-serif; font-weight: 900; font-size: 12pt; flex-shrink: 0; }
    .steps-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 9px; }
    .three-cols { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 9px; }
    .step-box { background: #f8fafc; border: 1.5px solid #cbd5e1; border-radius: 13px; padding: 8px 11px; }
    .step-header { font-family: 'Outfit', sans-serif; font-weight: 800; font-size: 11.4pt; color: #1d4ed8; margin-bottom: 3px; display: block; }
    .formula-big { background: #fffbeb; border: 2px solid #fde047; border-radius: 13px; padding: 7px 11px; text-align: center; font-size: 12.5pt; margin: 6px 0; }
    .example-pill { background: #eff6ff; border: 1.5px solid #bfdbfe; border-radius: 10px; padding: 5px 9px; margin-top: 5px; font-size: 10.4pt; color: #1e3a8a; }
    .alert-tip { background: #fef2f2; border: 1.5px solid #fecaca; border-radius: 11px; padding: 6px 11px; margin-top: 7px; color: #991b1b; font-size: 10.4pt; }
    .katex-display { margin: 0.25em 0 !important; }
  </style>
</head>
<body>
  <div class="header-box">
    <div class="header-left">
      <img src="../../logo-tomate.jpg" class="logo-img" alt="Toomate">
      <div>
        <span class="badge-top">📋 Formulario y Cómo Resolver</span>
        <h1 class="main-title">$title</h1>
      </div>
    </div>
    <div style="text-align: right; font-family: 'Outfit', sans-serif; font-weight: 800; color: #2563eb; font-size: 12pt; flex-shrink: 0;">
      Toomate.es<br>
      <span style="font-size: 9.5pt; color: #64748b;">$cursoLabel</span>
    </div>
  </div>

$formularioBody

  <script>
    document.addEventListener("DOMContentLoaded", function() {
      renderMathInElement(document.body, {
        delimiters: [
          { left: "`$`$", right: "`$`$", display: true },
          { left: "`$", right: "`$", display: false }
        ]
      });
    });
  </script>
</body>
</html>
"@
  [System.IO.File]::WriteAllText("$srcDir\formulario-$slug.html", $formHtml, $utf8NoBom)

  # 2 & 3. ENUNCIADOS (GREEN) & SOLUCIONES (RED)
  $enunciadosCards = New-Object System.Text.StringBuilder
  $solucionesCards = New-Object System.Text.StringBuilder

  for ($i = 0; $i -lt $exercises.Count; $i++) {
    $num = $i + 1
    $enun = $exercises[$i][0]
    $shortSol = $exercises[$i][1]
    $fullSol = $exercises[$i][2]

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

    $enunCard = @"
  <div class="ex-card-full">
    <div class="ex-top">
      <span class="ex-num" style="background: $numColorEnun;">$num</span>
      <div class="ex-text">$enun</div>
    </div>
    <div class="sol-row-end"><span class="sol-mini"><strong>Sol:</strong> $shortSol</span></div>
  </div>
"@
    [void]$enunciadosCards.AppendLine($enunCard)

    $solCard = @"
  <div class="sol-card">
    <div class="ex-header">
      <span class="ex-num">$num</span>
      <div class="ex-statement">$enun</div>
    </div>
    <div class="steps-list">
      $fullSol
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
  <title>Ejercicios (Enunciados): $title | Toomate.es</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@600;700;800&family=Outfit:wght@700;800;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css">
  <script src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/contrib/auto-render.min.js"></script>
  <style>
    @page { size: A4; margin: 9mm 12mm; }
    * { box-sizing: border-box; -webkit-print-color-adjust: exact !important; print-color-adjust: exact !important; }
    body { font-family: 'Nunito', sans-serif; font-weight: 600; font-size: 10.8pt; line-height: 1.4; color: #1e293b; margin: 0; padding: 0; background: #ffffff; }
    h1, h2, h3 { font-family: 'Outfit', sans-serif; }
    .header-box { display: flex; align-items: center; justify-content: space-between; background: #f0fdf4; border: 2.5px solid #bbf7d0; border-radius: 18px; padding: 10px 16px; margin-bottom: 12px; }
    .header-left { display: flex; align-items: center; gap: 12px; }
    .logo-img { width: 52px; height: 52px; border-radius: 14px; border: 2.5px solid #86efac; object-fit: cover; background: white; flex-shrink: 0; }
    .badge-top { display: inline-block; background: #66bb6a; color: white; font-family: 'Outfit', sans-serif; font-weight: 800; font-size: 9pt; padding: 2px 10px; border-radius: 999px; letter-spacing: 0.4px; text-transform: uppercase; margin-bottom: 2px; }
    .main-title { font-size: 17pt; font-weight: 900; color: #0f172a; margin: 0; line-height: 1.15; }
    .level-banner { display: flex; align-items: center; gap: 10px; padding: 6px 13px; border-radius: 11px; margin: 10px 0 7px 0; font-family: 'Outfit', sans-serif; font-weight: 800; font-size: 11.8pt; }
    .level-1 { background: #ecfdf5; color: #065f46; border: 2px solid #a7f3d0; }
    .level-2 { background: #fffbeb; color: #92400e; border: 2px solid #fde68a; }
    .level-3 { background: #f5f3ff; color: #5b21b6; border: 2px solid #ddd6fe; }
    .ex-card-full { background: #f8fafc; border: 1.8px solid #e2e8f0; border-radius: 13px; padding: 7px 11px; margin-bottom: 6px; break-inside: avoid; }
    .ex-top { display: flex; align-items: flex-start; gap: 9px; }
    .ex-num { width: 24px; height: 24px; border-radius: 7px; background: #66bb6a; color: white; font-family: 'Outfit', sans-serif; font-weight: 900; font-size: 10.8pt; display: inline-flex; align-items: center; justify-content: center; flex-shrink: 0; margin-top: 1px; }
    .ex-text { flex: 1; color: #1e293b; }
    .sol-row-end { display: flex; justify-content: flex-end; margin-top: 3px; }
    .sol-mini { font-size: 9.2pt; color: #475569; background: #ffffff; border: 1px solid #cbd5e1; border-radius: 7px; padding: 1.5px 8px; display: inline-block; max-width: 92%; }
  </style>
</head>
<body>
  <div class="header-box">
    <div class="header-left">
      <img src="../../logo-tomate.jpg" class="logo-img" alt="Toomate">
      <div>
        <span class="badge-top">📄 Hoja de Ejercicios para Practicar</span>
        <h1 class="main-title">$title</h1>
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
          { left: "`$", right: "`$", display: false }
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
  <title>Ejercicios con Solución: $title | Toomate.es</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@600;700;800&family=Outfit:wght@700;800;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.css">
  <script src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/katex.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/katex@0.16.11/dist/contrib/auto-render.min.js"></script>
  <style>
    @page { size: A4; margin: 10mm 12mm; }
    * { box-sizing: border-box; -webkit-print-color-adjust: exact !important; print-color-adjust: exact !important; }
    body { font-family: 'Nunito', sans-serif !important; font-weight: 600; font-size: 11pt; line-height: 1.42; color: #1e293b; margin: 0; padding: 0; background: #ffffff !important; }
    h1, h2, h3 { font-family: 'Outfit', sans-serif !important; }
    .header-box { display: flex; align-items: center; justify-content: space-between; background: #fff1f2; border: 2.5px solid #fecdd3; border-radius: 18px; padding: 11px 16px; margin-bottom: 14px; }
    .header-left { display: flex; align-items: center; gap: 12px; }
    .logo-img { width: 52px; height: 52px; border-radius: 14px; border: 2.5px solid #fda4af; object-fit: cover; background: white; flex-shrink: 0; }
    .badge-top { display: inline-block; background: #e57373; color: white; font-family: 'Outfit', sans-serif; font-weight: 800; font-size: 9pt; padding: 2px 10px; border-radius: 999px; letter-spacing: 0.4px; text-transform: uppercase; margin-bottom: 2px; }
    .main-title { font-size: 17pt; font-weight: 900; color: #0f172a; margin: 0; line-height: 1.15; }
    .level-banner { display: flex; align-items: center; gap: 10px; padding: 7px 14px; border-radius: 12px; margin: 11px 0 8px 0; font-family: 'Outfit', sans-serif; font-weight: 800; font-size: 12pt; }
    .level-1 { background: #ecfdf5; color: #065f46; border: 2px solid #a7f3d0; }
    .level-2 { background: #fffbeb; color: #92400e; border: 2px solid #fde68a; }
    .level-3 { background: #f5f3ff; color: #5b21b6; border: 2px solid #ddd6fe; }
    .sol-card { background: #ffffff; border: 2px solid #cbd5e1; border-radius: 14px; padding: 9px 12px; break-inside: avoid; margin-bottom: 8px; }
    .ex-header { display: flex; align-items: flex-start; gap: 8px; margin-bottom: 6px; padding-bottom: 5px; border-bottom: 1.5px solid #e2e8f0; }
    .ex-num { width: 24px; height: 24px; border-radius: 7px; background: #e57373; color: white; font-family: 'Outfit', sans-serif; font-weight: 900; font-size: 10.8pt; display: inline-flex; align-items: center; justify-content: center; flex-shrink: 0; margin-top: 1px; }
    .ex-statement { font-weight: 700; color: #0f172a; font-size: 11pt; flex: 1; }
    .steps-list { background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 10px; padding: 6px 10px; color: #334155; font-size: 10.6pt; }
    .steps-list p { margin: 2.5px 0; }
    .res-badge { display: inline-block; background: #dcfce7; color: #166534; border: 1.5px solid #86efac; border-radius: 8px; padding: 2px 9px; font-weight: 800; margin-top: 4px; }
    .katex-display { overflow-x: auto; overflow-y: hidden; margin: 0.3em 0 !important; max-width: 100%; }
  </style>
</head>
<body>
  <div class="header-box">
    <div class="header-left">
      <img src="../../logo-tomate.jpg" class="logo-img" alt="Toomate">
      <div>
        <span class="badge-top">✅ Ejercicios con Solución Paso a Paso</span>
        <h1 class="main-title">$title</h1>
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
          { left: "`$", right: "`$", display: false }
        ]
      });
    });
  </script>
</body>
</html>
"@
  [System.IO.File]::WriteAllText("$srcDir\soluciones-$slug.html", $solFullHtml, $utf8NoBom)
}

# ==============================================================================
# TEMA 1: ECUACIONES (3º y 4º ESO) -> slug: ecuaciones-3-4-eso
# ==============================================================================
$formEcuaciones = @'
  <div class="section-card">
    <h2 class="section-title"><span class="num-circle">1</span><span>Ecuaciones de 1º y 2º Grado (Completas e Incompletas)</span></h2>
    <div class="steps-grid">
      <div class="step-box">
        <span class="step-header">👉 1º Grado con Paréntesis y Fracciones</span>
        <div><strong>1.</strong> Quita paréntesis multiplicando (¡cuidado con el signo $-$ delante!).<br><strong>2.</strong> Haz el <strong>m.c.m.</strong> de los denominadores: divide entre el de abajo y multiplica por el de arriba.<br><strong>3.</strong> Pasa las $x$ a un lado y los números al otro.</div>
        <div class="example-pill">$\dfrac{x-1}{2} - \dfrac{x-3}{3} = 1 \xrightarrow{\text{mcm}=6} 3(x-1) - 2(x-3) = 6 \rightarrow \mathbf{x = 3}$</div>
      </div>
      <div class="step-box">
        <span class="step-header">⭐ 2º Grado ($ax^2 + bx + c = 0$)</span>
        <div class="formula-big">$$x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$$</div>
        <div>&bull; <strong>Falta la $x$ ($ax^2+c=0$):</strong> Despeja $x^2$ y haz $\pm\sqrt{\dots}$<br>&bull; <strong>Falta el número ($ax^2+bx=0$):</strong> Saca $x$ factor común ($x=0$ siempre es solución).</div>
      </div>
    </div>
  </div>

  <div class="section-card">
    <h2 class="section-title"><span class="num-circle">2</span><span>Ecuaciones Bicuadradas y de Grado Superior (Ruffini)</span></h2>
    <div class="steps-grid">
      <div class="step-box">
        <span class="step-header">🔄 Ecuaciones Bicuadradas ($ax^4 + bx^2 + c = 0$)</span>
        <div>No tienen $x^3$ ni $x$. Se resuelven en <strong>3 pasos</strong>:</div>
        <div><strong>Paso 1:</strong> Haz el cambio $\mathbf{t = x^2}$ (así $x^4 = t^2$).<br><strong>Paso 2:</strong> Resuelve $at^2 + bt + c = 0$ con la fórmula.<br><strong>Paso 3:</strong> Deshaz el cambio: $\mathbf{x = \pm\sqrt{t}}$ (por cada $t > 0$ salen 2 soluciones).</div>
        <div class="example-pill">Si $t_1 = 4 \rightarrow x = \pm\sqrt{4} = \mathbf{\pm 2}$. Si $t_2 = -1 \rightarrow$ No da solución real.</div>
      </div>
      <div class="step-box">
        <span class="step-header">🧩 Grado 3 o más ($P(x) = 0$)</span>
        <div><strong>1.</strong> Si todos llevan $x$, saca <strong>factor común</strong> ($x = 0$).<br><strong>2.</strong> Busca las raíces enteras entre los divisores del término independiente aplicando la <strong>Regla de Ruffini</strong> hasta bajar a grado 2.</div>
        <div class="example-pill">$x^3 - 6x^2 + 11x - 6 = 0 \rightarrow (x-1)(x-2)(x-3) = 0$<br>Soluciones: $\mathbf{x_1 = 1, \ x_2 = 2, \ x_3 = 3}$.</div>
      </div>
    </div>
  </div>

  <div class="section-card" style="margin-bottom: 0;">
    <h2 class="section-title"><span class="num-circle">3</span><span>Ecuaciones Racionales (con $x$ abajo) e Irracionales (con Raíces)</span></h2>
    <div class="steps-grid">
      <div class="step-box">
        <span class="step-header">➗ Racionales ($x$ en el denominador)</span>
        <div><strong>Paso 1:</strong> Factoriza los denominadores y halla su <strong>m.c.m.</strong><br><strong>Paso 2:</strong> Multiplica toda la ecuación por el m.c.m. para quitar denominadores.<br><strong>Paso 3:</strong> <strong>¡Comprueba!</strong> Si una solución hace cero algún denominador inicial, se descarta.</div>
        <div class="example-pill">$\dfrac{2}{x-1} + \dfrac{1}{x+1} = 1 \xrightarrow{\text{mcm}=(x-1)(x+1)} 2(x+1)+(x-1) = x^2-1$</div>
      </div>
      <div class="step-box">
        <span class="step-header">√ Irracionales (con $x$ dentro de una raíz)</span>
        <div><strong>Paso 1:</strong> Deja la raíz <strong>totalmente sola</strong> en un lado.<br><strong>Paso 2:</strong> Eleva ambos lados al cuadrado (usa $(a\pm b)^2 = a^2 \pm 2ab + b^2$).<br><strong>Paso 3:</strong> <strong>¡OBLIGATORIO COMPROBAR!</strong> Sustituye en la original porque al elevar al cuadrado pueden aparecer soluciones falsas.</div>
        <div class="example-pill">$\sqrt{x+4} = x - 2 \rightarrow x+4 = (x-2)^2 \rightarrow x_1=0\text{ (No vale)}, \ \mathbf{x_2=5\text{ (Sí)}}$</div>
      </div>
    </div>
  </div>
'@

$exEcuaciones = @(
  @('Resuelve la ecuación de primer grado con paréntesis: $4(2x - 3) - 3(x - 1) = 2(x + 3)$', '$x = 5$', '<p>1. Quitamos paréntesis: $8x - 12 - 3x + 3 = 2x + 6 \implies 5x - 9 = 2x + 6$</p><p>2. Agrupamos términos: $5x - 2x = 6 + 9 \implies 3x = 15 \implies x = \dfrac{15}{3} = 5$</p><span class="res-badge">Solución: $x = 5$</span>'),
  @('Resuelve quitando denominadores: $\dfrac{2x - 1}{3} - \dfrac{x - 4}{6} = 1$', '$x = 4/3$', '<p>1. Multiplicamos toda la ecuación por el $\text{m.c.m.}(3, 6) = 6$: $2(2x - 1) - 1(x - 4) = 6$</p><p>2. Quitamos paréntesis: $4x - 2 - x + 4 = 6 \implies 3x + 2 = 6 \implies 3x = 4 \implies x = \dfrac{4}{3}$</p><span class="res-badge">Solución: $x = \dfrac{4}{3}$</span>'),
  @('Resuelve la ecuación con fracciones: $\dfrac{x + 3}{2} - \dfrac{2x - 1}{5} = 2$', '$x = 3$', '<p>1. Multiplicamos toda la ecuación por el $\text{m.c.m.}(2, 5) = 10$:</p><p>$$5(x + 3) - 2(2x - 1) = 20$$</p><p>2. Quitamos paréntesis: $5x + 15 - 4x + 2 = 20 \implies x + 17 = 20 \implies x = 3$</p><span class="res-badge">Solución: $x = 3$</span>'),
  @('Resuelve la ecuación de segundo grado incompleta: $3x^2 - 75 = 0$', '$x_1 = 5, \ x_2 = -5$', '<p>1. Despejamos $x^2$: $3x^2 = 75 \implies x^2 = \dfrac{75}{3} = 25$</p><p>2. Extraemos la raíz cuadrada con doble signo: $x = \pm\sqrt{25} = \pm 5$</p><span class="res-badge">Solución: $x_1 = 5, \ x_2 = -5$</span>'),
  @('Resuelve la ecuación de segundo grado incompleta: $4x^2 - 20x = 0$', '$x_1 = 0, \ x_2 = 5$', '<p>1. Sacamos factor común $4x$: $4x(x - 5) = 0$</p><p>2. Igualamos cada factor a cero: $4x = 0 \implies x_1 = 0$; y $x - 5 = 0 \implies x_2 = 5$</p><span class="res-badge">Solución: $x_1 = 0, \ x_2 = 5$</span>'),
  @('Resuelve la ecuación de segundo grado completa: $x^2 - 7x + 10 = 0$', '$x_1 = 5, \ x_2 = 2$', '<p>1. Aplicamos la fórmula general con $a = 1, b = -7, c = 10$:</p><p>$$x = \frac{7 \pm \sqrt{(-7)^2 - 4(1)(10)}}{2} = \frac{7 \pm \sqrt{49 - 40}}{2} = \frac{7 \pm 3}{2}$$</p><p>2. Obtenemos las dos soluciones: $x_1 = \dfrac{10}{2} = 5$ y $x_2 = \dfrac{4}{2} = 2$</p><span class="res-badge">Solución: $x_1 = 5, \ x_2 = 2$</span>'),
  @('Resuelve la ecuación de segundo grado: $2x^2 + 3x - 2 = 0$', '$x_1 = 1/2, \ x_2 = -2$', '<p>1. Aplicamos la fórmula general con $a = 2, b = 3, c = -2$:</p><p>$$x = \frac{-3 \pm \sqrt{3^2 - 4(2)(-2)}}{2 \cdot 2} = \frac{-3 \pm \sqrt{9 + 16}}{4} = \frac{-3 \pm 5}{4}$$</p><p>2. Soluciones: $x_1 = \dfrac{2}{4} = \dfrac{1}{2}$ y $x_2 = \dfrac{-8}{4} = -2$</p><span class="res-badge">Solución: $x_1 = \dfrac{1}{2}, \ x_2 = -2$</span>'),
  @('Resuelve sin desarrollar los factores: $(x - 4)(2x + 6)(x^2 - 9) = 0$', '$x = 4, \ x = -3, \ x = 3$', '<p>1. Un producto vale cero cuando alguno de sus factores es cero:</p><p>&bull; $x - 4 = 0 \implies x_1 = 4$</p><p>&bull; $2x + 6 = 0 \implies x_2 = -3$</p><p>&bull; $x^2 - 9 = 0 \implies x = \pm 3$</p><span class="res-badge">Solución: $x_1 = 4, \ x_2 = 3, \ x_3 = -3$</span>'),
  @('Resuelve desarrollando los productos notables: $(x + 2)^2 - (x - 1)^2 = x^2 + 3$', '$x_1 = 0, \ x_2 = 6$', '<p>1. Desarrollamos las identidades notables: $(x^2 + 4x + 4) - (x^2 - 2x + 1) = x^2 + 3$</p><p>2. Simplificamos el miembro izquierdo: $6x + 3 = x^2 + 3 \implies x^2 - 6x = 0$</p><p>3. Sacamos factor común: $x(x - 6) = 0 \implies x_1 = 0, \ x_2 = 6$</p><span class="res-badge">Solución: $x_1 = 0, \ x_2 = 6$</span>'),
  @('Resuelve la ecuación de segundo grado con denominadores: $\dfrac{x^2 - 1}{3} + \dfrac{x + 2}{2} = 3$', '$x_1 = 2, \ x_2 = -7/2$', '<p>1. Multiplicamos por el $\text{m.c.m.}(3, 2) = 6$: $2(x^2 - 1) + 3(x + 2) = 18$</p><p>2. Ordenamos: $2x^2 - 2 + 3x + 6 - 18 = 0 \implies 2x^2 + 3x - 14 = 0$</p><p>3. Fórmula general: $x = \dfrac{-3 \pm \sqrt{9 + 112}}{4} = \dfrac{-3 \pm 11}{4} \implies x_1 = 2, \ x_2 = -\dfrac{7}{2}$</p><span class="res-badge">Solución: $x_1 = 2, \ x_2 = -\dfrac{7}{2}$</span>'),
  @('Resuelve la ecuación bicuadrada: $x^4 - 13x^2 + 36 = 0$', '$x = \pm 3, \ x = \pm 2$', '<p>1. Cambio de variable $t = x^2$: $t^2 - 13t + 36 = 0$</p><p>2. Resolvemos para $t$: $t = \dfrac{13 \pm \sqrt{169 - 144}}{2} = \dfrac{13 \pm 5}{2} \implies t_1 = 9, \ t_2 = 4$</p><p>3. Deshacemos el cambio: $x = \pm\sqrt{9} = \pm 3$ y $x = \pm\sqrt{4} = \pm 2$</p><span class="res-badge">Solución: $x_1 = 3, \ x_2 = -3, \ x_3 = 2, \ x_4 = -2$</span>'),
  @('Resuelve la ecuación bicuadrada: $x^4 - 8x^2 - 9 = 0$', '$x_1 = 3, \ x_2 = -3$', '<p>1. Cambio de variable $t = x^2$: $t^2 - 8t - 9 = 0$</p><p>2. Resolvemos para $t$: $t = \dfrac{8 \pm \sqrt{64 + 36}}{2} = \dfrac{8 \pm 10}{2} \implies t_1 = 9, \ t_2 = -1$</p><p>3. Deshacemos el cambio: de $t_1 = 9 \implies x = \pm\sqrt{9} = \pm 3$. De $t_2 = -1$ no hay solución real.</p><span class="res-badge">Solución: $x_1 = 3, \ x_2 = -3$</span>'),
  @('Resuelve factorizando por Ruffini: $x^3 - 4x^2 + x + 6 = 0$', '$x_1 = -1, \ x_2 = 2, \ x_3 = 3$', '<p>1. Probamos divisores de $6$ por Ruffini: con $x = -1$ queda cociente $x^2 - 5x + 6$ y resto $0$.</p><p>2. Resolvemos $x^2 - 5x + 6 = 0 \implies x = \dfrac{5 \pm \sqrt{25 - 24}}{2} \implies x_2 = 3, \ x_3 = 2$.</p><span class="res-badge">Solución: $x_1 = -1, \ x_2 = 2, \ x_3 = 3$</span>'),
  @('Resuelve la ecuación de cuarto grado: $x^4 - 5x^3 + 6x^2 = 0$', '$x_1 = 0\text{ (doble)}, \ x_2 = 2, \ x_3 = 3$', '<p>1. Sacamos factor común $x^2$: $x^2(x^2 - 5x + 6) = 0$</p><p>2. De $x^2 = 0 \implies x_1 = 0$ (doble). De $x^2 - 5x + 6 = 0 \implies x_2 = 2, \ x_3 = 3$.</p><span class="res-badge">Solución: $x_1 = 0, \ x_2 = 2, \ x_3 = 3$</span>'),
  @('Resuelve la ecuación racional: $\dfrac{x}{x - 1} + \dfrac{2}{x + 1} = 2$', '$x = 5$', '<p>1. $\text{m.c.m.} = (x - 1)(x + 1) = x^2 - 1$. Multiplicamos toda la ecuación:</p><p>$$x(x + 1) + 2(x - 1) = 2(x^2 - 1) \implies x^2 + x + 2x - 2 = 2x^2 - 2$$</p><p>2. Simplificamos: $x^2 - 3x = 0 \implies x(x - 3) = 0 \implies x_1 = 0, \ x_2 = 3$. Ambas son válidas ($x \neq \pm 1$).</p><span class="res-badge">Solución: $x_1 = 0, \ x_2 = 3$</span>'),
  @('Resuelve la ecuación irracional y comprueba las soluciones: $\sqrt{2x + 3} = x$', '$x = 3$', '<p>1. Elevamos ambos miembros al cuadrado: $2x + 3 = x^2 \implies x^2 - 2x - 3 = 0$</p><p>2. Resolvemos: $x = \dfrac{2 \pm \sqrt{4 + 12}}{2} = \dfrac{2 \pm 4}{2} \implies x_1 = 3, \ x_2 = -1$</p><p>3. Comprobación: Para $x = 3 \implies \sqrt{9} = 3$ (Válida). Para $x = -1 \implies \sqrt{1} = 1 \neq -1$ (Falsa).</p><span class="res-badge">Solución: $x = 3$</span>'),
  @('Resuelve la ecuación irracional: $x - \sqrt{x + 1} = 5$', '$x = 8$', '<p>1. Aislamos la raíz en un miembro: $x - 5 = \sqrt{x + 1}$</p><p>2. Elevamos al cuadrado: $(x - 5)^2 = x + 1 \implies x^2 - 10x + 25 = x + 1 \implies x^2 - 11x + 24 = 0$</p><p>3. Fórmula de 2º grado: $x_1 = 8, \ x_2 = 3$. Comprobamos: $x = 8 \implies 8 - \sqrt{9} = 5$ (Válida); $x = 3 \implies 3 - \sqrt{4} = 1 \neq 5$ (No válida).</p><span class="res-badge">Solución: $x = 8$</span>'),
  @('Resuelve la ecuación con dos raíces cuadradas: $\sqrt{x + 4} + \sqrt{x - 1} = 5$', '$x = 5$', '<p>1. Pasamos una raíz al otro lado: $\sqrt{x + 4} = 5 - \sqrt{x - 1}$</p><p>2. Elevamos al cuadrado: $x + 4 = 25 - 10\sqrt{x - 1} + (x - 1) \implies 10\sqrt{x - 1} = 20 \implies \sqrt{x - 1} = 2$</p><p>3. Elevamos de nuevo al cuadrado: $x - 1 = 4 \implies x = 5$. Comprobación: $\sqrt{9} + \sqrt{4} = 3 + 2 = 5$ (Válida).</p><span class="res-badge">Solución: $x = 5$</span>'),
  @('Resuelve la ecuación racional y descarta soluciones que anulen denominadores: $\dfrac{3}{x - 2} - \dfrac{1}{x + 2} = \dfrac{12}{x^2 - 4}$', 'Sin solución ($x = 2$ no válida)', '<p>1. Como $x^2 - 4 = (x - 2)(x + 2)$, multiplicamos por $(x - 2)(x + 2)$:</p><p>$$3(x + 2) - 1(x - 2) = 12 \implies 3x + 6 - x + 2 = 12 \implies 2x = 4 \implies x = 2$$</p><p>2. Comprobación: $x = 2$ anula el denominador $x - 2 = 0$, por lo que se descarta.</p><span class="res-badge">Solución: No tiene solución</span>'),
  @('Resuelve la ecuación exponencial reduciendo a la misma base: $2^{x+1} + 2^x + 2^{x-1} = 28$', '$x = 3$', '<p>1. Descomponemos las potencias: $2 \cdot 2^x + 2^x + \dfrac{2^x}{2} = 28$</p><p>2. Sacamos factor común $2^x$: $2^x \cdot \left(2 + 1 + \dfrac{1}{2}\right) = 28 \implies 2^x \cdot \dfrac{7}{2} = 28 \implies 2^x = 8 = 2^3 \implies x = 3$</p><span class="res-badge">Solución: $x = 3$</span>'),
  @('Un jardín rectangular mide $6\text{ m}$ más de largo que de ancho y su área es de $91\text{ m}^2$. Calcula las dimensiones del jardín.', 'Ancho $= 7\text{ m}$, Largo $= 13\text{ m}$', '<p>1. Llamamos $x$ al ancho y $x + 6$ al largo. El área es $x(x + 6) = 91 \implies x^2 + 6x - 91 = 0$</p><p>2. Resolvemos: $x = \dfrac{-6 \pm \sqrt{36 + 364}}{2} = \dfrac{-6 \pm 20}{2} \implies x_1 = 7\text{ m}$ ($x_2 = -13$ se descarta por ser negativa).</p><p>3. Dimensiones: Ancho $= 7\text{ m}$ y Largo $= 7 + 6 = 13\text{ m}$.</p><span class="res-badge">Solución: $7\text{ m} \times 13\text{ m}$</span>'),
  @('Dos grifos llenan juntos un depósito en $2\text{ horas}$. Si el primero tarda por sí solo $3\text{ horas}$ menos que el segundo, ¿cuánto tarda cada grifo por separado?', '$3\text{ horas}$ y $6\text{ horas}$', '<p>1. Si el 2º grifo tarda $x$ horas y el 1º tarda $x - 3$ horas, en 1 hora llenan juntos: $\dfrac{1}{x - 3} + \dfrac{1}{x} = \dfrac{1}{2}$</p><p>2. Quitamos denominadores con $\text{m.c.m.} = 2x(x - 3)$: $2x + 2(x - 3) = x(x - 3) \implies x^2 - 7x + 6 = 0$</p><p>3. Soluciones: $x = 6$ ($x = 1$ se descarta porque $1 - 3 < 0$). El 1º tarda $3\text{ h}$ y el 2º tarda $6\text{ h}$.</p><span class="res-badge">Solución: $3\text{ h}$ y $6\text{ h}$</span>')
)

Write-TopicHtmlFiles "ecuaciones-3-4-eso" "Ecuaciones" "Matemáticas 3º y 4º ESO" $formEcuaciones $exEcuaciones

# ==============================================================================
# TEMA 2: SISTEMAS DE ECUACIONES (4º ESO y 1º Bachillerato) -> slug: sistemas-ecuaciones
# ==============================================================================
$formSistemas = @'
  <div class="section-card">
    <h2 class="section-title"><span class="num-circle">1</span><span>Los 3 Métodos para Resolver Sistemas Lineales ($x, y$)</span></h2>
    <div class="three-cols">
      <div class="step-box">
        <span class="step-header">1. Sustitución</span>
        <div><strong>¿Cuándo elegirlo?</strong> Cuando una incógnita tenga coeficiente $1$ o $-1$.</div>
        <div class="example-pill"><strong>1.</strong> Despeja esa letra en una ecuación.<br><strong>2.</strong> Sustitúyela entre paréntesis en la otra.<br><strong>3.</strong> Resuelve y calcula la primera letra.</div>
      </div>
      <div class="step-box">
        <span class="step-header">2. Igualación</span>
        <div><strong>¿Cuándo elegirlo?</strong> Cuando sea fácil despejar la misma letra en las dos ecuaciones.</div>
        <div class="example-pill"><strong>1.</strong> Despeja la misma letra (ej. $y$) en ambas.<br><strong>2.</strong> Iguala las dos expresiones: $y = y$.<br><strong>3.</strong> Multiplica en cruz si hay fracciones.</div>
      </div>
      <div class="step-box">
        <span class="step-header">3. Reducción (¡El más rápido!)</span>
        <div><strong>¿Cuándo elegirlo?</strong> Siempre que todas las letras tengan números delante.</div>
        <div class="example-pill"><strong>1.</strong> Multiplica las ecuaciones para que una letra quede con el <strong>mismo número y distinto signo</strong>.<br><strong>2.</strong> Suma en vertical para eliminarla.</div>
      </div>
    </div>
  </div>

  <div class="section-card">
    <h2 class="section-title"><span class="num-circle">2</span><span>Cómo Limpiar el Sistema Antes de Empezar y Clasificación</span></h2>
    <div class="steps-grid">
      <div class="step-box">
        <span class="step-header">🧹 Si hay Paréntesis o Denominadores</span>
        <div><strong>¡Nunca apliques los métodos sin ordenar antes!</strong> En cada ecuación por separado:<br><strong>1.</strong> Quita paréntesis.<br><strong>2.</strong> Quita denominadores con el <strong>m.c.m.</strong><br><strong>3.</strong> Déjalo ordenado: $\begin{cases} ax + by = c \\ a'x + b'y = c' \end{cases}$</div>
      </div>
      <div class="step-box">
        <span class="step-header">📊 Tipos de Sistemas según sus Soluciones</span>
        <div>&bull; <strong>S.C.D. (Compatible Determinado):</strong> <strong>1 solución única</strong> $(x, y)$. Rectas que se cortan ($\dfrac{a}{a'} \neq \dfrac{b}{b'}$).<br>&bull; <strong>S.C.I. (Compatible Indeterminado):</strong> Sale $0 = 0$. <strong>Infinitas soluciones</strong> ($\dfrac{a}{a'} = \dfrac{b}{b'} = \dfrac{c}{c'}$).<br>&bull; <strong>S.I. (Incompatible):</strong> Sale $0 = k \neq 0$. <strong>Sin solución</strong> ($\dfrac{a}{a'} = \dfrac{b}{b'} \neq \dfrac{c}{c'}$).</div>
      </div>
    </div>
  </div>

  <div class="section-card" style="margin-bottom: 0;">
    <h2 class="section-title"><span class="num-circle">3</span><span>Chuleta para Plantear Problemas de Sistemas en Exámenes</span></h2>
    <div class="steps-grid">
      <div class="step-box">
        <span class="step-header">🧪 Problemas de Mezclas y Precios</span>
        <div>Si mezclamos $x\text{ kg}$ de precio $p_1$ con $y\text{ kg}$ de precio $p_2$:</div>
        <div class="example-pill">$$\begin{cases} x + y = \text{Peso total} \\ p_1 \cdot x + p_2 \cdot y = \text{Coste total} \end{cases}$$</div>
      </div>
      <div class="step-box">
        <span class="step-header">🔢 Problemas de Cifras y Descuentos</span>
        <div>&bull; Un número de dos cifras $xy$ vale $\mathbf{10x + y}$ (y al invertir sus cifras vale $\mathbf{10y + x}$).<br>&bull; Subir un $10\%$ es multiplicar por $1{,}10$; rebajar un $20\%$ es multiplicar por $0{,}80$.</div>
      </div>
    </div>
  </div>
'@

$exSistemas = @(
  @('Resuelve por el método de sustitución: $\begin{cases} x + 2y = 7 \\ 3x - y = 7 \end{cases}$', '$x = 3, \ y = 2$', '<p>1. Despejamos $x$ en la 1ª ecuación: $x = 7 - 2y$</p><p>2. Sustituimos en la 2ª: $3(7 - 2y) - y = 7 \implies 21 - 6y - y = 7 \implies 7y = 14 \implies y = 2$</p><p>3. Calculamos $x$: $x = 7 - 2(2) = 3$</p><span class="res-badge">Solución: $x = 3, \ y = 2$</span>'),
  @('Resuelve por el método de reducción: $\begin{cases} 2x + 3y = 12 \\ 5x - 3y = 9 \end{cases}$', '$x = 3, \ y = 2$', '<p>1. Sumamos directamente ambas ecuaciones porque la $y$ ya tiene coeficientes opuestos ($+3y$ y $-3y$):</p><p>$$7x = 21 \implies x = 3$$</p><p>2. Sustituimos $x = 3$ en la 1ª ecuación: $2(3) + 3y = 12 \implies 3y = 6 \implies y = 2$</p><span class="res-badge">Solución: $x = 3, \ y = 2$</span>'),
  @('Resuelve por el método de igualación: $\begin{cases} x + y = 5 \\ 2x - y = 4 \end{cases}$', '$x = 3, \ y = 2$', '<p>1. Despejamos $y$ en ambas ecuaciones: $y = 5 - x$ e $y = 2x - 4$</p><p>2. Igualamos: $5 - x = 2x - 4 \implies 3x = 9 \implies x = 3$</p><p>3. Sustituimos en la primera: $y = 5 - 3 = 2$</p><span class="res-badge">Solución: $x = 3, \ y = 2$</span>'),
  @('Resuelve por reducción doble: $\begin{cases} 3x + 2y = 7 \\ 4x - 3y = -2 \end{cases}$', '$x = 1, \ y = 2$', '<p>1. Multiplicamos la 1ª ecuación por $3$ y la 2ª por $2$: $\begin{cases} 9x + 6y = 21 \\ 8x - 6y = -4 \end{cases}$</p><p>2. Sumamos: $17x = 17 \implies x = 1$</p><p>3. Sustituimos en la 1ª: $3(1) + 2y = 7 \implies 2y = 4 \implies y = 2$</p><span class="res-badge">Solución: $x = 1, \ y = 2$</span>'),
  @('Resuelve el sistema quitando antes los paréntesis: $\begin{cases} 2(x + 1) - y = 3 \\ 3x + 2(y - 1) = 10 \end{cases}$', '$x = 2, \ y = 3$', '<p>1. Quitamos paréntesis y ordenamos: $\begin{cases} 2x - y = 1 \\ 3x + 2y = 12 \end{cases}$</p><p>2. Multiplicamos la 1ª por $2$ y sumamos con la 2ª: $4x + 3x = 2 + 12 \implies 7x = 14 \implies x = 2$</p><p>3. Sustituimos en la 1ª: $2(2) - y = 1 \implies y = 3$.</p><span class="res-badge">Solución: $x = 2, \ y = 3$</span>'),
  @('Resuelve el sistema con denominadores: $\begin{cases} \dfrac{x}{2} + \dfrac{y}{3} = 4 \\ x - y = 3 \end{cases}$', '$x = 6, \ y = 3$', '<p>1. Multiplicamos la 1ª ecuación por $\text{m.c.m.}(2, 3) = 6$: $\begin{cases} 3x + 2y = 24 \\ x - y = 3 \end{cases}$</p><p>2. Multiplicamos la 2ª por $2$ y sumamos: $5x = 30 \implies x = 6$</p><p>3. De $x - y = 3 \implies 6 - y = 3 \implies y = 3$</p><span class="res-badge">Solución: $x = 6, \ y = 3$</span>'),
  @('Clasifica y resuelve, si es posible, el sistema: $\begin{cases} 2x - y = 4 \\ 4x - 2y = 5 \end{cases}$', 'Sistema Incompatible (S.I., sin solución)', '<p>1. Multiplicamos la 1ª ecuación por $-2$: $-4x + 2y = -8$</p><p>2. Sumamos con la 2ª ecuación: $0x + 0y = -3 \implies 0 = -3$ (Contradicción).</p><p>3. Es un <strong>Sistema Incompatible (S.I.)</strong>: representa dos rectas paralelas y no tiene solución.</p><span class="res-badge">Solución: Sistema Incompatible (Sin solución)</span>'),
  @('Clasifica y resuelve el sistema: $\begin{cases} x - 3y = 2 \\ 2x - 6y = 4 \end{cases}$', 'S.C.I. ($x = 2 + 3\lambda, \ y = \lambda$)', '<p>1. Multiplicamos la 1ª ecuación por $-2$ y sumamos: $0 = 0$.</p><p>2. Como ambas ecuaciones son proporcionales, es un <strong>Sistema Compatible Indeterminado (S.C.I.)</strong> con infinitas soluciones: $y = \lambda, \ x = 2 + 3\lambda \ (\lambda \in \mathbb{R})$.</p><span class="res-badge">Solución: S.C.I. ($x = 2 + 3\lambda, \ y = \lambda$)</span>'),
  @('Resuelve el sistema con fracciones y paréntesis: $\begin{cases} \dfrac{x + 1}{3} + \dfrac{y - 1}{2} = 3 \\ \dfrac{2x - y}{3} = 1 \end{cases}$', '$x = 7/2, \ y = 4$', '<p>1. Quitamos denominadores: en la 1ª ($\text{m.c.m.}=6$): $2(x+1)+3(y-1)=18 \implies 2x + 3y = 19$. En la 2ª: $2x - y = 3$.</p><p>2. Restamos ambas ecuaciones: $4y = 16 \implies y = 4$. Entonces $2x = 3 + 4 = 7 \implies x = 7/2$.</p><span class="res-badge">Solución: $x = \dfrac{7}{2}, \ y = 4$</span>'),
  @('Resuelve el sistema lineal: $\begin{cases} \dfrac{x + y}{2} - \dfrac{x - y}{3} = 3 \\ \dfrac{x}{2} + y = 5 \end{cases}$', '$x = 14/3, \ y = 8/3$', '<p>1. En la 1ª ($\text{m.c.m.}=6$): $3(x+y) - 2(x-y) = 18 \implies x + 5y = 18$. En la 2ª ($\text{m.c.m.}=2$): $x + 2y = 10$.</p><p>2. Restamos la 1ª menos la 2ª: $3y = 8 \implies y = 8/3, \ x = 14/3$.</p><span class="res-badge">Solución: $x = \dfrac{14}{3}, \ y = \dfrac{8}{3}$</span>'),
  @('Determina el valor del parámetro $k$ para que el sistema sea incompatible: $\begin{cases} 3x + ky = 5 \\ 6x - 4y = 7 \end{cases}$', '$k = -2$', '<p>1. Un sistema lineal de 2 incógnitas es incompatible cuando los coeficientes son proporcionales pero los términos independientes no:</p><p>$$\frac{3}{6} = \frac{k}{-4} \neq \frac{5}{7} \implies 6k = -12 \implies k = -2$$</p><span class="res-badge">Solución: $k = -2$</span>'),
  @('Halla el valor de $m$ para que el sistema tenga infinitas soluciones (S.C.I.): $\begin{cases} 2x - 3y = 5 \\ 4x + my = 10 \end{cases}$', '$m = -6$', '<p>1. Para que sea Compatible Indeterminado debe cumplirse la triple proporción:</p><p>$$\frac{2}{4} = \frac{-3}{m} = \frac{5}{10} \implies \frac{1}{2} = \frac{-3}{m} \implies m = -6$$</p><span class="res-badge">Solución: $m = -6$</span>'),
  @('En un test de 30 preguntas se obtienen $0{,}75$ puntos por cada respuesta correcta y se restan $0{,}25$ puntos por cada error. Si un alumno contestó a todas y obtuvo $10{,}5$ puntos, ¿cuántos aciertos y fallos tuvo?', '$18$ aciertos y $12$ fallos', '<p>1. Llamamos $x$ a los aciertos e $y$ a los fallos: $\begin{cases} x + y = 30 \\ 0{,}75x - 0{,}25y = 10{,}5 \end{cases}$</p><p>2. Multiplicamos la 2ª ecuación por $4$: $3x - y = 42$.</p><p>3. Sumamos con la 1ª ($x + y = 30$): $4x = 72 \implies x = 18$ aciertos e $y = 30 - 18 = 12$ fallos.</p><span class="res-badge">Solución: $18$ aciertos y $12$ fallos</span>'),
  @('Un comerciante mezcla café de Colombia a $12\text{ €/kg}$ con café de Brasil a $8\text{ €/kg}$ para obtener $40\text{ kg}$ de mezcla a $9{,}50\text{ €/kg}$. ¿Cuántos kilos de cada tipo ha utilizado?', '$15\text{ kg}$ de Colombia y $25\text{ kg}$ de Brasil', '<p>1. Planteamos el sistema: $\begin{cases} x + y = 40 \\ 12x + 8y = 40 \cdot 9{,}50 = 380 \end{cases}$</p><p>2. Multiplicamos la 1ª por $-8$ y sumamos: $4x = 380 - 320 = 60 \implies x = 15\text{ kg}$ y $y = 40 - 15 = 25\text{ kg}$.</p><span class="res-badge">Solución: $15\text{ kg}$ y $25\text{ kg}$</span>'),
  @('Hace $5$ años la edad de un padre era el triple que la de su hijo, y dentro de $10$ años será el doble. Calcula las edades actuales de ambos.', 'Padre $50$ años, Hijo $20$ años', '<p>1. Llamamos $x$ a la edad actual del padre e $y$ a la del hijo: $\begin{cases} x - 5 = 3(y - 5) \\ x + 10 = 2(y + 10) \end{cases} \implies \begin{cases} x - 3y = -10 \\ x - 2y = 10 \end{cases}$</p><p>2. Restamos la 2ª menos la 1ª: $y = 20$ años. Sustituyendo: $x = 10 + 2(20) = 50$ años.</p><span class="res-badge">Solución: Padre $50$ años, Hijo $20$ años</span>'),
  @('El perímetro de un rectángulo es de $28\text{ cm}$. Si la base disminuye en $2\text{ cm}$ y la altura aumenta en $1\text{ cm}$, el área no varía. Calcula las dimensiones del rectángulo.', 'Base $= 10\text{ cm}$, Altura $= 4\text{ cm}$', '<p>1. Sistema con base $x$ y altura $y$: $\begin{cases} 2x + 2y = 28 \implies x + y = 14 \\ (x - 2)(y + 1) = x \cdot y \end{cases}$</p><p>2. Desarrollamos la 2ª ecuación: $xy + x - 2y - 2 = xy \implies x - 2y = 2$</p><p>3. Restamos $(x + y = 14) - (x - 2y = 2) \implies 3y = 12 \implies y = 4\text{ cm}, \ x = 10\text{ cm}$.</p><span class="res-badge">Solución: Base $10\text{ cm}$ y Altura $4\text{ cm}$</span>'),
  @('La suma de las dos cifras de un número es $11$. Si invertimos el orden de sus cifras, el número resultante supera al original en $27$ unidades. ¿De qué número se trata?', 'El número es $47$', '<p>1. Sea $x$ la cifra de las decenas e $y$ la de las unidades. El número vale $10x + y$: $\begin{cases} x + y = 11 \\ (10y + x) - (10x + y) = 27 \end{cases}$</p><p>2. Simplificamos la 2ª: $9y - 9x = 27 \implies -x + y = 3$.</p><p>3. Sumamos con $x + y = 11$: $2y = 14 \implies y = 7, \ x = 4$. El número es el $47$.</p><span class="res-badge">Solución: $47$</span>'),
  @('Por unos pantalones y unas zapatillas que costaban juntos $110\text{ €}$ hemos pagado $90\text{ €}$ gracias a que los pantalones tenían un $20\%$ de descuento y las zapatillas un $15\%$ de descuento. ¿Cuál era el precio inicial de cada artículo?', 'Pantalones $70\text{ €}$, Zapatillas $40\text{ €}$', '<p>1. Con descuentos del $20\%$ y $15\%$ pagamos el $80\%$ ($0{,}80x$) y el $85\%$ ($0{,}85y$): $\begin{cases} x + y = 110 \\ 0{,}80x + 0{,}85y = 90 \end{cases}$</p><p>2. Multiplicamos la 1ª por $-0{,}80$ y sumamos: $0{,}05y = 90 - 88 = 2 \implies y = 40\text{ €}, \ x = 70\text{ €}$.</p><span class="res-badge">Solución: Pantalones $70\text{ €}$, Zapatillas $40\text{ €}$</span>'),
  @('Resuelve el sistema mediante el cambio de variable $u = \dfrac{1}{x}, \ v = \dfrac{1}{y}$: $\begin{cases} \dfrac{2}{x} + \dfrac{3}{y} = 2 \\ \dfrac{4}{x} - \dfrac{9}{y} = -1 \end{cases}$', '$x = 2, \ y = 3$', '<p>1. Con $u = 1/x$ y $v = 1/y$: $\begin{cases} 2u + 3v = 2 \\ 4u - 9v = -1 \end{cases}$</p><p>2. Multiplicamos la 1ª por $3$ y sumamos: $10u = 5 \implies u = \dfrac{1}{2} \implies x = 2$</p><p>3. Sustituimos: $2(1/2) + 3v = 2 \implies 3v = 1 \implies v = \dfrac{1}{3} \implies y = 3$</p><span class="res-badge">Solución: $x = 2, \ y = 3$</span>'),
  @('Discute el sistema según los valores del parámetro $a$: $\begin{cases} ax + 2y = 4 \\ 2x + ay = 4 \end{cases}$', 'Si $a \neq \pm 2$: S.C.D.; Si $a = 2$: S.C.I.; Si $a = -2$: S.I.', '<p>1. Igualamos proporciones de coeficientes: $\dfrac{a}{2} = \dfrac{2}{a} \implies a^2 = 4 \implies a = 2$ o $a = -2$.</p><p>&bull; Si $a \neq 2$ y $a \neq -2$: <strong>S.C.D.</strong> (solución única).</p><p>&bull; Si $a = 2$: $\dfrac{2}{2} = \dfrac{2}{2} = \dfrac{4}{4} \implies$ <strong>S.C.I.</strong> (infinitas soluciones).</p><p>&bull; Si $a = -2$: $\dfrac{-2}{2} = \dfrac{2}{-2} \neq \dfrac{4}{4} \implies$ <strong>S.I.</strong> (sin solución).</p><span class="res-badge">Solución: $a \neq \pm 2$ S.C.D. | $a = 2$ S.C.I. | $a = -2$ S.I.</span>'),
  @('Dos coches salen a la vez de dos ciudades $A$ y $B$ distantes $300\text{ km}$. Si van uno al encuentro del otro, se cruzan a las $2\text{ horas}$. Si van en el mismo sentido, el más rápido alcanza al otro en $6\text{ horas}$. Calcula sus velocidades.', '$100\text{ km/h}$ y $50\text{ km/h}$', '<p>1. Cuando van al encuentro, sus velocidades se suman; en el mismo sentido, se restan: $\begin{cases} 2(v_1 + v_2) = 300 \\ 6(v_1 - v_2) = 300 \end{cases} \implies \begin{cases} v_1 + v_2 = 150 \\ v_1 - v_2 = 50 \end{cases}$</p><p>2. Sumamos ambas ecuaciones: $2v_1 = 200 \implies v_1 = 100\text{ km/h}$ y $v_2 = 50\text{ km/h}$.</p><span class="res-badge">Solución: $v_1 = 100\text{ km/h}, \ v_2 = 50\text{ km/h}$</span>'),
  @('Un joyero tiene dos lingotes de oro: el primero con un $80\%$ de pureza y el segundo con un $50\%$ de pureza. ¿Cuántos gramos debe fundir de cada uno para obtener un lingote de $120\text{ g}$ con un $70\%$ de pureza?', '$80\text{ g}$ del 1º y $40\text{ g}$ del 2º', '<p>1. Planteamos el sistema de masa total y masa de oro puro: $\begin{cases} x + y = 120 \\ 0{,}80x + 0{,}50y = 0{,}70 \cdot 120 = 84 \end{cases}$</p><p>2. Multiplicamos la 2ª por $10$: $8x + 5y = 840$. Multiplicamos la 1ª por $-5$: $-5x - 5y = -600$.</p><p>3. Sumamos: $3x = 240 \implies x = 80\text{ g}$ y $y = 120 - 80 = 40\text{ g}$.</p><span class="res-badge">Solución: $80\text{ g}$ y $40\text{ g}$</span>')
)

Write-TopicHtmlFiles "sistemas-ecuaciones" "Sistemas de Ecuaciones" "Matemáticas 4º ESO y 1º Bachillerato" $formSistemas $exSistemas

# ==============================================================================
# TEMA 3: SISTEMAS DE ECUACIONES NO LINEALES (1º Bachillerato) -> slug: sistemas-no-lineales-1-bach
# ==============================================================================
$formNoLineales = @'
  <div class="section-card">
    <h2 class="section-title"><span class="num-circle">1</span><span>La Regla de Oro de los Sistemas No Lineales</span></h2>
    <div class="steps-grid">
      <div class="step-box">
        <span class="step-header">⭐ Caso 1: Una ecuación lineal y otra de 2º grado</span>
        <div>Es el caso más frecuente de examen. <strong>Se hace SIEMPRE por Sustitución:</strong></div>
        <div><strong>1.</strong> Despeja una letra en la ecuación <strong>lineal</strong> (la que no tiene cuadrados ni productos).<br><strong>2.</strong> Sustitúyela <strong>entre paréntesis</strong> en la ecuación no lineal.<br><strong>3.</strong> Desarrolla los productos notables $(a\pm b)^2 = a^2 \pm 2ab + b^2$ y resuelve.<br><strong>4.</strong> Calcula la pareja $y$ para <strong>cada</strong> valor de $x$.</div>
      </div>
      <div class="step-box">
        <span class="step-header">⚡ Caso 2:Las dos ecuaciones tienen $x^2$ e $y^2$</span>
        <div>Si ambas ecuaciones solo tienen términos con $x^2$ e $y^2$, <strong>aplica Reducción directamente:</strong></div>
        <div class="example-pill">$$\begin{cases} x^2 + y^2 = 25 \\ x^2 - y^2 = 7 \end{cases} \xrightarrow{\text{Sumamos}} 2x^2 = 32 \rightarrow x = \pm 4$$<br>Para cada $x$, sustituye para hallar $y = \pm 3$ (¡salen 4 puntos de corte!).</div>
      </div>
    </div>
  </div>

  <div class="section-card" style="margin-bottom: 0;">
    <h2 class="section-title"><span class="num-circle">2</span><span>Sistemas con Raíces, Exponenciales y Logaritmos</span></h2>
    <div class="three-cols">
      <div class="step-box">
        <span class="step-header">√ Sistemas con Raíces</span>
        <div>Si aparece $\sqrt{x}$ o $\sqrt{y}$, despeja la raíz o haz el cambio $u = \sqrt{x}, \ v = \sqrt{y}$.</div>
        <div class="example-pill"><strong>¡Recuerda!</strong> Al elevar al cuadrado es obligatorio comprobar las parejas $(x,y)$ al final.</div>
      </div>
      <div class="step-box">
        <span class="step-header">🚀 Sistemas Exponenciales</span>
        <div>&bull; <strong>Por cambio de variable:</strong> Llama $u = a^x$ y $v = b^y$.<br>&bull; <strong>Igualando bases:</strong> Usa $a^x \cdot a^y = a^{x+y}$ y $\dfrac{a^x}{a^y} = a^{x-y}$.</div>
        <div class="example-pill">Si $u = 2^x = 8 \rightarrow 2^x = 2^3 \rightarrow \mathbf{x = 3}$.</div>
      </div>
      <div class="step-box">
        <span class="step-header">📐 Sistemas Logarítmicos</span>
        <div>Usa las propiedades para quitar los logaritmos:</div>
        <div class="example-pill">&bull; $\log x + \log y = \log(x \cdot y)$<br>&bull; $\log x - \log y = \log(x / y)$<br><strong>¡Ojo!</strong> Solo valen soluciones con $x > 0$ e $y > 0$.</div>
      </div>
    </div>
  </div>
'@

$exNoLineales = @(
  @('Resuelve el sistema no lineal: $\begin{cases} x + y = 7 \\ x \cdot y = 12 \end{cases}$', '$(4, 3)$ y $(3, 4)$', '<p>1. Despejamos $y = 7 - x$ en la 1ª ecuación y sustituimos en la 2ª:</p><p>$$x(7 - x) = 12 \implies x^2 - 7x + 12 = 0$$</p><p>2. Resolvemos la ecuación de 2º grado: $x_1 = 4 \implies y_1 = 3$; y $x_2 = 3 \implies y_2 = 4$.</p><span class="res-badge">Solución: $(4, 3)$ y $(3, 4)$</span>'),
  @('Resuelve el sistema (intersección de recta y parábola): $\begin{cases} y = x^2 - 2x \\ y = x + 4 \end{cases}$', '$(4, 8)$ y $(-1, 3)$', '<p>1. Igualamos ambas expresiones de $y$: $x^2 - 2x = x + 4 \implies x^2 - 3x - 4 = 0$</p><p>2. Fórmula de 2º grado: $x_1 = 4 \implies y_1 = 4 + 4 = 8$; y $x_2 = -1 \implies y_2 = -1 + 4 = 3$.</p><span class="res-badge">Solución: $(4, 8)$ y $(-1, 3)$</span>'),
  @('Resuelve el sistema: $\begin{cases} x - y = 1 \\ x^2 + y^2 = 13 \end{cases}$', '$(3, 2)$ y $(-2, -3)$', '<p>1. De la 1ª ecuación: $x = y + 1$. Sustituimos en la 2ª:</p><p>$$(y + 1)^2 + y^2 = 13 \implies y^2 + 2y + 1 + y^2 = 13 \implies 2y^2 + 2y - 12 = 0 \implies y^2 + y - 6 = 0$$</p><p>2. Obtenemos $y_1 = 2 \implies x_1 = 3$; e $y_2 = -3 \implies x_2 = -2$.</p><span class="res-badge">Solución: $(3, 2)$ y $(-2, -3)$</span>'),
  @('Resuelve por reducción el sistema cuadrático: $\begin{cases} x^2 + y^2 = 25 \\ x^2 - y^2 = 7 \end{cases}$', '$(4, 3), (4, -3), (-4, 3), (-4, -3)$', '<p>1. Sumamos ambas ecuaciones: $2x^2 = 32 \implies x^2 = 16 \implies x = \pm 4$</p><p>2. Sustituimos $x^2 = 16$ en la 1ª: $16 + y^2 = 25 \implies y^2 = 9 \implies y = \pm 3$.</p><p>3. Combinando signos obtenemos las 4 soluciones.</p><span class="res-badge">Solución: $(4, 3), \ (4, -3), \ (-4, 3), \ (-4, -3)$</span>'),
  @('Resuelve el sistema: $\begin{cases} 2x + y = 5 \\ x^2 - y = 3 \end{cases}$', '$(2, 1)$ y $(-4, 13)$', '<p>1. Sumamos ambas ecuaciones para eliminar $y$: $x^2 + 2x = 8 \implies x^2 + 2x - 8 = 0$</p><p>2. Resolvemos: $x_1 = 2 \implies y_1 = 5 - 2(2) = 1$; y $x_2 = -4 \implies y_2 = 5 - 2(-4) = 13$.</p><span class="res-badge">Solución: $(2, 1)$ y $(-4, 13)$</span>'),
  @('Resuelve el sistema: $\begin{cases} x^2 - y^2 = 5 \\ x - y = 1 \end{cases}$', '$(3, 2)$', '<p>1. Despejamos $x = y + 1$ y sustituimos en la 1ª (o usamos $x^2 - y^2 = (x-y)(x+y) = 5$):</p><p>$$(y + 1)^2 - y^2 = 5 \implies 2y + 1 = 5 \implies 2y = 4 \implies y = 2 \implies x = 3$$</p><span class="res-badge">Solución: $(3, 2)$</span>'),
  @('Resuelve el sistema con raíz cuadrada: $\begin{cases} \sqrt{x} + y = 5 \\ x + y = 7 \end{cases}$', '$(4, 3)$', '<p>1. Restamos la 2ª ecuación menos la 1ª: $x - \sqrt{x} = 2$. Con $t = \sqrt{x} \ge 0$: $t^2 - t - 2 = 0 \implies t = 2$ ($t = -1$ no vale).</p><p>2. Como $\sqrt{x} = 2 \implies x = 4$, y sustituyendo: $y = 7 - 4 = 3$.</p><span class="res-badge">Solución: $(4, 3)$</span>'),
  @('Resuelve el sistema: $\begin{cases} x \cdot y = 6 \\ 2x + 3y = 13 \end{cases}$', '$(2, 3)$ y $(9/2, 4/3)$', '<p>1. De la 1ª: $y = \dfrac{6}{x}$. Sustituimos en la 2ª: $2x + \dfrac{18}{x} = 13 \implies 2x^2 - 13x + 18 = 0$</p><p>2. Resolvemos: $x = \dfrac{13 \pm \sqrt{169 - 144}}{4} = \dfrac{13 \pm 5}{4} \implies x_1 = \dfrac{9}{2} \ (y_1 = \dfrac{4}{3})$ y $x_2 = 2 \ (y_2 = 3)$.</p><span class="res-badge">Solución: $(2, 3)$ y $\left(\dfrac{9}{2}, \dfrac{4}{3}\right)$</span>'),
  @('Resuelve el sistema no lineal: $\begin{cases} x^2 + xy + y^2 = 7 \\ x + y = 3 \end{cases}$', '$(2, 1)$ y $(1, 2)$', '<p>1. De la 2ª: $y = 3 - x$. Sustituimos en la 1ª:</p><p>$$x^2 + x(3 - x) + (3 - x)^2 = 7 \implies x^2 + 3x - x^2 + 9 - 6x + x^2 = 7 \implies x^2 - 3x + 2 = 0$$</p><p>2. Soluciones: $x_1 = 2 \implies y_1 = 1$; y $x_2 = 1 \implies y_2 = 2$.</p><span class="res-badge">Solución: $(2, 1)$ y $(1, 2)$</span>'),
  @('Resuelve por reducción el sistema: $\begin{cases} 2x^2 - 3y^2 = 5 \\ x^2 + 2y^2 = 6 \end{cases}$', '$(\pm 2, \pm 1)$ (4 soluciones)', '<p>1. Multiplicamos la 2ª por $-2$ y sumamos: $-7y^2 = -7 \implies y^2 = 1 \implies y = \pm 1$</p><p>2. Sustituimos $y^2 = 1$ en la 2ª: $x^2 + 2 = 6 \implies x^2 = 4 \implies x = \pm 2$.</p><span class="res-badge">Solución: $(2, 1), \ (2, -1), \ (-2, 1), \ (-2, -1)$</span>'),
  @('Resuelve el sistema racional: $\begin{cases} \dfrac{1}{x} + \dfrac{1}{y} = \dfrac{5}{6} \\ x + y = 5 \end{cases}$', '$(2, 3)$ y $(3, 2)$', '<p>1. En la 1ª ecuación hacemos denominador común: $\dfrac{y + x}{x \cdot y} = \dfrac{5}{6}$</p><p>2. Como $x + y = 5$, sustituimos arriba: $\dfrac{5}{x \cdot y} = \dfrac{5}{6} \implies x \cdot y = 6$.</p><p>3. Del sistema $\begin{cases} x + y = 5 \\ x \cdot y = 6 \end{cases}$ obtenemos $(2, 3)$ y $(3, 2)$.</p><span class="res-badge">Solución: $(2, 3)$ y $(3, 2)$</span>'),
  @('Resuelve el sistema irracional: $\begin{cases} \sqrt{x + y} = 3 \\ x - y = 1 \end{cases}$', '$(5, 4)$', '<p>1. Elevamos la 1ª ecuación al cuadrado: $x + y = 9$</p><p>2. Sumamos con la 2ª ($x - y = 1$): $2x = 10 \implies x = 5 \implies y = 4$. Comprobación: $\sqrt{5+4} = 3$ (Válida).</p><span class="res-badge">Solución: $(5, 4)$</span>'),
  @('Resuelve el sistema con dos raíces: $\begin{cases} \sqrt{x} + \sqrt{y} = 5 \\ \sqrt{x} - \sqrt{y} = 1 \end{cases}$', '$(9, 4)$', '<p>1. Sumamos ambas ecuaciones: $2\sqrt{x} = 6 \implies \sqrt{x} = 3 \implies x = 9$</p><p>2. Sustituimos en la 1ª: $3 + \sqrt{y} = 5 \implies \sqrt{y} = 2 \implies y = 4$.</p><span class="res-badge">Solución: $(9, 4)$</span>'),
  @('Resuelve el sistema exponencial: $\begin{cases} 2^x + 3^y = 7 \\ 2^x - 3^y = 1 \end{cases}$', '$x = 2, \ y = 1$', '<p>1. Sumamos ambas ecuaciones: $2 \cdot 2^x = 8 \implies 2^x = 4 = 2^2 \implies x = 2$</p><p>2. Sustituimos en la 1ª: $4 + 3^y = 7 \implies 3^y = 3^1 \implies y = 1$.</p><span class="res-badge">Solución: $x = 2, \ y = 1$</span>'),
  @('Resuelve el sistema exponencial reduciendo a la misma base: $\begin{cases} 2^x \cdot 2^y = 32 \\ \dfrac{3^{2x}}{3^y} = 27 \end{cases}$', '$x = 8/3, \ y = 7/3$', '<p>1. Aplicamos propiedades de las potencias: $\begin{cases} 2^{x+y} = 2^5 \\ 3^{2x-y} = 3^3 \end{cases} \implies \begin{cases} x + y = 5 \\ 2x - y = 3 \end{cases}$</p><p>2. Sumamos: $3x = 8 \implies x = \dfrac{8}{3}$ e $y = 5 - \dfrac{8}{3} = \dfrac{7}{3}$.</p><span class="res-badge">Solución: $x = \dfrac{8}{3}, \ y = \dfrac{7}{3}$</span>'),
  @('Resuelve el sistema logarítmico (base 10): $\begin{cases} \log x + \log y = 2 \\ x - y = 15 \end{cases}$', '$x = 20, \ y = 5$', '<p>1. En la 1ª ecuación aplicamos el logaritmo de un producto: $\log(x \cdot y) = 2 \implies x \cdot y = 10^2 = 100$</p><p>2. De la 2ª: $x = y + 15 \implies (y + 15)y = 100 \implies y^2 + 15y - 100 = 0 \implies y_1 = 5, \ y_2 = -20$ (se descarta porque $y > 0$).</p><p>3. Para $y = 5 \implies x = 20$.</p><span class="res-badge">Solución: $x = 20, \ y = 5$</span>'),
  @('Resuelve el sistema logarítmico: $\begin{cases} \log x + \log y = 3 \\ \log x - \log y = 1 \end{cases}$', '$x = 100, \ y = 10$', '<p>1. Sumamos ambas ecuaciones: $2\log x = 4 \implies \log x = 2 \implies x = 10^2 = 100$</p><p>2. Sustituimos en la 1ª: $2 + \log y = 3 \implies \log y = 1 \implies y = 10^1 = 10$.</p><span class="res-badge">Solución: $x = 100, \ y = 10$</span>'),
  @('Resuelve el sistema logarítmico: $\begin{cases} \log_2 x + \log_2 y = 5 \\ x + y = 12 \end{cases}$', '$(8, 4)$ y $(4, 8)$', '<p>1. De la 1ª ecuación: $\log_2(x \cdot y) = 5 \implies x \cdot y = 2^5 = 32$</p><p>2. Sustituimos $y = 12 - x$: $x(12 - x) = 32 \implies x^2 - 12x + 32 = 0 \implies x_1 = 8 \ (y_1 = 4)$ y $x_2 = 4 \ (y_2 = 8)$.</p><span class="res-badge">Solución: $(8, 4)$ y $(4, 8)$</span>'),
  @('Resuelve el sistema exponencial con cambio de variable: $\begin{cases} 2^{x+1} + 5^y = 9 \\ 2^x + 5^{y+1} = 27 \end{cases}$', '$x = 1, \ y = 1$', '<p>1. Llamamos $u = 2^x$ y $v = 5^y$: $\begin{cases} 2u + v = 9 \\ u + 5v = 27 \end{cases}$</p><p>2. Multiplicamos la 2ª por $-2$ y sumamos: $-9v = -45 \implies v = 5 \implies 5^y = 5^1 \implies y = 1$</p><p>3. Sustituimos $v = 5$: $2u + 5 = 9 \implies u = 2 \implies 2^x = 2^1 \implies x = 1$.</p><span class="res-badge">Solución: $x = 1, \ y = 1$</span>'),
  @('La diagonal de un rectángulo mide $10\text{ cm}$ y su perímetro es de $28\text{ cm}$. Calcula las longitudes de sus lados.', '$8\text{ cm}$ y $6\text{ cm}$', '<p>1. Por el teorema de Pitágoras y el perímetro: $\begin{cases} x^2 + y^2 = 10^2 = 100 \\ 2x + 2y = 28 \implies x + y = 14 \end{cases}$</p><p>2. Sustituimos $y = 14 - x$: $x^2 + (14 - x)^2 = 100 \implies 2x^2 - 28x + 96 = 0 \implies x^2 - 14x + 48 = 0$</p><p>3. Soluciones: $x_1 = 8\text{ cm}, \ y_1 = 6\text{ cm}$.</p><span class="res-badge">Solución: $8\text{ cm}$ y $6\text{ cm}$</span>'),
  @('El área de un triángulo rectángulo es de $30\text{ cm}^2$ y su hipotenusa mide $13\text{ cm}$. Calcula la longitud de sus dos catetos.', '$12\text{ cm}$ y $5\text{ cm}$', '<p>1. Llamamos $x$ e $y$ a los catetos: $\begin{cases} \dfrac{x \cdot y}{2} = 30 \implies x \cdot y = 60 \\ x^2 + y^2 = 13^2 = 169 \end{cases}$</p><p>2. Sustituimos $y = \dfrac{60}{x}$ en la 2ª: $x^2 + \dfrac{3600}{x^2} = 169 \implies x^4 - 169x^2 + 3600 = 0$</p><p>3. Ecuación bicuadrada ($t = x^2$): $t_1 = 144 \implies x = 12\text{ cm}$ y $t_2 = 25 \implies y = 5\text{ cm}$.</p><span class="res-badge">Solución: Catetos de $12\text{ cm}$ y $5\text{ cm}$</span>'),
  @('Encuentra dos números positivos sabiendo que su diferencia es $5$ y que la suma de sus raíces cuadradas es $5$.', '$x = 9, \ y = 4$', '<p>1. Planteamos el sistema: $\begin{cases} x - y = 5 \\ \sqrt{x} + \sqrt{y} = 5 \end{cases}$.</p><p>2. Como $x - y = (\sqrt{x} - \sqrt{y})(\sqrt{x} + \sqrt{y}) = 5 \implies 5(\sqrt{x} - \sqrt{y}) = 5 \implies \sqrt{x} - \sqrt{y} = 1$.</p><p>3. Sumamos $(\sqrt{x} + \sqrt{y} = 5) + (\sqrt{x} - \sqrt{y} = 1) \implies 2\sqrt{x} = 6 \implies \sqrt{x} = 3 \implies x = 9$ e $y = 4$.</p><span class="res-badge">Solución: $x = 9, \ y = 4$</span>')
)

Write-TopicHtmlFiles "sistemas-no-lineales-1-bach" "Sistemas de Ecuaciones No Lineales" "Matemáticas 1º Bachillerato" $formNoLineales $exNoLineales

# ==============================================================================
# TEMA 4: SISTEMAS DE 3 INCÓGNITAS - MÉTODO DE GAUSS (1º Bachillerato) -> slug: sistemas-gauss-1-bach
# ==============================================================================
$formGauss = @'
  <div class="section-card">
    <h2 class="section-title"><span class="num-circle">1</span><span>¿En qué consiste el Método de Gauss? (Los 3 Ceros)</span></h2>
    <div class="steps-grid">
      <div class="step-box">
        <span class="step-header">🎯 Objetivo: Triangular el Sistema</span>
        <div>Pasamos el sistema a su <strong>Matriz Ampliada</strong> y hacemos operaciones por filas para conseguir <strong>3 ceros en la esquina inferior izquierda</strong> (debajo de la diagonal):</div>
        <div class="formula-big">$$\left(\begin{array}{ccc|c} a & b & c & d \\ \mathbf{0} & e & f & g \\ \mathbf{0} & \mathbf{0} & h & k \end{array}\right)$$</div>
      </div>
      <div class="step-box">
        <span class="step-header">💡 Truco antes de empezar: El Pivote $1$</span>
        <div>Antes de hacer cuentas, mira las 3 ecuaciones:<br><strong>Si alguna ecuación empieza por $1x$ o $-1x$, ponla la PRIMERA (Fila 1).</strong><br>Así harás todos los ceros sin fracciones ni cuentas difíciles.</div>
        <div class="example-pill"><strong>Operaciones permitidas:</strong> Intercambiar filas, multiplicar una fila por un número y sumarle o restarle otra fila.</div>
      </div>
    </div>
  </div>

  <div class="section-card">
    <h2 class="section-title"><span class="num-circle">2</span><span>Receta Paso a Paso para Triangular sin Equivocarte</span></h2>
    <div class="three-cols">
      <div class="step-box">
        <span class="step-header">PASO 1: Ceros en Columna 1</span>
        <div>Usa siempre la <strong>Fila 1 ($F_1$)</strong> para hacer cero debajo de ella, tanto en la Fila 2 como en la Fila 3:</div>
        <div class="example-pill">$F_2 \rightarrow F_2 - a \cdot F_1$<br>$F_3 \rightarrow F_3 - b \cdot F_1$</div>
      </div>
      <div class="step-box">
        <span class="step-header">PASO 2: Cero en Columna 2</span>
        <div>Usa la <strong>nueva Fila 2 ($F_2$)</strong> para hacer cero debajo de ella en la Fila 3.<br><strong>¡Nunca uses $F_1$ aquí!</strong> (estropearías el cero del Paso 1).</div>
        <div class="example-pill">$F_3 \rightarrow c \cdot F_3 - d \cdot F_2$</div>
      </div>
      <div class="step-box">
        <span class="step-header">PASO 3: Despejar hacia arriba</span>
        <div>Vuelve a escribir las $x, y, z$ y despeja en cascada de abajo arriba:</div>
        <div class="example-pill"><strong>1º</strong> Despeja $z$ en la Fila 3.<br><strong>2º</strong> Sustituye $z$ en la Fila 2 y halla $y$.<br><strong>3º</strong> Sustituye $y, z$ en la Fila 1 y halla $x$.</div>
      </div>
    </div>
  </div>

  <div class="section-card" style="margin-bottom: 0;">
    <h2 class="section-title"><span class="num-circle">3</span><span>Cómo Clasificar el Sistema mirando la Última Fila ($F_3$)</span></h2>
    <div class="three-cols">
      <div class="step-box" style="background: #f0fdf4; border-color: #86efac;">
        <span class="step-header" style="color: #166534;">🟢 S.C.D. (Compatible Determinado)</span>
        <div>La última fila queda: $$\mathbf{(0 \ \ 0 \ \ h \ | \ k)} \quad \text{con } h \neq 0$$</div>
        <div>Tiene <strong>1 solución única</strong> $(x, y, z)$.</div>
      </div>
      <div class="step-box" style="background: #fffbeb; border-color: #fde047;">
        <span class="step-header" style="color: #92400e;">🟡 S.C.I. (Compatible Indeterminado)</span>
        <div>La última fila se anula entera: $$\mathbf{(0 \ \ 0 \ \ 0 \ | \ 0)}$$</div>
        <div>Tiene <strong>infinitas soluciones</strong>. Llama $\mathbf{z = \lambda}$ y despeja $y$ y $x$ en función de $\lambda$.</div>
      </div>
      <div class="step-box" style="background: #fef2f2; border-color: #fecaca;">
        <span class="step-header" style="color: #991b1b;">🔴 S.I. (Sistema Incompatible)</span>
        <div>La última fila da algo imposible: $$\mathbf{(0 \ \ 0 \ \ 0 \ | \ k)} \quad \text{con } k \neq 0$$</div>
        <div>Significa $0z = k \rightarrow$ <strong>No tiene solución</strong>.</div>
      </div>
    </div>
  </div>
'@

$exGauss = @(
  @('Resuelve el siguiente sistema ya escalonado: $\begin{cases} x + y + z = 6 \\ 2y - z = 1 \\ 3z = 9 \end{cases}$', '$(1, 2, 3)$', '<p>1. De la 3ª ecuación: $3z = 9 \implies z = 3$</p><p>2. Sustituimos en la 2ª: $2y - 3 = 1 \implies 2y = 4 \implies y = 2$</p><p>3. Sustituimos en la 1ª: $x + 2 + 3 = 6 \implies x = 1$</p><span class="res-badge">Solución: $(x, y, z) = (1, 2, 3)$</span>'),
  @('Resuelve el sistema escalonado: $\begin{cases} 2x - y + z = 5 \\ y + 2z = 4 \\ -2z = -2 \end{cases}$', '$(3, 2, 1)$', '<p>1. De la 3ª ecuación: $-2z = -2 \implies z = 1$</p><p>2. En la 2ª ecuación: $y + 2(1) = 4 \implies y = 2$</p><p>3. En la 1ª ecuación: $2x - 2 + 1 = 5 \implies 2x = 6 \implies x = 3$</p><span class="res-badge">Solución: $(x, y, z) = (3, 2, 1)$</span>'),
  @('Resuelve por el método de Gauss: $\begin{cases} x + y + z = 6 \\ x - y + 2z = 5 \\ x + y - z = 0 \end{cases}$', '$(1, 2, 3)$', '<p>1. Hacemos ceros debajo de $x$ usando la Fila 1 ($F_2 \to F_2 - F_1$ y $F_3 \to F_3 - F_1$):</p><p>$$\begin{cases} x + y + z = 6 \\ -2y + z = -1 \\ -2z = -6 \end{cases}$$</p><p>2. Ya está escalonado: de $F_3 \implies z = 3$. En $F_2$: $-2y + 3 = -1 \implies y = 2$. En $F_1$: $x = 6 - 2 - 3 = 1$.</p><span class="res-badge">Solución: $(1, 2, 3)$</span>'),
  @('Resuelve por el método de Gauss: $\begin{cases} x + y + z = 2 \\ 2x + 3y + 5z = 11 \\ x - 5y + 6z = 29 \end{cases}$', '$(1, -2, 3)$', '<p>1. Primer paso de Gauss ($F_2 \to F_2 - 2F_1$ y $F_3 \to F_3 - F_1$): $\begin{cases} x + y + z = 2 \\ y + 3z = 7 \\ -6y + 5z = 27 \end{cases}$</p><p>2. Segundo paso ($F_3 \to F_3 + 6F_2$): $23z = 69 \implies z = 3$</p><p>3. Sustituimos hacia arriba: $y = 7 - 3(3) = -2$ y $x = 2 - (-2) - 3 = 1$.</p><span class="res-badge">Solución: $(1, -2, 3)$</span>'),
  @('Resuelve por el método de Gauss: $\begin{cases} x - y + z = 2 \\ 2x + y - z = 1 \\ x + 2y + z = 8 \end{cases}$', '$(1, 2, 3)$', '<p>1. Operaciones de la 1ª columna ($F_2 \to F_2 - 2F_1$ y $F_3 \to F_3 - F_1$): $\begin{cases} x - y + z = 2 \\ 3y - 3z = -3 \implies y - z = -1 \\ 3y = 6 \end{cases}$</p><p>2. De la 3ª ecuación obtenemos directamente $y = 2$. En la 2ª: $2 - z = -1 \implies z = 3$. En la 1ª: $x - 2 + 3 = 2 \implies x = 1$.</p><span class="res-badge">Solución: $(1, 2, 3)$</span>'),
  @('Resuelve por Gauss intercambiando filas para tener pivote $1$: $\begin{cases} 2x + y - z = 2 \\ x + y + z = 6 \\ 3x - y + 2z = 11 \end{cases}$', '$(2, 1, 3)$', '<p>1. Ponemos la 2ª ecuación como Fila 1: $\begin{cases} x + y + z = 6 \\ 2x + y - z = 2 \\ 3x - y + 2z = 11 \end{cases}$</p><p>2. Hacemos ceros ($F_2 \to F_2 - 2F_1$, $F_3 \to F_3 - 3F_1$): $\begin{cases} x + y + z = 6 \\ -y - 3z = -10 \\ -4y - z = -7 \end{cases}$</p><p>3. Hacemos cero en $F_3$ ($F_3 \to F_3 - 4F_2$): $11z = 33 \implies z = 3$. Entonces $y = 10 - 3(3) = 1$ y $x = 6 - 1 - 3 = 2$.</p><span class="res-badge">Solución: $(2, 1, 3)$</span>'),
  @('Clasifica y resuelve por el método de Gauss: $\begin{cases} x + y - z = 1 \\ 2x + 3y + z = 3 \\ 3x + 4y = 4 \end{cases}$', 'S.C.I. ($x = 4\lambda, \ y = 1 - 3\lambda, \ z = \lambda$)', '<p>1. Primer paso ($F_2 \to F_2 - 2F_1$ y $F_3 \to F_3 - 3F_1$): $\begin{cases} x + y - z = 1 \\ y + 3z = 1 \\ y + 3z = 1 \end{cases}$</p><p>2. Segundo paso ($F_3 \to F_3 - F_2$): la 3ª fila queda $0 = 0$. Es un <strong>Sistema Compatible Indeterminado (S.C.I.)</strong>.</p><p>3. Llamamos $z = \lambda$: $y = 1 - 3\lambda$ y $x = 1 - (1 - 3\lambda) + \lambda = 4\lambda$.</p><span class="res-badge">Solución: S.C.I. ($x = 4\lambda, \ y = 1 - 3\lambda, \ z = \lambda$)</span>'),
  @('Clasifica por el método de Gauss el sistema: $\begin{cases} x + 2y - z = 3 \\ 2x - y + z = 1 \\ 3x + y = 7 \end{cases}$', 'Sistema Incompatible (S.I., sin solución)', '<p>1. Observamos que si sumamos las dos primeras ecuaciones obtenemos $3x + y = 4$, mientras que la 3ª dice $3x + y = 7$.</p><p>2. Al triangular por Gauss ($F_3 \to F_3 - F_1 - F_2$) la tercera fila queda $0 = 3$ (imposible). Es un <strong>Sistema Incompatible (S.I.)</strong>.</p><span class="res-badge">Solución: Sistema Incompatible (Sin solución)</span>'),
  @('Resuelve por el método de Gauss: $\begin{cases} x + 2y + z = 4 \\ 2x - y + 3z = 4 \\ 3x + y - z = 3 \end{cases}$', '$(1, 1, 1)$', '<p>1. Primer paso ($F_2 \to F_2 - 2F_1$ y $F_3 \to F_3 - 3F_1$): $\begin{cases} x + 2y + z = 4 \\ -5y + z = -4 \\ -5y - 4z = -9 \end{cases}$</p><p>2. Segundo paso ($F_3 \to F_3 - F_2$): $-5z = -5 \implies z = 1$</p><p>3. Sustituimos: $-5y + 1 = -4 \implies y = 1$, y en la 1ª: $x + 2(1) + 1 = 4 \implies x = 1$.</p><span class="res-badge">Solución: $(1, 1, 1)$</span>'),
  @('Resuelve por el método de Gauss: $\begin{cases} 2x + y + z = 7 \\ x - 2y + z = 0 \\ 3x + 2y - z = 4 \end{cases}$', '$(1, 2, 3)$', '<p>1. Intercambiamos $F_1 \leftrightarrow F_2$: $\begin{cases} x - 2y + z = 0 \\ 2x + y + z = 7 \\ 3x + 2y - z = 4 \end{cases}$</p><p>2. Hacemos ceros ($F_2 \to F_2 - 2F_1$, $F_3 \to F_3 - 3F_1$): $\begin{cases} x - 2y + z = 0 \\ 5y - z = 7 \\ 8y - 4z = 4 \implies 2y - z = 1 \end{cases}$</p><p>3. Restamos $F_2 - F_3$: $3y = 6 \implies y = 2$. Entonces $z = 2(2) - 1 = 3$ y $x = 2(2) - 3 = 1$.</p><span class="res-badge">Solución: $(1, 2, 3)$</span>'),
  @('Resuelve el sistema homogéneo por el método de Gauss: $\begin{cases} x + y - 2z = 0 \\ 2x - y + z = 0 \\ x - 2y + 3z = 0 \end{cases}$', 'S.C.I. ($x = \lambda/3, \ y = 5\lambda/3, \ z = \lambda$)', '<p>1. Primer paso ($F_2 \to F_2 - 2F_1$, $F_3 \to F_3 - F_1$): $\begin{cases} x + y - 2z = 0 \\ -3y + 5z = 0 \\ -3y + 5z = 0 \end{cases}$</p><p>2. Como $F_3 = F_2$, la última fila es $0 = 0$ (S.C.I.). Tomando $z = 3\lambda$: $y = 5\lambda$ y $x = 2(3\lambda) - 5\lambda = \lambda$.</p><span class="res-badge">Solución: S.C.I. ($x = \lambda, \ y = 5\lambda, \ z = 3\lambda$)</span>'),
  @('Clasifica y resuelve por Gauss: $\begin{cases} x - y + 2z = 3 \\ 2x + y - z = 0 \\ 4x - y + 3z = 6 \end{cases}$', 'S.C.I. ($x = 1 - \lambda/3, \ y = -2 + 5\lambda/3, \ z = \lambda$)', '<p>1. Hacemos ceros ($F_2 \to F_2 - 2F_1$, $F_3 \to F_3 - 4F_1$): $\begin{cases} x - y + 2z = 3 \\ 3y - 5z = -6 \\ 3y - 5z = -6 \end{cases}$</p><p>2. Al restar $F_3 - F_2$ queda $0 = 0$ (S.C.I.). Con $z = 3\lambda$: $y = -2 + 5\lambda$ y $x = 3 + (-2 + 5\lambda) - 6\lambda = 1 - \lambda$.</p><span class="res-badge">Solución: S.C.I. ($x = 1 - \lambda, \ y = -2 + 5\lambda, \ z = 3\lambda$)</span>'),
  @('Resuelve por Gauss quitando antes denominadores: $\begin{cases} \dfrac{x}{2} + \dfrac{y}{3} + z = 5 \\ x - y + z = 2 \\ 2x + y - z = 4 \end{cases}$', '$(2, 3, 3)$', '<p>1. Multiplicamos la 1ª ecuación por $6$ y ponemos la 2ª como Fila 1: $\begin{cases} x - y + z = 2 \\ 2x + y - z = 4 \\ 3x + 2y + 6z = 30 \end{cases}$</p><p>2. Hacemos ceros ($F_2 \to F_2 - 2F_1$, $F_3 \to F_3 - 3F_1$): $\begin{cases} x - y + z = 2 \\ 3y - 3z = 0 \\ 5y + 3z = 24 \end{cases}$</p><p>3. Sumamos $F_2 + F_3$: $8y = 24 \implies y = 3$. Entonces $z = 3$ y $x = 2 + 3 - 3 = 2$.</p><span class="res-badge">Solución: $(2, 3, 3)$</span>'),
  @('Halla el valor del parámetro $k$ para que el sistema sea compatible indeterminado (S.C.I.): $\begin{cases} x + y + z = 2 \\ 2x + 3y + z = 5 \\ 3x + 4y + 2z = k \end{cases}$', '$k = 7$', '<p>1. Observamos que la 3ª ecuación tiene por primer miembro la suma de las dos primeras: $(x+2x) + (y+3y) + (z+z) = 3x + 4y + 2z$.</p><p>2. Al triangular por Gauss ($F_3 \to F_3 - F_1 - F_2$) queda $0 = k - 7$. Para que sea S.C.I. debe ser $k - 7 = 0 \implies k = 7$.</p><span class="res-badge">Solución: $k = 7$</span>'),
  @('Discute por el método de Gauss según los valores de $m$: $\begin{cases} x + y + z = 1 \\ 2x + y + 3z = 2 \\ 3x + 2y + mz = 3 \end{cases}$', 'Si $m \neq 4$: S.C.D.; Si $m = 4$: S.C.I.', '<p>1. Hacemos ceros ($F_2 \to F_2 - 2F_1$, $F_3 \to F_3 - 3F_1$): $\begin{cases} x + y + z = 1 \\ -y + z = 0 \\ -y + (m - 3)z = 0 \end{cases}$</p><p>2. Restamos $F_3 \to F_3 - F_2$: $(m - 4)z = 0$.</p><p>&bull; Si $m \neq 4$: <strong>S.C.D.</strong> (solución única $z = 0, y = 0, x = 1$).</p><p>&bull; Si $m = 4$: queda $0 = 0 \implies$ <strong>S.C.I.</strong> (infinitas soluciones).</p><span class="res-badge">Solución: Si $m \neq 4$ es S.C.D.; si $m = 4$ es S.C.I.</span>'),
  @('Discute según el parámetro $a$ aplicando Gauss: $\begin{cases} x - y + z = 1 \\ 2x + y + z = 2 \\ 3x + az = 5 \end{cases}$', 'Si $a \neq 2$: S.C.D.; Si $a = 2$: S.I.', '<p>1. Hacemos ceros ($F_2 \to F_2 - 2F_1$ y $F_3 \to F_3 - 3F_1$): $\begin{cases} x - y + z = 1 \\ 3y - z = 0 \\ 3y + (a - 3)z = 2 \end{cases}$</p><p>2. Segundo paso ($F_3 \to F_3 - F_2$): $(a - 2)z = 2$.</p><p>&bull; Si $a \neq 2$: <strong>S.C.D.</strong> (solución única con $z = \dfrac{2}{a - 2}$).</p><p>&bull; Si $a = 2$: queda $0z = 2 \implies$ <strong>S.I.</strong> (sin solución).</p><span class="res-badge">Solución: Si $a \neq 2$ es S.C.D.; si $a = 2$ es S.I.</span>'),
  @('La suma de tres números es $12$. El primero más el doble del segundo menos el tercero vale $6$, y el triple del primero menos el segundo más el tercero vale $10$. Calcula los tres números por Gauss.', '$x = 3, \ y = 4, \ z = 5$', '<p>1. Planteamos el sistema: $\begin{cases} x + y + z = 12 \\ x + 2y - z = 6 \\ 3x - y + z = 10 \end{cases}$</p><p>2. Triangularizamos ($F_2 \to F_2 - F_1$, $F_3 \to F_3 - 3F_1$): $\begin{cases} x + y + z = 12 \\ y - 2z = -6 \\ -4y - 2z = -26 \end{cases}$</p><p>3. Restamos $F_3 - F_2$: $-5y = -20 \implies y = 4$. Entonces $4 - 2z = -6 \implies z = 5$ y $x = 12 - 4 - 5 = 3$.</p><span class="res-badge">Solución: $x = 3, \ y = 4, \ z = 5$</span>'),
  @('En una tienda, $1$ cuaderno, $1$ bolígrafo y $1$ carpeta cuestan $10\text{ €}$. Además, $2$ cuadernos, $3$ bolígrafos y $1$ carpeta cuestan $17\text{ €}$, y $1$ cuaderno, $2$ bolígrafos y $2$ carpetas cuestan $17\text{ €}$. Calcula el precio de cada artículo por Gauss.', 'Cuaderno $3\text{ €}$, Bolígrafo $2\text{ €}$, Carpeta $5\text{ €}$', '<p>1. Sistema: $\begin{cases} x + y + z = 10 \\ 2x + 3y + z = 17 \\ x + 2y + 2z = 17 \end{cases}$</p><p>2. Hacemos ceros ($F_2 \to F_2 - 2F_1$, $F_3 \to F_3 - F_1$): $\begin{cases} x + y + z = 10 \\ y - z = -3 \\ y + z = 7 \end{cases}$</p><p>3. Restamos $F_3 - F_2$: $2z = 10 \implies z = 5\text{ €}$, $y = 7 - 5 = 2\text{ €}$ y $x = 10 - 2 - 5 = 3\text{ €}$.</p><span class="res-badge">Solución: Cuaderno $3\text{ €}$, Bolígrafo $2\text{ €}$, Carpeta $5\text{ €}$</span>'),
  @('Un número de tres cifras suma $12$ entre sus tres dígitos. La cifra de las centenas más la de las unidades es igual al doble de la de las decenas, y si se invierte el orden de las cifras el número aumenta en $198$ unidades. Halla el número por Gauss.', 'El número es $345$', '<p>1. Sean $x$ centenas, $y$ decenas y $z$ unidades: $\begin{cases} x + y + z = 12 \\ x - 2y + z = 0 \\ (100z + 10y + x) - (100x + 10y + z) = 198 \implies -x + z = 2 \end{cases}$</p><p>2. Restamos $F_1 - F_2$: $3y = 12 \implies y = 4$. Nos queda $\begin{cases} x + z = 8 \\ -x + z = 2 \end{cases} \implies 2z = 10 \implies z = 5, \ x = 3$. El número es el $345$.</p><span class="res-badge">Solución: $345$</span>'),
  @('La suma de las edades de un padre, una madre y su hijo es de $80$ años. El padre tiene $2$ años más que la madre, y dentro de $11$ años la edad del padre será el doble que la que tendrá el hijo. Calcula sus edades actuales por Gauss.', 'Padre $35$ años, Madre $33$ años, Hijo $12$ años', '<p>1. Sistema: $\begin{cases} x + y + z = 80 \\ x - y = 2 \\ x + 11 = 2(z + 11) \implies x - 2z = 11 \end{cases}$</p><p>2. Por Gauss ($F_2 \to F_2 - F_1$, $F_3 \to F_3 - F_1$): $\begin{cases} x + y + z = 80 \\ -2y - z = -78 \\ -y - 3z = -69 \end{cases}$</p><p>3. Operamos $2F_3 - F_2$: $-5z = -60 \implies z = 12$. Entonces $y = (78 - 12)/2 = 33$ y $x = 33 + 2 = 35$.</p><span class="res-badge">Solución: Padre $35$ años, Madre $33$ años, Hijo $12$ años</span>'),
  @('Un inversor reparte $10\,000\text{ €}$ en tres fondos $A, B$ y $C$ que rinden un $4\%, 5\%$ y $6\%$ anual respectivamente, obteniendo un beneficio total de $520\text{ €}$. Si en el fondo $C$ invirtió la suma de lo invertido en $A$ y $B$, ¿cuánto invirtió en cada fondo?', '$A = 3\,000\text{ €}, \ B = 2\,000\text{ €}, \ C = 5\,000\text{ €}$', '<p>1. Planteamos el sistema: $\begin{cases} x + y + z = 10\,000 \\ 4x + 5y + 6z = 52\,000 \\ x + y - z = 0 \end{cases}$</p><p>2. Restamos $F_1 - F_3$: $2z = 10\,000 \implies z = 5\,000\text{ €}$.</p><p>3. Sustituimos $z = 5\,000$: $\begin{cases} x + y = 5\,000 \\ 4x + 5y = 22\,000 \end{cases} \implies y = 2\,000\text{ €}$ y $x = 3\,000\text{ €}$.</p><span class="res-badge">Solución: $A = 3\,000\text{ €}, \ B = 2\,000\text{ €}, \ C = 5\,000\text{ €}$</span>'),
  @('Halla la ecuación de la parábola $y = ax^2 + bx + c$ cuya gráfica pasa por los puntos $A(1, 2), \ B(-1, 6)$ y $C(2, 3)$ resolviendo el sistema resultante por Gauss.', '$y = x^2 - 2x + 3$', '<p>1. Sustituimos cada punto $(x, y)$ en $ax^2 + bx + c = y$: $\begin{cases} a + b + c = 2 \\ a - b + c = 6 \\ 4a + 2b + c = 3 \end{cases}$</p><p>2. Restamos $F_1 - F_2$: $2b = -4 \implies b = -2$.</p><p>3. Con $b = -2$ nos queda $\begin{cases} a + c = 4 \\ 4a + c = 7 \end{cases} \implies 3a = 3 \implies a = 1, \ c = 3$. La parábola es $y = x^2 - 2x + 3$.</p><span class="res-badge">Solución: $a = 1, \ b = -2, \ c = 3 \implies y = x^2 - 2x + 3$</span>')
)

Write-TopicHtmlFiles "sistemas-gauss-1-bach" "Sistemas de 3 Incógnitas (Método de Gauss)" "Matemáticas 1º Bachillerato" $formGauss $exGauss

Write-Output "Generated 12 HTML files (4 new topics x 3 files each)!"
