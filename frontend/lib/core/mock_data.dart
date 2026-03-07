import 'package:flutter/material.dart';
import 'theme.dart';

// ─── Models ──────────────────────────────────────────────────────────────────

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class Lesson {
  final String id;
  final String title;
  final String subtitle;
  final String content;
  final String emoji;
  final int xpReward;
  final int durationMinutes;
  final List<QuizQuestion> quiz;
  bool isCompleted;
  bool isLocked;

  Lesson({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.emoji,
    required this.xpReward,
    required this.durationMinutes,
    required this.quiz,
    this.isCompleted = false,
    this.isLocked = false,
  });
}

class LearningPath {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final LinearGradient gradient;
  final List<Lesson> lessons;
  bool isLocked;

  LearningPath({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.gradient,
    required this.lessons,
    this.isLocked = false,
  });

  double get progress {
    if (lessons.isEmpty) return 0;
    final completed = lessons.where((l) => l.isCompleted).length;
    return completed / lessons.length;
  }

  int get totalXP => lessons.fold(0, (sum, l) => sum + l.xpReward);
  int get earnedXP => lessons.where((l) => l.isCompleted).fold(0, (sum, l) => sum + l.xpReward);
}

class Transaction {
  final String id;
  final String title;
  final double amount;
  final bool isIncome;
  final String category;
  final String categoryEmoji;
  final DateTime date;

  const Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.isIncome,
    required this.category,
    required this.categoryEmoji,
    required this.date,
  });
}

class SavingsGoal {
  final String id;
  final String title;
  final double targetAmount;
  double currentAmount;
  final DateTime deadline;
  final Color color;
  final String emoji;

  SavingsGoal({
    required this.id,
    required this.title,
    required this.targetAmount,
    required this.currentAmount,
    required this.deadline,
    required this.color,
    required this.emoji,
  });

  double get progress => (currentAmount / targetAmount).clamp(0.0, 1.0);
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final Color color;
  bool isUnlocked;
  final DateTime? unlockedAt;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.color,
    this.isUnlocked = false,
    this.unlockedAt,
  });
}

class TaxArticle {
  final String id;
  final String title;
  final String subtitle;
  final String emoji;
  final String readTime;
  final List<TaxSection> sections;
  final Color color;

  const TaxArticle({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.readTime,
    required this.sections,
    required this.color,
  });
}

class TaxSection {
  final String title;
  final String content;

  const TaxSection({required this.title, required this.content});
}

class ExpenseCategory {
  final String name;
  final String emoji;
  final Color color;

  const ExpenseCategory({
    required this.name,
    required this.emoji,
    required this.color,
  });
}

// ─── Mock Data ────────────────────────────────────────────────────────────────

class MockData {
  // User info
  static const String userName = 'Carlos';
  static const String userEmail = 'carlos@email.com';
  static const int userXP = 340;
  static const int userStreak = 5;
  static const int userLevel = 3;

  // Expense categories
  static const List<ExpenseCategory> categories = [
    ExpenseCategory(name: 'Comida', emoji: '🍔', color: AppColors.orange),
    ExpenseCategory(name: 'Transporte', emoji: '🚌', color: AppColors.cyan),
    ExpenseCategory(name: 'Entretenimiento', emoji: '🎮', color: AppColors.purple),
    ExpenseCategory(name: 'Estudios', emoji: '📚', color: AppColors.green),
    ExpenseCategory(name: 'Salud', emoji: '🏥', color: AppColors.red),
    ExpenseCategory(name: 'Hogar', emoji: '🏠', color: AppColors.amber),
    ExpenseCategory(name: 'Otros', emoji: '📦', color: AppColors.gray400),
  ];

