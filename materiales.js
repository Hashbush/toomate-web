// ==========================================================================
// TOOMATE.ES - REPOSITORIO MAESTRO DE MATERIALES DIDÁCTICOS
// Currículo Oficial de Cantabria (LOMLOE) - Secundaria & Bachillerato
// Matemáticas, Física y Química
// ==========================================================================

const materiales = [

  // ==========================================================================
  // MATEMÁTICAS - 2º BACHILLERATO / EvAU (CIENCIAS Y CCSS)
  // ==========================================================================
  {
    id: "mat-01",
    asignatura: "matematicas",
    titulo: "Matrices y Determinantes: Inversas y Ecuaciones Matriciales",
    curso: "2-bach",
    cursoTexto: "2º Bachillerato / EvAU",
    categoria: "algebra",
    descripcion: "Propiedades de determinantes, cálculo de inversa por adjuntos, operaciones y resolución paso a paso de ecuaciones matriciales tipo A·X - B = 2X.",
    tags: ["Teoría + Fórmulas", "Boletín 22 Ejercicios", "EvAU", "Matemáticas II"],
    paginas: "12 págs + Boletín",
    colorBadge: "bg-blue-100 text-blue-700 border-blue-200",
    pdfUrl: "materiales/matrices-2-bach.html",
    ejerciciosUrl: "materiales/ejercicios-matrices-2-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+matrices+determinantes",
    formulasClave: ["|A \\cdot B| = |A| \\cdot |B|", "A^{-1} = \\frac{1}{|A|} (\\text{Adj}(A))^t", "|k \\cdot A_{n \\times n}| = k^n |A|"],
    puntosContenido: [
      "Operaciones de matrices y no conmutatividad del producto (A·B ≠ B·A)",
      "Propiedades clave de los determinantes para exámenes",
      "Las 3 trampas típicas al despejar ecuaciones matriciales",
      "Boletín completo con 22 ejercicios graduados con soluciones paso a paso"
    ]
  },
  {
    id: "sis-01",
    asignatura: "matematicas",
    titulo: "Sistemas de Ecuaciones: Teorema de Rouché-Fröbenius y Cramer",
    curso: "2-bach",
    cursoTexto: "2º Bachillerato / EvAU",
    categoria: "algebra",
    descripcion: "Esquema maestro de Rouché, discusión con parámetros paso a paso, sistemas homogéneos y resolución de S.C.I. con parámetros y Cramer.",
    tags: ["Teoría & Rangos", "Boletín 22 Ejercicios", "EvAU 2,5 pts", "Matemáticas II"],
    paginas: "15 págs + Boletín",
    colorBadge: "bg-indigo-100 text-indigo-700 border-indigo-200",
    pdfUrl: "materiales/sistemas-rouche-2-bach.html",
    ejerciciosUrl: "materiales/ejercicios-rouche-2-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+rouche+frobenius",
    formulasClave: [
      "\\text{Rg}(A) = \\text{Rg}(A^*) = n \\implies \\text{S.C.D.}",
      "\\text{Rg}(A) = \\text{Rg}(A^*) = r < n \\implies \\text{S.C.I.}",
      "\\text{Rg}(A) \\neq \\text{Rg}(A^*) \\implies \\text{S.I.}"
    ],
    puntosContenido: [
      "Tabla maestra de clasificación por rangos e interpretación geométrica",
      "Sistemas homogéneos: por qué nunca son incompatibles",
      "Metodología infalible para discutir sistemas con parámetro (m)",
      "Boletín interactivo con 22 ejercicios graduados y soluciones desplegables paso a paso"
    ]
  },
  {
    id: "int-01",
    asignatura: "matematicas",
    titulo: "Cálculo Integral: Regla de Barrow y Cálculo de Áreas",
    curso: "2-bach",
    cursoTexto: "2º Bachillerato / EvAU",
    categoria: "analisis",
    descripcion: "Cálculo de primitivas inmediatas, por partes y racionales, integrales definidas y delimitación de áreas entre dos curvas con gráficas explicadas.",
    tags: ["Cálculo de Áreas", "Regla de Barrow", "EvAU", "Matemáticas II"],
    paginas: "16 págs",
    colorBadge: "bg-rose-100 text-brand-700 border-rose-200",
    pdfUrl: "materiales/integrales-2-bach.html",
    ejerciciosUrl: "materiales/ejercicios-integrales-2-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+integrales+areas",
    formulasClave: ["\\int f(x)\\,dx = F(x) + C", "\\int_a^b f(x)\\,dx = F(b) - F(a)", "\\text{Área} = \\int_a^b |f(x) - g(x)| \\, dx"],
    puntosContenido: [
      "Definición de integral definida y propiedades esenciales",
      "Regla de Barrow y errores típicos en exámenes",
      "Cálculo de puntos de corte entre funciones para límites de integración",
      "Colección de problemas reales de Selectividad resueltos"
    ]
  },
  {
    id: "geo-01",
    asignatura: "matematicas",
    titulo: "Geometría en el Espacio: Rectas, Planos y Posiciones Relativas",
    curso: "2-bach",
    cursoTexto: "2º Bachillerato / EvAU",
    categoria: "geometria",
    descripcion: "Ecuaciones vectorial, paramétricas y continuas en R³. Distancias, ángulos, punto simétrico y haces de planos.",
    tags: ["Geometría R³", "Guía Visual", "EvAU", "Matemáticas II"],
    paginas: "18 págs",
    colorBadge: "bg-purple-100 text-purple-700 border-purple-200",
    pdfUrl: "materiales/geometria-espacio-2-bach.html",
    ejerciciosUrl: "materiales/ejercicios-geometria-espacio-2-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+geometria+espacio",
    formulasClave: ["\\vec{n} = \\vec{u} \\times \\vec{v}", "\\text{dist}(P, \\pi) = \\frac{|Ax_0 + By_0 + Cz_0 + D|}{\\sqrt{A^2 + B^2 + C^2}}"],
    puntosContenido: [
      "Vector director y normal: cómo hallarlos rápidamente",
      "Posición relativa entre dos rectas (se cruzan vs se cortan)",
      "Distancia entre rectas que se cruzan por producto mixto",
      "Cálculo del punto simétrico de un punto respecto a un plano"
    ]
  },
  {
    id: "prob-01",
    asignatura: "matematicas",
    titulo: "Probabilidad: Teorema de Bayes y Distribución Normal / Binomial",
    curso: "2-bach",
    cursoTexto: "2º Bachillerato / EvAU",
    categoria: "probabilidad",
    descripcion: "Diagramas en árbol, tablas de contingencia, probabilidad condicionada, teorema de Bayes y manejo ágil de la tabla N(0, 1).",
    tags: ["Estadística", "Tablas N(0,1)", "EvAU Ciencias & CCSS"],
    paginas: "14 págs",
    colorBadge: "bg-amber-100 text-amber-700 border-amber-200",
    pdfUrl: "materiales/probabilidad-normal-2-bach.html",
    ejerciciosUrl: "materiales/ejercicios-probabilidad-normal-2-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+probabilidad+bayes",
    formulasClave: ["P(A|B) = \\frac{P(A \\cap B)}{P(B)}", "P(B_i|A) = \\frac{P(B_i)P(A|B_i)}{\\sum P(B_k)P(A|B_k)}"],
    puntosContenido: [
      "Cómo plantear el árbol de probabilidad sin dudar",
      "Teorema de Bayes explicado con ejemplos sencillos",
      "Aproximación de la Binomial por la Normal",
      "Intervalos de confianza y cálculo de tamaño muestral"
    ]
  },
  {
    id: "prog-lin-02",
    asignatura: "matematicas",
    titulo: "Programación Lineal: Región Factible y Optimización de Beneficios",
    curso: "2-bach",
    cursoTexto: "2º Bach CCSS / EvAU",
    categoria: "algebra",
    descripcion: "Planteamiento de restricciones, representación gráfica del polígono de soluciones factibles y cálculo del máximo o mínimo en los vértices.",
    tags: ["Programación Lineal", "Ciencias Sociales", "EvAU CCSS"],
    paginas: "12 págs",
    colorBadge: "bg-emerald-100 text-emerald-800 border-emerald-200",
    pdfUrl: "materiales/programacion-lineal-2-bach.html",
    ejerciciosUrl: "materiales/ejercicios-programacion-lineal-2-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+programacion+lineal+ccss",
    formulasClave: ["f(x, y) = Ax + By", "\\text{Sistemas de Inecuaciones Lineales}"],
    puntosContenido: [
      "Pasos para traducir el enunciado a restricciones algebraicas",
      "Trazado del semiplano solución para cada restricción",
      "Cálculo de las coordenadas exactas de los vértices por sistemas 2x2",
      "Evaluación de la función objetivo para hallar el óptimo"
    ]
  },

  // ==========================================================================
  // MATEMÁTICAS - 1º BACHILLERATO (CIENCIAS Y CCSS)
  // ==========================================================================
  {
    id: "trig-1b",
    asignatura: "matematicas",
    titulo: "1º Bach Matemáticas I: Trigonometría Plana y Ecuaciones",
    curso: "1-bach",
    cursoTexto: "1º Bachillerato Científico",
    categoria: "geometria",
    descripcion: "Circunferencia goniométrica, fórmulas de adición, ángulo doble, mitad, ecuaciones trigonométricas y Teoremas del Seno y Coseno.",
    tags: ["LOMLOE Cantabria", "Teoría Completa", "Boletín 22 Ejercicios", "Matemáticas I"],
    paginas: "15 págs + Boletín",
    colorBadge: "bg-purple-100 text-purple-800 border-purple-200",
    pdfUrl: "materiales/trigonometria-1-bach.html",
    ejerciciosUrl: "materiales/ejercicios-trigonometria-1-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+trigonometria+1+bachillerato",
    formulasClave: [
      "\\sin(2\\alpha) = 2\\sin\\alpha \\cos\\alpha",
      "\\cos(2\\alpha) = \\cos^2\\alpha - \\sin^2\\alpha",
      "\\frac{a}{\\sin A} = \\frac{b}{\\sin B} = \\frac{c}{\\sin C}",
      "a^2 = b^2 + c^2 - 2bc \\cos A"
    ],
    puntosContenido: [
      "Razones trigonométricas en cualquier cuadrante y reducción al 1º",
      "Demostración rigurosa de identidades trigonométricas",
      "Resolución de ecuaciones trigonométricas con soluciones generales (+2kπ)",
      "Boletín con 22 ejercicios graduados con soluciones paso a paso desplegables"
    ]
  },
  {
    id: "finanzas-1b",
    asignatura: "matematicas",
    titulo: "1º Bach CCSS: Matemática Financiera, TAE y Amortización",
    curso: "1-bach",
    cursoTexto: "1º Bachillerato CCSS",
    categoria: "algebra",
    descripcion: "Interés simple y compuesto, liquidaciones fraccionadas, deducción de la TAE, anualidades de capitalización y cuota mensual de hipotecas.",
    tags: ["LOMLOE Cantabria", "Finanzas Prácticas", "Boletín 22 Ejercicios", "Matemáticas CCSS"],
    paginas: "14 págs + Boletín",
    colorBadge: "bg-amber-100 text-amber-800 border-amber-200",
    pdfUrl: "materiales/matematica-financiera-1-bach-ccss.html",
    ejerciciosUrl: "materiales/ejercicios-matematica-financiera-1-bach-ccss.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+matematica+financiera+ccss+1+bach",
    formulasClave: [
      "C_f = C_0 (1 + r/k)^{kt}",
      "\\text{TAE} = (1 + r/k)^k - 1",
      "a = \\frac{C_0 \\cdot r \\cdot (1 + r)^t}{(1 + r)^t - 1}"
    ],
    puntosContenido: [
      "Comparación real entre capitalizaciones mensuales, trimestrales y anuales",
      "Fórmula de la Tasa Anual Equivalente y comisiones bancarias",
      "Planes de pensiones y fondos de inversión (capitalización periódica)",
      "Boletín de 22 problemas prácticos resueltos paso a paso"
    ]
  },
  {
    id: "der-01",
    asignatura: "matematicas",
    titulo: "Derivadas: Estudio Completo de Funciones y Optimización",
    curso: "1-bach",
    cursoTexto: "1º y 2º Bachillerato",
    categoria: "analisis",
    descripcion: "Asíntotas, crecimiento, curvatura y representación gráfica. Problemas de optimización resueltos (máximos y mínimos).",
    tags: ["Análisis", "Optimización", "Gráficas"],
    paginas: "20 págs",
    colorBadge: "bg-emerald-100 text-emerald-700 border-emerald-200",
    pdfUrl: "materiales/derivadas-optimizacion-1-bach.html",
    ejerciciosUrl: "materiales/ejercicios-derivadas-optimizacion-1-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+derivadas+optimizacion",
    formulasClave: ["f'(x_0) = 0 \\implies \\text{Extremo}", "f''(x) > 0 \\implies \\text{Convexa}"],
    puntosContenido: [
      "Interpretación geométrica de la derivada y recta tangente",
      "Monotonía y extremos relativos mediante primera y segunda derivada",
      "Paso a paso para resolver problemas de optimización sin perder puntos",
      "Colección de funciones para representar con su gráfica"
    ]
  },

  // ==========================================================================
  // MATEMÁTICAS - 3º Y 4º ESO
  // ==========================================================================
  {
    id: "eso4-acad-01",
    asignatura: "matematicas",
    titulo: "4º ESO Académicas (Mat. B): Números Reales, Radicales y Logaritmos",
    curso: "3-4-eso",
    cursoTexto: "4º ESO Matemáticas B (Cantabria)",
    categoria: "algebra",
    descripcion: "Clasificación de números reales, intervalos y semirrectas, propiedades de radicales, operaciones, extracción de factores, los 3 casos de racionalización e iniciación a logaritmos.",
    tags: ["LOMLOE Cantabria", "Teoría + Ejemplos", "Boletín 22 Ejercicios", "Paso a Paso"],
    paginas: "12 págs + Boletín",
    colorBadge: "bg-emerald-100 text-emerald-800 border-emerald-200",
    pdfUrl: "materiales/numeros-reales-4eso-academicas.html",
    ejerciciosUrl: "materiales/ejercicios-numeros-reales-4eso-academicas.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+numeros+reales+radicales+4+eso",
    formulasClave: [
      "\\sqrt[n]{a^m} = a^{m/n}",
      "\\frac{a}{\\sqrt{b} - \\sqrt{c}} = \\frac{a(\\sqrt{b} + \\sqrt{c})}{b - c}",
      "\\log_a(x) = y \\iff a^y = x"
    ],
    puntosContenido: [
      "Clasificación completa: N ⊂ Z ⊂ Q ⊂ R y tipos de números irracionales",
      "Intervalos abiertos, cerrados, semiabiertos y semirrectas infinitas",
      "Racionalización completa de denominadores (caso simple, índice n y binomios conjugados)",
      "Boletín con 22 ejercicios graduados con soluciones paso a paso desplegables"
    ]
  },
  {
    id: "eso4-apli-01",
    asignatura: "matematicas",
    titulo: "4º ESO Aplicadas (Mat. A): Números Reales, Porcentajes y Matemática Financiera",
    curso: "3-4-eso",
    cursoTexto: "4º ESO Matemáticas A (Cantabria)",
    categoria: "algebra",
    descripcion: "Aproximaciones, error absoluto y relativo, notación científica, aumentos y rebajas porcentuales encadenadas, cálculo de IVA e interés simple y compuesto.",
    tags: ["LOMLOE Cantabria", "Finanzas Prácticas", "Boletín 22 Ejercicios", "Paso a Paso"],
    paginas: "11 págs + Boletín",
    colorBadge: "bg-amber-100 text-amber-800 border-amber-200",
    pdfUrl: "materiales/numeros-reales-4eso-aplicadas.html",
    ejerciciosUrl: "materiales/ejercicios-numeros-reales-4eso-aplicadas.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+porcentajes+interes+compuesto+4+eso",
    formulasClave: [
      "C_f = C_i \\cdot (1 \\pm r)",
      "I = C_0 \\cdot r \\cdot t",
      "C_f = C_0 \\cdot (1 + r)^t"
    ],
    puntosContenido: [
      "Conjuntos numéricos y redondeo/truncamiento en la vida real",
      "Cálculo de error absoluto (E_a) y error relativo porcentual (E_r)",
      "Encadenamiento de variaciones porcentuales (índices de variación multiplicativos)",
      "Boletín con 22 problemas prácticos resueltos paso a paso"
    ]
  },
  {
    id: "eso4-pol-01",
    asignatura: "matematicas",
    titulo: "4º ESO: Polinomios, Regla de Ruffini y Fracciones Algebraicas",
    curso: "3-4-eso",
    cursoTexto: "4º ESO (Cantabria LOMLOE)",
    categoria: "algebra",
    descripcion: "Operaciones con polinomios, identidades notables, teorema del resto y del factor, factorización sistemática en 4 pasos, M.C.D., M.C.M. y simplificación de fracciones algebraicas.",
    tags: ["LOMLOE Cantabria", "Ruffini & Factores", "Boletín 22 Ejercicios", "Paso a Paso"],
    paginas: "14 págs + Boletín",
    colorBadge: "bg-indigo-100 text-indigo-800 border-indigo-200",
    pdfUrl: "materiales/polinomios-fracciones-4eso.html",
    ejerciciosUrl: "materiales/ejercicios-polinomios-fracciones-4eso.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+polinomios+ruffini+fracciones+algebraicas+4+eso",
    formulasClave: [
      "(a \\pm b)^2 = a^2 \\pm 2ab + b^2",
      "(a + b)(a - b) = a^2 - b^2",
      "P(a) = R \\quad (\\text{Teorema del Resto})"
    ],
    puntosContenido: [
      "Desarrollo e identificación de las tres identidades notables",
      "División polinómica y algoritmo de la Regla de Ruffini con ceros intercalados",
      "Operaciones completas con fracciones algebraicas (suma, resta, producto y división)",
      "Boletín de 22 ejercicios graduados con soluciones desplegables paso a paso"
    ]
  },
  {
    id: "eso4-ecu-01",
    asignatura: "matematicas",
    titulo: "4º ESO: Ecuaciones Bicuadradas, Racionales, Irracionales e Inecuaciones",
    curso: "3-4-eso",
    cursoTexto: "4º ESO (Cantabria LOMLOE)",
    categoria: "algebra",
    descripcion: "Ecuaciones bicuadradas con cambio de variable, ecuaciones racionales, ecuaciones con radicales y comprobación obligatoria, inecuaciones de 1º y 2º grado y sistemas no lineales.",
    tags: ["LOMLOE Cantabria", "Ecuaciones Avanzadas", "Inecuaciones", "Boletín 22 Ejercicios"],
    paginas: "15 págs + Boletín",
    colorBadge: "bg-cyan-100 text-cyan-800 border-cyan-200",
    pdfUrl: "materiales/ecuaciones-inecuaciones-4eso.html",
    ejerciciosUrl: "materiales/ejercicios-ecuaciones-inecuaciones-4eso.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+bicuadradas+irracionales+inecuaciones+4+eso",
    formulasClave: [
      "a z^2 + b z + c = 0 \\quad (z = x^2)",
      "\\sqrt{A} = B \\implies A = B^2",
      "-k \\cdot x \\le b \\implies x \\ge -b/k"
    ],
    puntosContenido: [
      "Resolución de ecuaciones bicuadradas y descarte de soluciones imaginarias",
      "Ecuaciones fraccionarias/racionales con eliminación de denominadores",
      "Aislamiento de radicales y comprobación obligatoria de soluciones",
      "Boletín con 22 ejercicios graduados con soluciones paso a paso desplegables"
    ]
  },
  {
    id: "suc-01",
    asignatura: "matematicas",
    titulo: "Sucesiones: Progresiones Aritméticas y Geométricas",
    curso: "3-4-eso",
    cursoTexto: "3º y 4º ESO",
    categoria: "algebra",
    descripcion: "Término general, cálculo de la diferencia o razón, suma de n términos consecutivos y aplicaciones a problemas cotidianos.",
    tags: ["Sucesiones", "Problemas de Finanzas", "3º ESO"],
    paginas: "10 págs",
    colorBadge: "bg-indigo-100 text-indigo-700 border-indigo-200",
    pdfUrl: "materiales/sucesiones-eso.html",
    ejerciciosUrl: "materiales/ejercicios-sucesiones-eso.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+progresiones+aritmeticas",
    formulasClave: ["a_n = a_1 + (n - 1)d", "S_n = \\frac{(a_1 + a_n)n}{2}", "S_\\infty = \\frac{a_1}{1 - r}"],
    puntosContenido: [
      "Cómo deducir el término general a partir de los primeros términos",
      "Interpolación de términos intermedios",
      "Aplicación real: interés simple e interés compuesto",
      "Test de autoevaluación con respuestas al final"
    ]
  },

  // ==========================================================================
  // MATEMÁTICAS - 1º Y 2º ESO
  // ==========================================================================
  {
    id: "ecu-01",
    asignatura: "matematicas",
    titulo: "Ecuaciones de 1º y 2º Grado y Sistemas Lineales",
    curso: "1-2-eso",
    cursoTexto: "1º, 2º y 3º ESO",
    categoria: "algebra",
    descripcion: "Eliminación de paréntesis y denominadores, fórmula cuadrática, ecuaciones incompletas y métodos de sustitución y reducción.",
    tags: ["Álgebra Básica", "Fichas de Práctica", "1º a 3º ESO"],
    paginas: "15 págs",
    colorBadge: "bg-orange-100 text-orange-700 border-orange-200",
    pdfUrl: "materiales/ecuaciones-1-2-eso.html",
    ejerciciosUrl: "materiales/ejercicios-ecuaciones-1-2-eso.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+ecuaciones+segundo+grado",
    formulasClave: ["x = \\frac{-b \\pm \\sqrt{b^2 - 4ac}}{2a}"],
    puntosContenido: [
      "Reglas de los signos y transposición de términos",
      "Ecuaciones con fracciones algebraicas y m.c.m.",
      "Resolución rápida de ecuaciones incompletas (sin fórmula larga)",
      "Problemas enunciados resueltos mediante planteamiento algebraico"
    ]
  },

  // ==========================================================================
  // FÍSICA - 2º BACHILLERATO / EvAU
  // ==========================================================================
  {
    id: "fis-grav-2b",
    asignatura: "fisica",
    titulo: "Campo Gravitatorio: Órbitas, Satélites y Velocidad de Escape",
    curso: "2-bach",
    cursoTexto: "2º Bachillerato Física EvAU",
    categoria: "geometria",
    descripcion: "Ley de Gravitación Universal, intensidad de campo vectorial g, potencial gravitatorio, energía mecánica orbital, satélites geoestacionarios y velocidad de escape.",
    tags: ["Física EvAU Cantabria", "Kepler & Órbitas", "Boletín 22 Ejercicios", "Paso a Paso"],
    paginas: "15 págs + Boletín",
    colorBadge: "bg-sky-100 text-sky-800 border-sky-200",
    pdfUrl: "materiales/campo-gravitatorio-2-bach.html",
    ejerciciosUrl: "materiales/ejercicios-campo-gravitatorio-2-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+campo+gravitatorio+fisica+evau",
    formulasClave: [
      "\\vec{g} = -G \\frac{M}{r^2} \\vec{u}_r",
      "v_{\\text{orb}} = \\sqrt{\\frac{GM}{r}}",
      "E_m = -\\frac{1}{2} G \\frac{Mm}{r}",
      "v_{\\text{esc}} = \\sqrt{\\frac{2GM}{r}}"
    ],
    puntosContenido: [
      "Cálculo de la gravedad a distintas altitudes y masa de planetas",
      "Mecánica orbital de satélites circulares y 3ª Ley de Kepler",
      "Energía de puesta en órbita y energía para cambio de órbita",
      "Boletín de 22 problemas reales EvAU con soluciones paso a paso desplegables"
    ]
  },
  {
    id: "fis-elec-2b",
    asignatura: "fisica",
    titulo: "Campo Eléctrico: Ley de Coulomb, Potencial y Trabajo Eléctrico",
    curso: "2-bach",
    cursoTexto: "2º Bachillerato Física EvAU",
    categoria: "geometria",
    descripcion: "Fuerza electrostática entre cargas puntuales, campo vectorial E, principio de superposición, potencial electrostático V y aceleración de partículas cargadas.",
    tags: ["Física EvAU", "Ley de Coulomb", "Conservativo"],
    paginas: "16 págs",
    colorBadge: "bg-sky-100 text-sky-800 border-sky-200",
    pdfUrl: "materiales/campo-electrico-2-bach.html",
    ejerciciosUrl: "materiales/ejercicios-campo-electrico-2-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+campo+electrico+evau",
    formulasClave: [
      "\\vec{F} = K \\frac{q_1 q_2}{r^2} \\vec{u}_r",
      "V = K \\frac{Q}{r}",
      "W_{A \\to B} = q (V_A - V_B)"
    ],
    puntosContenido: [
      "Superposición vectorial del campo creado por varias cargas",
      "Superficies equipotenciales y relación con las líneas de campo",
      "Conservación de energía mecánica para electrones y protones en campos uniformes",
      "Problemas típicos de examen de Selectividad"
    ]
  },
  {
    id: "fis-mag-2b",
    asignatura: "fisica",
    titulo: "Campo Magnético e Inducción: Fuerza de Lorentz y Ley de Faraday",
    curso: "2-bach",
    cursoTexto: "2º Bachillerato Física EvAU",
    categoria: "geometria",
    descripcion: "Fuerza de Lorentz sobre cargas en movimiento y conductores rectilíneos, radio de la trayectoria helicoidal, flujo magnético y fem inducida según Faraday-Lenz.",
    tags: ["Física EvAU", "Lorentz", "Faraday-Lenz"],
    paginas: "18 págs",
    colorBadge: "bg-sky-100 text-sky-800 border-sky-200",
    pdfUrl: "materiales/campo-magnetico-2-bach.html",
    ejerciciosUrl: "materiales/ejercicios-campo-magnetico-2-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+campo+magnetico+induccion",
    formulasClave: [
      "\\vec{F} = q (\\vec{v} \\times \\vec{B})",
      "R = \\frac{m v}{q B}",
      "\\varepsilon = -\\frac{d\\Phi}{dt}"
    ],
    puntosContenido: [
      "Regla de la mano derecha para producto vectorial",
      "Campo creado por hilos rectilíneos infinitos (Biot-Savart)",
      "Cálculo de corrientes inducidas y sentido según la Ley de Lenz",
      "Generadores de corriente alterna (espira en rotación)"
    ]
  },
  {
    id: "fis-ondas-2b",
    asignatura: "fisica",
    titulo: "Movimiento Ondulatorio, Óptica Geométrica y Física Cuántica",
    curso: "2-bach",
    cursoTexto: "2º Bachillerato Física EvAU",
    categoria: "analisis",
    descripcion: "Ecuación de onda armónica y doble periodicidad, intensidad sonora en decibelios, refracción de Snell, lentes delgadas y efecto fotoeléctrico de Einstein.",
    tags: ["Física EvAU", "Ondas & Sonido", "Fotoeléctrico"],
    paginas: "18 págs",
    colorBadge: "bg-cyan-100 text-cyan-800 border-cyan-200",
    pdfUrl: "materiales/ondas-optica-moderna-2-bach.html",
    ejerciciosUrl: "materiales/ejercicios-ondas-optica-moderna-2-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+ondas+optica+fisica+moderna",
    formulasClave: [
      "y(x, t) = A \\sin(\\omega t - kx)",
      "\\beta = 10 \\log(I / I_0)",
      "h\\nu = W_0 + E_c"
    ],
    puntosContenido: [
      "Ecuación y características de ondas transversales y longitudinales",
      "Leyes de Snell y ángulo límite de reflexión total en fibra óptica",
      "Formación de imágenes en lentes convergentes y divergentes",
      "Efecto fotoeléctrico, energía umbral y longitud de onda de De Broglie"
    ]
  },

  // ==========================================================================
  // FÍSICA - 1º BACHILLERATO Y ESO
  // ==========================================================================
  {
    id: "fis-cin-1b",
    asignatura: "fisica",
    titulo: "1º Bach Física: Cinemática Vectorial, Tiro Parabólico y MCU",
    curso: "1-bach",
    cursoTexto: "1º Bachillerato Física y Química",
    categoria: "analisis",
    descripcion: "Vector de posición, velocidad y componentes intrínsecas de la aceleración (tangencial y normal). Composición de movimientos: tiro horizontal y parabólico.",
    tags: ["Cinemática R²", "Tiro Parabólico", "Boletín 22 Ejercicios", "1º Bach"],
    paginas: "16 págs + Boletín",
    colorBadge: "bg-blue-100 text-blue-800 border-blue-200",
    pdfUrl: "materiales/cinematica-vectorial-1-bach.html",
    ejerciciosUrl: "materiales/ejercicios-cinematica-vectorial-1-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+cinematica+tiro+parabolico+1+bach",
    formulasClave: [
      "\\vec{r}(t) = x(t)\\vec{i} + y(t)\\vec{j}",
      "a_n = \\frac{v^2}{R}",
      "y = y_0 + v_{0y}t - \\frac{1}{2}gt^2"
    ],
    puntosContenido: [
      "Diferencia entre trayectoria, espacio recorrido y vector desplazamiento",
      "Aceleración tangencial (cambio de módulo) y aceleración normal (cambio de dirección)",
      "Alcance máximo y altura máxima en proyectiles",
      "Boletín de 22 ejercicios graduados con soluciones paso a paso desplegables"
    ]
  },
  {
    id: "fis-din-1b",
    asignatura: "fisica",
    titulo: "1º Bach Física: Dinámica de Newton, Fuerzas y Conservación",
    curso: "1-bach",
    cursoTexto: "1º Bachillerato Física y Química",
    categoria: "geometria",
    descripcion: "Leyes de Newton aplicadas a planos inclinados, poleas y cuerdas, fuerza de rozamiento estático/dinámico, dinámica del movimiento circular y cantidad de movimiento.",
    tags: ["Leyes de Newton", "Rozamiento", "Boletín 22 Ejercicios", "Poleas"],
    paginas: "17 págs + Boletín",
    colorBadge: "bg-blue-100 text-blue-800 border-blue-200",
    pdfUrl: "materiales/dinamica-newton-1-bach.html",
    ejerciciosUrl: "materiales/ejercicios-dinamica-newton-1-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+dinamica+newton+1+bach",
    formulasClave: [
      "\\sum \\vec{F} = m \\vec{a}",
      "F_r = \\mu N",
      "\\vec{p} = m \\vec{v}"
    ],
    puntosContenido: [
      "Diagramas de cuerpo libre sin olvidar ninguna fuerza",
      "Descomposición de fuerzas en planos inclinados (ejes paralelo y normal)",
      "Fuerza centrípeta en curvas y peraltes de carreteras",
      "Boletín de 22 ejercicios con soluciones completas paso a paso desplegables"
    ]
  },
  {
    id: "eso-fis-mov",
    asignatura: "fisica",
    titulo: "3º y 4º ESO: Cinemática Básica (MRU y MRUA) y Leyes de Newton",
    curso: "3-4-eso",
    cursoTexto: "3º y 4º ESO Física y Química",
    categoria: "analisis",
    descripcion: "Velocidad constante y acelerada, gráficas de movimiento, caída libre, concepto de fuerza, Ley de Hooke en muelles y principio fundamental F = m·a.",
    tags: ["Física ESO", "MRU & MRUA", "Boletín 22 Ejercicios", "Fuerzas"],
    paginas: "14 págs + Boletín",
    colorBadge: "bg-sky-100 text-sky-800 border-sky-200",
    pdfUrl: "materiales/fuerzas-movimiento-eso.html",
    ejerciciosUrl: "materiales/ejercicios-fuerzas-movimiento-eso.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+cinematica+fuerzas+eso",
    formulasClave: [
      "s = s_0 + v \\cdot t",
      "v = v_0 + a \\cdot t",
      "F = k \\cdot \\Delta x"
    ],
    puntosContenido: [
      "Interpretación de gráficas posición-tiempo y velocidad-tiempo",
      "Resolución de problemas de encuentro entre dos móviles",
      "Ecuaciones de caída libre y lanzamiento vertical hacia arriba",
      "Boletín de 22 ejercicios graduados con soluciones paso a paso desplegables"
    ]
  },

  // ==========================================================================
  // QUÍMICA - 2º BACHILLERATO / EvAU
  // ==========================================================================
  {
    id: "qui-acidos-2b",
    asignatura: "quimica",
    titulo: "Reacciones Ácido-Base: pH, Hidrólisis de Sales y Valoraciones",
    curso: "2-bach",
    cursoTexto: "2º Bachillerato Química EvAU",
    categoria: "analisis",
    descripcion: "Teoría de Brönsted-Lowry, cálculo riguroso de pH y pOH en ácidos y bases fuertes y débiles, grado de disociación, hidrólisis de sales, tampones y volumetrías.",
    tags: ["Química EvAU Cantabria", "pH & Hidrólisis", "Boletín 22 Ejercicios", "Paso a Paso"],
    paginas: "16 págs + Boletín",
    colorBadge: "bg-emerald-100 text-emerald-800 border-emerald-200",
    pdfUrl: "materiales/reacciones-acido-base-2-bach.html",
    ejerciciosUrl: "materiales/ejercicios-reacciones-acido-base-2-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+acido+base+ph+quimica+evau",
    formulasClave: [
      "\\text{pH} = -\\log[\\text{H}_3\\text{O}^+]",
      "K_a \\cdot K_b = 10^{-14}",
      "M_A \\cdot V_A = M_B \\cdot V_B"
    ],
    puntosContenido: [
      "Definición de pares ácido-base conjugados y producto iónico del agua",
      "Cálculo de concentraciones en equilibrios iónicos con aproximación de Ostwald",
      "Predicción cualitativa y cuantitativa del pH en hidrólisis de sales",
      "Boletín con 22 problemas reales EvAU con soluciones paso a paso desplegables"
    ]
  },
  {
    id: "qui-termo-2b",
    asignatura: "quimica",
    titulo: "Termoquímica y Espontaneidad: Ley de Hess y Energía Libre de Gibbs",
    curso: "2-bach",
    cursoTexto: "2º Bachillerato Química EvAU",
    categoria: "analisis",
    descripcion: "Entalpías de formación y combustión, cálculo de entalpía de reacción por la Ley de Hess y por energías de enlace, entropía y criterio de espontaneidad ΔG = ΔH - TΔS.",
    tags: ["Química EvAU", "Termodinámica", "Boletín 22 Ejercicios", "Ley de Hess"],
    paginas: "15 págs + Boletín",
    colorBadge: "bg-emerald-100 text-emerald-800 border-emerald-200",
    pdfUrl: "materiales/termoquimica-2-bach.html",
    ejerciciosUrl: "materiales/ejercicios-termoquimica-2-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+termoquimica+ley+hess+evau",
    formulasClave: [
      "\\Delta H_r^\\circ = \\sum n\\Delta H_f^\\circ(\\text{prod}) - \\sum m\\Delta H_f^\\circ(\\text{react})",
      "\\Delta G^\\circ = \\Delta H^\\circ - T\\Delta S^\\circ"
    ],
    puntosContenido: [
      "Reacciones exotérmicas frente a endotérmicas y diagramas entálpicos",
      "Combinación de ecuaciones termoquímicas según la Ley de Hess",
      "Cálculo de la temperatura de equilibrio en cambios de estado o reversibilidad",
      "Boletín de 22 ejercicios graduados con soluciones paso a paso desplegables"
    ]
  },
  {
    id: "qui-equil-2b",
    asignatura: "quimica",
    titulo: "Equilibrio Químico: Constantes Kc y Kp y Principio de Le Châtelier",
    curso: "2-bach",
    cursoTexto: "2º Bachillerato Química EvAU",
    categoria: "analisis",
    descripcion: "Cociente de reacción Q, constantes Kc y Kp, relación Kp = Kc(RT)^Δn, grado de disociación α, solubilidad Kps y desplazamientos del equilibrio según Le Châtelier.",
    tags: ["Química EvAU", "Equilibrio", "Boletín 22 Ejercicios", "Le Châtelier"],
    paginas: "16 págs + Boletín",
    colorBadge: "bg-emerald-100 text-emerald-800 border-emerald-200",
    pdfUrl: "materiales/equilibrio-quimico-2-bach.html",
    ejerciciosUrl: "materiales/ejercicios-equilibrio-quimico-2-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+equilibrio+quimico+le+chatelier",
    formulasClave: [
      "K_p = K_c (R T)^{\\Delta n}",
      "K_{ps} = [\\text{A}^{m+}]^n [\\text{B}^{n-}]^m"
    ],
    puntosContenido: [
      "Tabla de concentraciones iniciales, cambio y equilibrio",
      "Efecto de la presión, volumen, temperatura y adición de reactivos/productos",
      "Cálculo de solubilidad y efecto del ion común en precipitaciones",
      "Boletín de 22 ejercicios graduados con soluciones paso a paso desplegables"
    ]
  },
  {
    id: "qui-redox-2b",
    asignatura: "quimica",
    titulo: "Reacciones Redox: Ajuste Ion-Electrón, Pilas Galvánicas y Faraday",
    curso: "2-bach",
    cursoTexto: "2º Bachillerato Química EvAU",
    categoria: "algebra",
    descripcion: "Números de oxidación, método del ion-electrón en medio ácido y básico, potenciales estándar E°, cálculo de fem de pilas Daniell y leyes de electrólisis de Faraday.",
    tags: ["Química EvAU", "Redox", "Boletín 22 Ejercicios", "Pilas Galvánicas"],
    paginas: "17 págs + Boletín",
    colorBadge: "bg-emerald-100 text-emerald-800 border-emerald-200",
    pdfUrl: "materiales/reacciones-redox-2-bach.html",
    ejerciciosUrl: "materiales/ejercicios-reacciones-redox-2-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+redox+ion+electron+pilas+evau",
    formulasClave: [
      "E^\\circ_{\\text{pila}} = E^\\circ_{\\text{cátodo}} - E^\\circ_{\\text{ánodo}}",
      "m = \\frac{M \\cdot I \\cdot t}{n \\cdot F}"
    ],
    puntosContenido: [
      "Paso a paso infalible para el ajuste de semirreacciones en medio ácido y básico",
      "Identificación de oxidante (gana e-) y reductor (pierde e-)",
      "Espontaneidad de procesos redox (E° > 0)",
      "Boletín de 22 ejercicios graduados con soluciones paso a paso desplegables"
    ]
  },
  {
    id: "qui-org-2b",
    asignatura: "quimica",
    titulo: "Química del Carbono: Isomería y Principales Reacciones Orgánicas",
    curso: "2-bach",
    cursoTexto: "2º Bachillerato Química EvAU",
    categoria: "geometria",
    descripcion: "Isomería estructural (cadena, posición, función) y estereoisomería (geométrica cis/trans y óptica R/S con carbonos asimétricos). Reacciones de sustitución, adición (Markovnikov), eliminación (Saytzeff) y esterificación.",
    tags: ["Química Orgánica", "Isomería", "Boletín 22 Ejercicios", "Markovnikov"],
    paginas: "18 págs + Boletín",
    colorBadge: "bg-teal-100 text-teal-800 border-teal-200",
    pdfUrl: "materiales/quimica-organica-2-bach.html",
    ejerciciosUrl: "materiales/ejercicios-quimica-organica-2-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+quimica+organica+isomeria+reacciones",
    formulasClave: [
      "\\text{Regla de Markovnikov: el H va al carbono más hidrogenado}",
      "\\text{Regla de Saytzeff: se elimina el H del carbono menos hidrogenado}"
    ],
    puntosContenido: [
      "Reconocimiento de centros quirales y quiralidad óptica",
      "Reacciones de adición a dobles y triples enlaces (haluros de hidrógeno y agua)",
      "Reacciones de condensación: esterificación (ácido + alcohol) y formación de amidas",
      "Boletín de 22 ejercicios graduados con soluciones paso a paso desplegables"
    ]
  },

  // ==========================================================================
  // QUÍMICA - 1º BACHILLERATO Y ESO
  // ==========================================================================
  {
    id: "qui-esteq-1b",
    asignatura: "quimica",
    titulo: "1º Bach Química: Estequiometría, Reactivo Limitante y Disoluciones",
    curso: "1-bach",
    cursoTexto: "1º Bachillerato Física y Química",
    categoria: "analisis",
    descripcion: "Leyes ponderales, concepto de mol y masa molar, expresiones de concentración (M, m, % en masa, fracción molar), reactivo limitante, pureza de reactivos y rendimiento de reacción.",
    tags: ["Estequiometría", "Reactivo Limitante", "Boletín 22 Ejercicios", "Disoluciones"],
    paginas: "16 págs + Boletín",
    colorBadge: "bg-emerald-100 text-emerald-800 border-emerald-200",
    pdfUrl: "materiales/estequiometria-disoluciones-1-bach.html",
    ejerciciosUrl: "materiales/ejercicios-estequiometria-disoluciones-1-bach.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+estequiometria+reactivo+limitante+1+bach",
    formulasClave: [
      "n = \\frac{m}{M}",
      "M = \\frac{n_{\\text{soluto}}}{V_{\\text{disolución (L)}}}",
      "P \\cdot V = n \\cdot R \\cdot T"
    ],
    puntosContenido: [
      "Identificación sistemática del reactivo limitante por cociente estequiométrico",
      "Cálculo con reactivos impuros y rendimientos inferiores al 100%",
      "Gases ideales y presiones parciales de mezclas gaseosas (Dalton)",
      "Boletín de 22 ejercicios graduados con soluciones paso a paso desplegables"
    ]
  },
  {
    id: "qui-form-1b",
    asignatura: "quimica",
    titulo: "Formulación y Nomenclatura IUPAC: Inorgánica y Orgánica Completa",
    curso: "1-bach",
    cursoTexto: "3º ESO a 2º Bachillerato",
    categoria: "algebra",
    descripcion: "Normas IUPAC actualizadas. Óxidos, hidruros, sales binarias, oxácidos y oxisales. Hidrocarburos, derivados halogenados, oxigenados (alcoholes, aldehídos, cetonas, ácidos) y nitrogenados.",
    tags: ["Formulación Oficial", "IUPAC", "Boletín 22 Ejercicios", "Chuleta Imprescindible"],
    paginas: "20 págs + Boletín",
    colorBadge: "bg-teal-100 text-teal-800 border-teal-200",
    pdfUrl: "materiales/formulacion-nomenclatura.html",
    ejerciciosUrl: "materiales/ejercicios-formulacion-nomenclatura.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+formulacion+inorganica+organica+iupac",
    formulasClave: ["\\text{Nomenclatura sistemática, de composición y tradicional IUPAC}"],
    puntosContenido: [
      "Tabla periódica de números de oxidación más habituales",
      "Guía rápida de prefijos multiplicadores (mono, di, tri, tetra...)",
      "Reglas de prioridad entre grupos funcionales orgánicos",
      "Boletín de 22 ejercicios graduados con soluciones paso a paso desplegables"
    ]
  },
  {
    id: "eso-qui-atomo",
    asignatura: "quimica",
    titulo: "3º y 4º ESO: El Átomo, la Tabla Periódica y el Enlace Químico",
    curso: "3-4-eso",
    cursoTexto: "3º y 4º ESO Física y Química",
    categoria: "geometria",
    descripcion: "Modelos atómicos (Thomson, Rutherford, Bohr), partículas subatómicas (Z, A, isótopos), configuración electrónica, tabla periódica y tipos de enlace (iónico, covalente y metálico).",
    tags: ["Química ESO", "Configuración Electrónica", "Boletín 22 Ejercicios", "Enlace"],
    paginas: "15 págs + Boletín",
    colorBadge: "bg-emerald-100 text-emerald-800 border-emerald-200",
    pdfUrl: "materiales/atomo-enlace-eso.html",
    ejerciciosUrl: "materiales/ejercicios-atomo-enlace-eso.html",
    videoUrl: "https://www.youtube.com/results?search_query=toomates+atomo+enlace+quimico+eso",
    formulasClave: [
      "A = Z + N",
      "1s^2 \\, 2s^2 \\, 2p^6 \\, 3s^2 \\dots"
    ],
    puntosContenido: [
      "Diagrama de Moeller para configuraciones electrónicas",
      "Electrones de valencia y regla del octeto",
      "Diferencias de propiedades macroscópicas según el tipo de enlace",
      "Boletín de 22 ejercicios graduados con soluciones paso a paso desplegables"
    ]
  }

];