  // Learning paths
  static List<LearningPath> learningPaths = [
    LearningPath(
      id: 'path_1',
      title: 'Fundamentos Financieros',
      description: 'Aprende los conceptos esenciales para manejar tu dinero',
      emoji: '💡',
      gradient: AppGradients.navyGradient,
      lessons: [
        Lesson(
          id: 'l1_1',
          title: '¿Qué es ahorrar?',
          subtitle: 'El primer paso hacia la libertad financiera',
          emoji: '🐷',
          xpReward: 50,
          durationMinutes: 5,
          isCompleted: true,
          content: '''Ahorrar es guardar una parte de tus ingresos para usarla en el futuro. Parece simple, pero es uno de los hábitos más poderosos que puedes desarrollar.

**¿Por qué ahorrar?**
• Tener un colchón para emergencias
• Lograr metas financieras (viajes, estudios, negocio)
• Reducir el estrés financiero
• Ganar independencia y libertad

**La regla del 10%**
Un punto de partida clásico es ahorrar al menos el 10% de tus ingresos. Si ganas S/. 1,000 al mes, guarda S/. 100 desde el primer día que recibas tu pago.

**Consejos prácticos:**
1. Págate a ti mismo primero — ahorra antes de gastar
2. Abre una cuenta separada solo para ahorros
3. Automatiza tus ahorros si puedes
4. Empieza con poco, lo importante es el hábito''',
          quiz: [
            QuizQuestion(
              question: '¿Cuál es el primer principio del ahorro inteligente?',
              options: [
                'Ahorrar lo que sobre al final del mes',
                'Págate a ti mismo primero',
                'Evitar toda deuda',
                'Invertir antes de ahorrar',
              ],
              correctIndex: 1,
              explanation: 'La clave es separar tus ahorros apenas recibes ingresos, antes de gastar en cualquier otra cosa.',
            ),
            QuizQuestion(
              question: '¿Qué porcentaje de los ingresos se recomienda ahorrar como punto de partida?',
              options: ['5%', '10%', '25%', '50%'],
              correctIndex: 1,
              explanation: 'El 10% es un punto de partida clásico y alcanzable para la mayoría de personas.',
            ),
            QuizQuestion(
              question: 'Si ganas S/. 1,500 al mes, ¿cuánto deberías ahorrar con la regla del 10%?',
              options: ['S/. 50', 'S/. 100', 'S/. 150', 'S/. 200'],
              correctIndex: 2,
              explanation: '10% de S/. 1,500 = S/. 150. Simple y consistente.',
            ),
          ],
        ),
        Lesson(
          id: 'l1_2',
          title: 'Ahorrar vs Invertir',
          subtitle: '¿Cuál es la diferencia y cuándo usarlos?',
          emoji: '📈',
          xpReward: 60,
          durationMinutes: 6,
          isCompleted: true,
          content: '''Ahorrar e invertir son conceptos distintos que se complementan. Entender la diferencia es clave para hacer crecer tu dinero.

**Ahorrar:**
• Guardar dinero en un lugar seguro (cuenta bancaria, alcancía)
• Bajo riesgo, baja rentabilidad
• Ideal para: fondo de emergencia, metas a corto plazo
• Ejemplo: S/. 1,000 en cuenta de ahorros → S/. 1,040 en un año (4% anual)

**Invertir:**
• Poner tu dinero a trabajar para generar más dinero
• Mayor riesgo, mayor rentabilidad potencial
• Ideal para: metas a largo plazo, construir riqueza
• Ejemplo: S/. 1,000 en fondos → potencialmente S/. 1,100-1,200 en un año

**¿Cuándo ahorrar y cuándo invertir?**
Primero ahorra tu fondo de emergencia (3-6 meses de gastos). Luego considera invertir el excedente.''',
          quiz: [
            QuizQuestion(
              question: '¿Cuál tiene mayor riesgo pero mayor potencial de ganancia?',
              options: ['Ahorrar en banco', 'Invertir', 'Guardar efectivo', 'Ninguno'],
              correctIndex: 1,
              explanation: 'Invertir conlleva más riesgo pero también mayor potencial de rendimiento a largo plazo.',
            ),
            QuizQuestion(
              question: '¿Qué debes construir ANTES de empezar a invertir?',
              options: [
                'Un portafolio de acciones',
                'Una cuenta premium',
                'Un fondo de emergencia',
                'Una deuda estratégica',
              ],
              correctIndex: 2,
              explanation: 'El fondo de emergencia es tu red de seguridad. Sin él, cualquier imprevisto puede obligarte a vender inversiones en mal momento.',
            ),
          ],
        ),
        Lesson(
          id: 'l1_3',
          title: 'El Presupuesto Personal',
          subtitle: 'La regla 50/30/20 que cambia vidas',
          emoji: '📊',
          xpReward: 70,
          durationMinutes: 7,
          isCompleted: false,
          content: '''Un presupuesto es simplemente un plan para tu dinero. La regla 50/30/20 es una de las más populares y fáciles de aplicar.

**La Regla 50/30/20:**
• 50% — Necesidades (vivienda, comida, transporte, servicios)
• 30% — Deseos (entretenimiento, ropa, restaurantes)
• 20% — Ahorros e inversión

**Ejemplo práctico (S/. 1,500/mes):**
• S/. 750 → Necesidades
• S/. 450 → Deseos
• S/. 300 → Ahorro/inversión

**Pasos para crear tu presupuesto:**
1. Calcula tus ingresos totales
2. Registra todos tus gastos del último mes
3. Clasifica cada gasto en necesidad o deseo
4. Compara con la regla 50/30/20
5. Ajusta donde sea necesario''',
          quiz: [
            QuizQuestion(
              question: 'Según la regla 50/30/20, ¿qué porcentaje va a ahorros e inversión?',
              options: ['10%', '20%', '30%', '50%'],
              correctIndex: 1,
              explanation: 'El 20% se destina a ahorros e inversión. Es la base para construir riqueza a largo plazo.',
            ),
            QuizQuestion(
              question: 'Si ganas S/. 2,000, ¿cuánto debería ir a "deseos" según la regla 50/30/20?',
              options: ['S/. 400', 'S/. 500', 'S/. 600', 'S/. 1,000'],
              correctIndex: 2,
              explanation: '30% de S/. 2,000 = S/. 600 para deseos o entretenimiento.',
            ),
          ],
        ),
        Lesson(
          id: 'l1_4',
          title: 'Fondo de Emergencia',
          subtitle: 'Tu red de seguridad financiera',
          emoji: '🛡️',
          xpReward: 60,
          durationMinutes: 5,
          isCompleted: false,
          content: '''Un fondo de emergencia es dinero guardado específicamente para imprevistos. Es el pilar más importante de tu salud financiera.

**¿Cuánto necesitas?**
La recomendación estándar es entre 3 y 6 meses de tus gastos mensuales.

Si gastas S/. 1,200 al mes:
• Mínimo: S/. 3,600 (3 meses)
• Ideal: S/. 7,200 (6 meses)

**¿Para qué sirve?**
• Perder el trabajo inesperadamente
• Emergencia médica o familiar
• Reparación urgente del auto o casa
• Cualquier imprevisto que requiera dinero rápido

**¿Dónde guardarlo?**
En una cuenta de ahorros separada, accesible pero no tan fácil como para gastarla en antojos.''',
          quiz: [
            QuizQuestion(
              question: '¿Cuántos meses de gastos debe cubrir idealmente un fondo de emergencia?',
              options: ['1-2 meses', '3-6 meses', '8-12 meses', '24 meses'],
              correctIndex: 1,
              explanation: 'Entre 3 y 6 meses es el rango recomendado. Suficiente para cubrir emergencias sin inmovilizar demasiado capital.',
            ),
            QuizQuestion(
              question: '¿Dónde es más recomendable guardar el fondo de emergencia?',
              options: [
                'Invertido en bolsa',
                'En efectivo en casa',
                'Cuenta de ahorros separada',
                'Prestado a amigos',
              ],
              correctIndex: 2,
              explanation: 'Una cuenta separada es accesible en emergencias pero no tan inmediata como para gastarlo en cosas no urgentes.',
            ),
          ],
        ),
        Lesson(
          id: 'l1_5',
          title: 'Interés Compuesto',
          subtitle: 'La octava maravilla del mundo',
          emoji: '🚀',
          xpReward: 80,
          durationMinutes: 8,
          isCompleted: false,
          content: '''Albert Einstein supuestamente dijo que el interés compuesto es "la octava maravilla del mundo". ¿Por qué?

**Interés Simple vs Compuesto:**
• Simple: solo ganas interés sobre el capital original
• Compuesto: ganas interés sobre el capital MÁS los intereses acumulados

**Ejemplo visual:**
Inviertes S/. 1,000 al 10% anual:

| Año | Interés Simple | Interés Compuesto |
|-----|----------------|-------------------|
| 1   | S/. 1,100      | S/. 1,100         |
| 5   | S/. 1,500      | S/. 1,611         |
| 10  | S/. 2,000      | S/. 2,594         |
| 20  | S/. 3,000      | S/. 6,727         |

**La regla del 72:**
Divide 72 entre la tasa de interés para saber en cuántos años tu dinero se duplica.
• 72 ÷ 10% = 7.2 años para duplicarse''',
          quiz: [
            QuizQuestion(
              question: '¿Qué hace especial al interés compuesto?',
              options: [
                'Ofrece tasas más altas que el interés simple',
                'Genera interés sobre el capital y los intereses acumulados',
                'No tiene riesgo',
                'Solo aplica para inversiones grandes',
              ],
              correctIndex: 1,
              explanation: 'El interés compuesto genera rendimiento sobre el capital original Y sobre los intereses ya ganados, creando un efecto de "bola de nieve".',
            ),
            QuizQuestion(
              question: 'Con la Regla del 72, si tu inversión rinde 8% anual, ¿en cuántos años se duplica?',
              options: ['6 años', '9 años', '12 años', '15 años'],
              correctIndex: 1,
              explanation: '72 ÷ 8 = 9 años. La regla del 72 es una estimación rápida y muy útil.',
            ),
          ],
        ),
      ],
    ),

    LearningPath(
      id: 'path_2',
      title: 'Deuda e Inversión',
      description: 'Aprende a usar la deuda a tu favor y a invertir inteligentemente',
      emoji: '💳',
      gradient: AppGradients.purpleGradient,
      isLocked: true,
      lessons: [
        Lesson(
          id: 'l2_1',
          title: 'Deuda Buena vs Mala',
          subtitle: 'No toda deuda es tu enemiga',
          emoji: '⚖️',
          xpReward: 70,
          durationMinutes: 7,
          isLocked: true,
          content: 'Contenido de lección sobre deuda buena vs mala...',
          quiz: [],
        ),
        Lesson(
          id: 'l2_2',
          title: 'Tarjetas de Crédito',
          subtitle: 'Úsalas a tu favor, no en tu contra',
          emoji: '💳',
          xpReward: 70,
          durationMinutes: 6,
          isLocked: true,
          content: 'Contenido sobre uso inteligente de tarjetas de crédito...',
          quiz: [],
        ),
        Lesson(
          id: 'l2_3',
          title: 'Riesgo y Diversificación',
          subtitle: 'No pongas todos los huevos en una canasta',
          emoji: '🥚',
          xpReward: 80,
          durationMinutes: 8,
          isLocked: true,
          content: 'Contenido sobre riesgo y diversificación...',
          quiz: [],
        ),
      ],
    ),

    LearningPath(
      id: 'path_3',
      title: 'Emprendimiento Financiero',
      description: 'Conceptos clave para emprender con inteligencia',
      emoji: '🏆',
      gradient: AppGradients.greenGradient,
      isLocked: true,
      lessons: [
        Lesson(
          id: 'l3_1',
          title: 'Básicos de Emprendimiento',
          subtitle: 'Qué necesitas saber antes de empezar',
          emoji: '💼',
          xpReward: 80,
          durationMinutes: 8,
          isLocked: true,
          content: 'Contenido sobre emprendimiento...',
          quiz: [],
        ),
        Lesson(
          id: 'l3_2',
          title: 'Formalizar tu Negocio',
          subtitle: 'Registrar y operar legalmente en Perú',
          emoji: '📋',
          xpReward: 90,
          durationMinutes: 10,
          isLocked: true,
          content: 'Contenido sobre formalización de negocios...',
          quiz: [],
        ),
      ],
    ),
  ];

  // Tax articles
  static const List<TaxArticle> taxArticles = [
    TaxArticle(
      id: 'tax_1',
      title: '¿Qué es SUNAT?',
      subtitle: 'La entidad que recauda impuestos en Perú',
      emoji: '🏛️',
      readTime: '3 min',
      color: AppColors.navy500,
      sections: [
        TaxSection(
          title: '¿Qué es?',
          content: 'SUNAT (Superintendencia Nacional de Aduanas y de Administración Tributaria) es el organismo del Estado Peruano encargado de administrar, fiscalizar y recaudar los tributos internos del gobierno nacional.',
        ),
        TaxSection(
          title: '¿Qué hace SUNAT?',
          content: '• Recauda impuestos como el IGV e Impuesto a la Renta\n• Controla el cumplimiento de obligaciones tributarias\n• Facilita el comercio exterior\n• Orienta a los contribuyentes sobre sus obligaciones\n• Sanciona a quienes evaden impuestos',
        ),
        TaxSection(
          title: '¿Por qué te importa?',
          content: 'Si generas ingresos en Perú — sea como dependiente, independiente o empresario — tienes obligaciones con SUNAT. Conocerlas te evita multas, problemas legales y te permite aprovechar beneficios tributarios.',
        ),
      ],
    ),
    TaxArticle(
      id: 'tax_2',
      title: '¿Qué es el RUC?',
      subtitle: 'Tu identidad tributaria en Perú',
      emoji: '🪪',
      readTime: '4 min',
      color: AppColors.cyan,
      sections: [
        TaxSection(
          title: '¿Qué es el RUC?',
          content: 'El RUC (Registro Único de Contribuyentes) es un número de identificación de 11 dígitos que te asigna SUNAT cuando te registras como contribuyente. Es como tu DNI, pero para temas tributarios.',
        ),
        TaxSection(
          title: '¿Quién necesita RUC?',
          content: '• Personas que realizan actividades económicas de forma independiente\n• Empresas y negocios de cualquier tamaño\n• Personas que alquilan propiedades\n• Profesionales freelance (contadores, diseñadores, desarrolladores, etc.)',
        ),
        TaxSection(
          title: '¿Cómo obtenerlo?',
          content: 'Puedes tramitarlo:\n• En la web de SUNAT (sunat.gob.pe)\n• En cualquier oficina de SUNAT a nivel nacional\n• Con tu DNI y datos básicos del negocio o actividad',
        ),
        TaxSection(
          title: 'Tip importante',
          content: 'Tener RUC activo te permite emitir comprobantes de pago, lo que muchos clientes formales requieren para hacer negocios contigo.',
        ),
      ],
    ),
    TaxArticle(
      id: 'tax_3',
      title: 'Boleta vs Factura',
      subtitle: '¿Cuál emitir y cuándo?',
      emoji: '🧾',
      readTime: '5 min',
      color: AppColors.green,
      sections: [
        TaxSection(
          title: '¿Qué es una boleta de venta?',
          content: 'Es el comprobante que se entrega a personas naturales (consumidores finales). No permite deducir IGV, y se emite cuando el comprador no tiene RUC o no necesita factura para su negocio.',
        ),
        TaxSection(
          title: '¿Qué es una factura?',
          content: 'Es el comprobante que se entrega a empresas o personas con RUC. Permite al comprador deducir el IGV de sus compras como crédito fiscal. Es más formal y detallada que la boleta.',
        ),
        TaxSection(
          title: '¿Cuándo usar cada una?',
          content: '✓ Boleta: Cliente sin RUC o consumidor final\n✓ Factura: Cliente con RUC que necesita deducir impuestos\n\nEjemplo: Si un restaurant te atiende a ti (persona), emite boleta. Si le vendes servicios de diseño a una empresa, emites factura.',
        ),
        TaxSection(
          title: 'Comprobantes electrónicos',
          content: 'Desde hace varios años, SUNAT exige emitir comprobantes electrónicos (Factura Electrónica, Boleta Electrónica). Puedes hacerlo desde la plataforma de SUNAT o usando software autorizado.',
        ),
      ],
    ),
    TaxArticle(
      id: 'tax_4',
      title: 'Independientes y Cuarta Categoría',
      subtitle: 'Lo que debes saber si trabajas por tu cuenta',
      emoji: '💼',
      readTime: '6 min',
      color: AppColors.purple,
      sections: [
        TaxSection(
          title: '¿Qué es Cuarta Categoría?',
          content: 'Son los ingresos obtenidos por el ejercicio individual de una profesión, arte, ciencia u oficio. Si eres freelancer, consultor, médico independiente, abogado, diseñador, etc., probablemente generas rentas de 4ta categoría.',
        ),
        TaxSection(
          title: '¿Qué impuesto pagas?',
          content: 'Impuesto a la Renta (IR). La tasa es progresiva:\n• Hasta 5 UIT: exonerado\n• De 5 a 20 UIT: 8%\n• De 20 a 35 UIT: 14%\n• De 35 a 45 UIT: 17%\n• Más de 45 UIT: 20%\n\n(La UIT 2024 = S/. 5,150)',
        ),
        TaxSection(
          title: '¿Qué es una Recibo por Honorarios?',
          content: 'Es el comprobante que emites cuando cobras por tus servicios independientes. Puedes emitirlo electrónicamente en el portal de SUNAT. Tu cliente te retiene el 8% como pago anticipado del IR.',
        ),
        TaxSection(
          title: 'Declaración anual',
          content: 'Si tus ingresos anuales superan las 7 UIT (S/. 36,050), debes presentar declaración anual del IR entre marzo y abril del año siguiente.',
        ),
      ],
    ),
    TaxArticle(
      id: 'tax_5',
      title: 'Errores Tributarios Comunes',
      subtitle: 'Evita multas y problemas con SUNAT',
      emoji: '⚠️',
      readTime: '4 min',
      color: AppColors.amber,
      sections: [
        TaxSection(
          title: 'Error 1: No declarar todos los ingresos',
          content: 'Muchos creen que si cobran en efectivo SUNAT no se entera. Error. SUNAT cruza información con bancos, clientes y otras fuentes. Siempre declara todos tus ingresos.',
        ),
        TaxSection(
          title: 'Error 2: No emitir comprobantes',
          content: 'No emitir boleta o factura cuando corresponde es una infracción sancionada con multas. Siempre entrega comprobante por tus ventas o servicios.',
        ),
        TaxSection(
          title: 'Error 3: Mezclar finanzas personales y del negocio',
          content: 'Usa cuentas bancarias separadas para tu negocio y tus gastos personales. Mezclarlas complica la contabilidad y puede generar problemas ante una fiscalización.',
        ),
        TaxSection(
          title: 'Error 4: Ignorar notificaciones de SUNAT',
          content: 'SUNAT notifica por su buzón electrónico (clave SOL). Ignorar notificaciones puede derivar en multas adicionales o embargo. Revisa tu buzón regularmente.',
        ),
      ],
    ),
  ];

  // Transactions
  static List<Transaction> transactions = [
    Transaction(id: 't1', title: 'Salario enero', amount: 2500, isIncome: true, category: 'Ingresos', categoryEmoji: '💰', date: DateTime(2025, 1, 1)),
    Transaction(id: 't2', title: 'Freelance diseño', amount: 450, isIncome: true, category: 'Ingresos', categoryEmoji: '💰', date: DateTime(2025, 1, 5)),
    Transaction(id: 't3', title: 'Almuerzo semanal', amount: 180, isIncome: false, category: 'Comida', categoryEmoji: '🍔', date: DateTime(2025, 1, 6)),
    Transaction(id: 't4', title: 'Bus mensual', amount: 95, isIncome: false, category: 'Transporte', categoryEmoji: '🚌', date: DateTime(2025, 1, 7)),
    Transaction(id: 't5', title: 'Netflix + Spotify', amount: 45, isIncome: false, category: 'Entretenimiento', categoryEmoji: '🎮', date: DateTime(2025, 1, 8)),
    Transaction(id: 't6', title: 'Curso de inglés', amount: 120, isIncome: false, category: 'Estudios', categoryEmoji: '📚', date: DateTime(2025, 1, 10)),
    Transaction(id: 't7', title: 'Supermercado', amount: 210, isIncome: false, category: 'Comida', categoryEmoji: '🍔', date: DateTime(2025, 1, 12)),
    Transaction(id: 't8', title: 'Medicamento', amount: 35, isIncome: false, category: 'Salud', categoryEmoji: '🏥', date: DateTime(2025, 1, 14)),
    Transaction(id: 't9', title: 'Cena con amigos', amount: 85, isIncome: false, category: 'Entretenimiento', categoryEmoji: '🎮', date: DateTime(2025, 1, 16)),
    Transaction(id: 't10', title: 'Pago alquiler', amount: 600, isIncome: false, category: 'Hogar', categoryEmoji: '🏠', date: DateTime(2025, 1, 18)),
  ];

  // Savings goals
  static List<SavingsGoal> savingsGoals = [
    SavingsGoal(
      id: 'sg1',
      title: 'Fondo de emergencia',
      targetAmount: 3600,
      currentAmount: 1800,
      deadline: DateTime(2025, 6, 30),
      color: AppColors.green,
      emoji: '🛡️',
    ),
    SavingsGoal(
      id: 'sg2',
      title: 'Laptop nueva',
      targetAmount: 2500,
      currentAmount: 750,
      deadline: DateTime(2025, 9, 1),
      color: AppColors.cyan,
      emoji: '💻',
    ),
    SavingsGoal(
      id: 'sg3',
      title: 'Viaje a Cusco',
      targetAmount: 1200,
      currentAmount: 400,
      deadline: DateTime(2025, 7, 15),
      color: AppColors.purple,
      emoji: '✈️',
    ),
  ];

  // Achievements
  static List<Achievement> achievements = [
    Achievement(
      id: 'a1',
      title: 'Primer Paso',
      description: 'Completaste tu primera leccion',
      emoji: '🎯',
      color: AppColors.cyan,
      isUnlocked: true,
      unlockedAt: DateTime(2025, 1, 2),
    ),
    Achievement(
      id: 'a2',
      title: 'Racha de 3 dias',
      description: 'Aprendiste 3 dias seguidos',
      emoji: '🔥',
      color: AppColors.orange,
      isUnlocked: true,
      unlockedAt: DateTime(2025, 1, 5),
    ),
    Achievement(
      id: 'a3',
      title: 'Quiz Perfecto',
      description: 'Respondiste todo correcto en un quiz',
      emoji: '⭐',
      color: AppColors.amber,
      isUnlocked: true,
      unlockedAt: DateTime(2025, 1, 6),
    ),
    Achievement(
      id: 'a4',
      title: 'Ahorrador Nivel 1',
      description: 'Registraste tu primer ahorro',
      emoji: '🐷',
      color: AppColors.green,
      isUnlocked: false,
    ),
    Achievement(
      id: 'a5',
      title: '100 XP',
      description: 'Acumulaste 100 puntos de experiencia',
      emoji: '💎',
      color: AppColors.purple,
      isUnlocked: false,
    ),
    Achievement(
      id: 'a6',
      title: 'Racha de 7 dias',
      description: 'Aprendiste 7 dias consecutivos',
      emoji: '🌟',
      color: AppColors.amber,
      isUnlocked: false,
    ),
    Achievement(
      id: 'a7',
      title: 'Maestro Financiero',
      description: 'Completaste una ruta de aprendizaje',
      emoji: '🏆',
      color: AppColors.orange,
      isUnlocked: false,
    ),
    Achievement(
      id: 'a8',
      title: 'Experto Tributario',
      description: 'Leiste todos los articulos de impuestos',
      emoji: '📜',
      color: AppColors.navy500,
      isUnlocked: false,
    ),
  ];

  // Computed helpers
  static double get totalIncome =>
      transactions.where((t) => t.isIncome).fold(0, (s, t) => s + t.amount);

  static double get totalExpenses =>
      transactions.where((t) => !t.isIncome).fold(0, (s, t) => s + t.amount);

  static double get totalSavings => totalIncome - totalExpenses;

  static double get savingsRate => totalIncome > 0 ? totalSavings / totalIncome : 0;
}
