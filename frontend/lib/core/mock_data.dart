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
    // ── Módulo 1: Administración del dinero ──────────────────────────
    LearningPath(
      id: 'path_1',
      title: 'Administración del dinero',
      description: 'Organiza ingresos y gastos para no gastar más de lo que ganas',
      emoji: '💰',
      gradient: AppGradients.navyGradient,
      lessons: [
        Lesson(
          id: 'l1_1',
          title: 'Presupuesto Personal',
          subtitle: 'La regla 50/30/20 que cambia vidas',
          emoji: '📊',
          xpReward: 60,
          durationMinutes: 7,
          content: '''Un presupuesto es un plan para tu dinero. Sin uno, el dinero simplemente desaparece sin que sepas a dónde fue.

**La Regla 50/30/20**
• 50% — Necesidades: vivienda, comida, transporte, servicios básicos
• 30% — Deseos: entretenimiento, ropa, salidas, suscripciones
• 20% — Ahorros e inversión: tu futuro financiero

**Ejemplo real (S/. 1,500/mes)**
• S/. 750 → Necesidades
• S/. 450 → Deseos
• S/. 300 → Ahorro/inversión

**Cómo empezar**
• Anota todos tus ingresos del mes
• Registra cada gasto por 2 semanas
• Clasifica: ¿es necesidad o deseo?
• Ajusta según la regla 50/30/20''',
          quiz: [
            QuizQuestion(
              question: 'Según la regla 50/30/20, ¿qué porcentaje va a ahorros?',
              options: ['10%', '20%', '30%', '50%'],
              correctIndex: 1,
              explanation: 'El 20% se destina a ahorros e inversión. Es la base para construir riqueza.',
            ),
            QuizQuestion(
              question: 'Si ganas S/. 2,000, ¿cuánto va a necesidades según 50/30/20?',
              options: ['S/. 400', 'S/. 600', 'S/. 1,000', 'S/. 1,200'],
              correctIndex: 2,
              explanation: '50% de S/. 2,000 = S/. 1,000 para necesidades básicas.',
            ),
          ],
        ),
        Lesson(
          id: 'l1_2',
          title: 'Control de Gastos',
          subtitle: 'Saber a dónde va tu dinero es el primer paso',
          emoji: '🔍',
          xpReward: 50,
          durationMinutes: 5,
          content: '''Controlar los gastos no significa privarte de todo. Significa ser consciente de en qué gastas para poder elegir mejor.

**Los gastos hormiga**
Son pequeños gastos diarios que parecen insignificantes pero suman mucho. Un café de S/. 8 cada día = S/. 240 al mes = S/. 2,880 al año.

**Tipos de gastos**
• Gastos fijos: alquiler, servicios, préstamos — se pagan igual cada mes
• Gastos variables: comida, transporte, entretenimiento — cambian cada mes
• Gastos hormiga: café, snacks, apps — pequeños pero frecuentes

**Herramientas para controlar**
• Yape o Plin registran tus pagos automáticamente
• Apps de finanzas personales (Spendee, Fintonic)
• Una hoja de cálculo simple
• El método del sobre: dinero físico por categoría

**Regla de las 24 horas**
Antes de comprar algo que no es necesidad, espera 24 horas. Si al día siguiente aún lo quieres, probablemente vale la pena.''',
          quiz: [
            QuizQuestion(
              question: '¿Qué son los "gastos hormiga"?',
              options: [
                'Gastos de supermercado',
                'Pequeños gastos diarios que suman mucho',
                'Gastos de servicios básicos',
                'Deudas con intereses',
              ],
              correctIndex: 1,
              explanation: 'Los gastos hormiga son pequeños e individuales, pero acumulados pueden representar cientos de soles al mes.',
            ),
          ],
        ),
        Lesson(
          id: 'l1_3',
          title: 'Métodos de Ahorro',
          subtitle: 'Estrategias probadas para guardar más dinero',
          emoji: '🐷',
          xpReward: 60,
          durationMinutes: 6,
          content: '''Existen múltiples métodos para ahorrar. El mejor es el que funciona para ti y puedes mantener en el tiempo.

**Método 1: Págate primero a ti**
Apenas recibes tu sueldo, separa el ahorro antes de gastar en cualquier cosa. Trata el ahorro como un gasto obligatorio.

**Método 2: El redondeo**
Cada vez que gastas S/. 47, redondea a S/. 50 y guarda la diferencia. Pequeño esfuerzo, gran resultado acumulado.

**Método 3: El desafío del ahorro**
Semana 1: S/. 10, Semana 2: S/. 20, Semana 3: S/. 30... Al finalizar el año habrás ahorrado miles de soles.

**Método 4: La cuenta separada**
Abre una cuenta de ahorros diferente a la que usas para gastos diarios. Si no la ves, no la gastas.

**Método 5: Automatización**
Programa una transferencia automática el día que cobras. Sin decisión, sin tentación.''',
          quiz: [
            QuizQuestion(
              question: '¿Cuál es el principio del método "págate primero"?',
              options: [
                'Ahorrar lo que sobre al final del mes',
                'Separar el ahorro antes de cualquier gasto',
                'Ahorrar solo cuando hay excedente',
                'Invertir antes de ahorrar',
              ],
              correctIndex: 1,
              explanation: 'Pagarte primero significa separar el ahorro apenas recibes ingresos, antes que cualquier gasto.',
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
          content: '''Un fondo de emergencia es dinero guardado únicamente para imprevistos. Es el cimiento de toda estrategia financiera saludable.

**¿Cuánto necesitas?**
Entre 3 y 6 meses de tus gastos mensuales totales.

Si gastas S/. 1,200 al mes:
• Mínimo aceptable: S/. 3,600 (3 meses)
• Nivel ideal: S/. 7,200 (6 meses)

**¿Para qué sirve?**
• Perder el trabajo de forma inesperada
• Emergencia médica o accidente
• Reparación urgente del auto o casa
• Cualquier imprevisto que necesite dinero rápido

**¿Dónde guardarlo?**
En una cuenta de ahorros separada. Debe ser accesible (no en inversiones) pero no tan fácil de gastar.

**Regla de oro**
El fondo de emergencia NO es para vacaciones ni compras. Solo para verdaderas emergencias.''',
          quiz: [
            QuizQuestion(
              question: '¿Cuántos meses de gastos debe tener un fondo de emergencia ideal?',
              options: ['1-2 meses', '3-6 meses', '8-12 meses', '24 meses'],
              correctIndex: 1,
              explanation: '3 a 6 meses es el rango recomendado. Suficiente para emergencias sin inmovilizar demasiado capital.',
            ),
            QuizQuestion(
              question: '¿Para qué NO debe usarse el fondo de emergencia?',
              options: [
                'Pérdida de trabajo',
                'Emergencia médica',
                'Vacaciones planeadas',
                'Reparación urgente',
              ],
              correctIndex: 2,
              explanation: 'Las vacaciones son gastos planeados, no emergencias. El fondo es solo para imprevistos reales.',
            ),
          ],
        ),
        Lesson(
          id: 'l1_5',
          title: 'Yape, Plin y Cuentas Bancarias',
          subtitle: 'Herramientas digitales para manejar tu dinero',
          emoji: '📱',
          xpReward: 50,
          durationMinutes: 5,
          content: '''Perú tiene un ecosistema de pagos digitales muy activo. Usarlos bien te ahorra tiempo y te ayuda a controlar tus finanzas.

**Yape y Plin**
• Transferencias instantáneas sin costo entre usuarios
• Yape: del BCP, funciona con cualquier banco
• Plin: alianza BBVA + Interbank + BanBif + Scotia
• Ideal para: pagos entre personas, mercados, pequeños negocios

**Tipos de cuentas bancarias útiles**
• Cuenta de ahorros: para tu fondo de emergencia y ahorros
• Cuenta corriente o de haberes: para gastos del día a día
• Cuenta de inversión: para tus objetivos a largo plazo

**Buenas prácticas**
• Tener al menos 2 cuentas: una para gastos, otra para ahorros
• Activar notificaciones de cada transacción
• Revisar tu estado de cuenta al menos una vez por semana
• No compartir tu clave ni datos con nadie''',
          quiz: [
            QuizQuestion(
              question: '¿Cuántas cuentas bancarias mínimo es recomendable tener?',
              options: ['Una sola para todo', 'Dos: gastos y ahorros', 'Cinco o más', 'Ninguna, mejor efectivo'],
              correctIndex: 1,
              explanation: 'Tener una cuenta para gastos y otra para ahorros evita gastar lo que tenías reservado.',
            ),
          ],
        ),
      ],
    ),

    // ── Módulo 2: Crédito y deudas ───────────────────────────────────
    LearningPath(
      id: 'path_2',
      title: 'Crédito y deudas',
      description: 'Usa el crédito sin caer en sobreendeudamiento',
      emoji: '💳',
      gradient: AppGradients.navyGradient,
      lessons: [
        Lesson(
          id: 'l2_1',
          title: 'Tarjetas de Crédito',
          subtitle: 'Úsalas a tu favor, no en tu contra',
          emoji: '💳',
          xpReward: 70,
          durationMinutes: 7,
          content: '''Una tarjeta de crédito es una herramienta poderosa. Usada bien, es gratuita y hasta te da beneficios. Usada mal, puede destruir tus finanzas.

**Cómo funciona**
El banco te presta dinero por un mes. Si pagas el total antes de la fecha límite, no cobran interés. Si solo pagas el mínimo, empiezan a cobrarte intereses muy altos.

**La trampa del pago mínimo**
Si tienes una deuda de S/. 1,000 y solo pagas el mínimo mensual (~3%), podrías tardar más de 5 años en terminar de pagarla y habrás pagado el doble.

**Reglas de oro**
• Nunca gastar más de lo que puedes pagar ese mes
• Pagar siempre el total, nunca solo el mínimo
• No usar la tarjeta como extensión de tu sueldo
• Mantener el uso por debajo del 30% del límite

**Beneficios si la usas bien**
• Millas y puntos canjeables
• Cashback (devolución de dinero)
• Seguro de compras y viajes
• Construcción de historial crediticio''',
          quiz: [
            QuizQuestion(
              question: '¿Qué pasa si solo pagas el mínimo de tu tarjeta de crédito?',
              options: [
                'No hay consecuencias',
                'Pagas intereses muy altos y la deuda crece',
                'El banco te perdona la deuda',
                'Tu límite aumenta automáticamente',
              ],
              correctIndex: 1,
              explanation: 'Pagar solo el mínimo activa intereses muy altos que pueden duplicar la deuda original.',
            ),
            QuizQuestion(
              question: '¿Hasta qué porcentaje del límite es recomendable usar la tarjeta?',
              options: ['10%', '30%', '70%', '100%'],
              correctIndex: 1,
              explanation: 'Usar menos del 30% del límite ayuda a mantener buen score crediticio y evita sobreendeudamiento.',
            ),
          ],
        ),
        Lesson(
          id: 'l2_2',
          title: 'Préstamos Personales',
          subtitle: 'Cuándo pedir prestado y cuándo no',
          emoji: '🏦',
          xpReward: 60,
          durationMinutes: 6,
          content: '''Un préstamo no es malo en sí mismo. El problema es tomarlo sin entender las condiciones o para financiar gastos que no generan valor.

**¿Cuándo tiene sentido un préstamo?**
• Educación que mejora tus ingresos futuros
• Negocio con retorno claro
• Emergencia sin otro recurso disponible

**¿Cuándo NO tomar un préstamo?**
• Para compras impulsivas o lujos
• Para pagar otras deudas sin plan
• Cuando ya tienes muchas cuotas mensuales

**Qué revisar antes de firmar**
• TEA (Tasa Efectiva Anual): el costo real del préstamo
• TCEA (Tasa de Costo Efectivo Anual): incluye comisiones y seguros
• Cuota mensual vs tus ingresos (no debe superar el 30%)
• Penalidades por pago anticipado o mora

**Comparar siempre**
Antes de aceptar, compara al menos 3 entidades financieras. La diferencia en tasa puede ahorrarte cientos de soles.''',
          quiz: [
            QuizQuestion(
              question: '¿Qué mide la TCEA de un préstamo?',
              options: [
                'Solo la tasa de interés',
                'El costo total incluyendo comisiones y seguros',
                'El monto máximo que puedes pedir',
                'El plazo del préstamo',
              ],
              correctIndex: 1,
              explanation: 'La TCEA incluye la tasa de interés más todas las comisiones y seguros. Es el costo real del préstamo.',
            ),
          ],
        ),
        Lesson(
          id: 'l2_3',
          title: 'Intereses y TCEA',
          subtitle: 'Entiende cuánto realmente te cuesta el crédito',
          emoji: '📐',
          xpReward: 70,
          durationMinutes: 7,
          content: '''El interés es el precio que pagas por usar dinero prestado. Entenderlo te permite tomar mejores decisiones financieras.

**TNA vs TEA**
• TNA (Tasa Nominal Anual): la tasa "de vitrina", sin capitalización
• TEA (Tasa Efectiva Anual): la tasa real considerando capitalización

**TCEA: el costo completo**
La TCEA suma TEA + comisiones + seguros. Siempre compara TCEA, no solo TEA.

Ejemplo: Un préstamo de S/. 5,000 a 12 meses
• TEA 25% → pagas S/. 5,878 (solo intereses)
• TCEA 35% → pagas S/. 6,215 (con comisiones y seguros)

**Intereses en Perú (referencial 2024)**
• Tarjeta de crédito: 40-80% TEA
• Préstamo personal banco: 20-45% TEA
• Financiera: 60-120% TEA
• Prestamistas informales: pueden superar 200% anual

**Regla práctica**
Si la TCEA es mayor al 40%, evalúa muy bien si vale la pena. Por encima del 60%, casi nunca tiene sentido.''',
          quiz: [
            QuizQuestion(
              question: '¿Cuál indicador refleja el costo real total de un crédito?',
              options: ['TNA', 'TEA', 'TCEA', 'TCE'],
              correctIndex: 2,
              explanation: 'La TCEA incluye intereses + comisiones + seguros. Es el costo real y completo del crédito.',
            ),
          ],
        ),
        Lesson(
          id: 'l2_4',
          title: 'Historial Crediticio',
          subtitle: 'Tu reputación financiera en Perú',
          emoji: '⭐',
          xpReward: 60,
          durationMinutes: 6,
          content: '''En Perú, cada vez que pides o pagas un crédito, queda registrado en las centrales de riesgo. Este historial determina qué créditos puedes acceder y a qué tasas.

**Centrales de riesgo en Perú**
• SBS (Superintendencia de Banca y Seguros): registro oficial del Estado
• Equifax, Experian, Sentinel: privadas, con más detalle
• Infocorp: la más consultada por empresas y bancos

**Clasificaciones de deudores (SBS)**
• Normal: pagas puntual, sin atrasos
• CPP (Con Problemas Potenciales): atrasos de 9-30 días
• Deficiente: atrasos de 31-60 días
• Dudoso: atrasos de 61-120 días
• Pérdida: más de 120 días de atraso

**Cómo construir buen historial**
• Pagar siempre a tiempo, sin excepción
• Mantener deudas por debajo del 30% de tu capacidad
• No abrir muchas cuentas de crédito a la vez
• Revisar tu reporte al menos una vez al año (gratis en SBS)''',
          quiz: [
            QuizQuestion(
              question: '¿Qué clasificación SBS tiene quien paga puntualmente?',
              options: ['CPP', 'Deficiente', 'Normal', 'Dudoso'],
              correctIndex: 2,
              explanation: 'Clasificación "Normal" es la mejor. Indica que cumples tus compromisos sin atrasos.',
            ),
          ],
        ),
        Lesson(
          id: 'l2_5',
          title: 'Cómo Salir de Deudas',
          subtitle: 'Estrategias para liberarte del sobreendeudamiento',
          emoji: '🔓',
          xpReward: 80,
          durationMinutes: 8,
          content: '''Si tienes varias deudas, no entres en pánico. Existe un plan para salir de ellas de forma ordenada.

**Primer paso: hacer el inventario**
Lista todas tus deudas con: monto total, cuota mensual, tasa de interés y fecha de vencimiento.

**Método Bola de Nieve (Dave Ramsey)**
Paga el mínimo en todas las deudas y destina todo el extra a la más pequeña. Cuando la eliminas, ese dinero va a la siguiente. Motivacional porque ves resultados rápido.

**Método Avalancha**
Paga el mínimo en todas y destina el extra a la deuda con mayor tasa de interés. Matemáticamente más eficiente, ahorras más en intereses.

**Estrategias adicionales**
• Renegociar tasas con el banco (muchas veces aceptan si tienes buen historial)
• Consolidar deudas en una sola con menor tasa
• Evitar tomar más deuda mientras liquidas las actuales
• Usar ingresos extra (bonos, horas adicionales) para pagar deuda

**Lo que NO debes hacer**
• Ignorar las deudas: los intereses crecen
• Pedir prestado para pagar deuda sin plan
• Desaparecer del radar del banco''',
          quiz: [
            QuizQuestion(
              question: '¿Qué caracteriza al método "Bola de Nieve"?',
              options: [
                'Pagar primero la deuda con mayor interés',
                'Pagar primero la deuda más pequeña',
                'Pagar todas las deudas por igual',
                'Ignorar las deudas pequeñas',
              ],
              correctIndex: 1,
              explanation: 'Bola de nieve: atacas la deuda más pequeña primero para ganar impulso psicológico y liberarte rápido de obligaciones.',
            ),
          ],
        ),
      ],
    ),

    // ── Módulo 3: Inversión y crecimiento ────────────────────────────
    LearningPath(
      id: 'path_3',
      title: 'Inversión y crecimiento',
      description: 'Haz crecer tu dinero con estrategia',
      emoji: '📈',
      gradient: AppGradients.navyGradient,
      lessons: [
        Lesson(
          id: 'l3_1',
          title: 'Conceptos Básicos de Inversión',
          subtitle: 'Qué necesitas saber antes de invertir',
          emoji: '🎓',
          xpReward: 60,
          durationMinutes: 6,
          content: '''Invertir es poner tu dinero a trabajar para que genere más dinero. No es solo para ricos: con S/. 100 ya puedes empezar.

**Conceptos clave**
• Capital: el dinero que inviertes inicialmente
• Rendimiento: la ganancia que obtienes
• Riesgo: la posibilidad de perder parte del capital
• Liquidez: qué tan fácil es convertir la inversión en efectivo
• Plazo: cuánto tiempo mantienes la inversión

**La relación riesgo-rendimiento**
A mayor riesgo, mayor rendimiento potencial. No existe alto rendimiento sin riesgo. Desconfía de cualquiera que prometa "ganancias seguras y altas".

**Tipos de inversión por riesgo**
• Bajo riesgo: depósitos a plazo, bonos del gobierno
• Riesgo medio: fondos mutuos, ETFs
• Alto riesgo: acciones individuales, criptomonedas

**El principio más importante**
Nunca inviertas dinero que no puedes permitirte perder. Tu fondo de emergencia NO es para inversión.''',
          quiz: [
            QuizQuestion(
              question: '¿Qué relación existe entre riesgo y rendimiento?',
              options: [
                'A mayor riesgo, menor rendimiento',
                'No tienen relación',
                'A mayor riesgo, mayor rendimiento potencial',
                'A menor riesgo, mayor rendimiento',
              ],
              correctIndex: 2,
              explanation: 'La relación riesgo-rendimiento es fundamental: más riesgo implica potencial de mayor ganancia, pero también de mayor pérdida.',
            ),
          ],
        ),
        Lesson(
          id: 'l3_2',
          title: 'Interés Compuesto',
          subtitle: 'La octava maravilla del mundo',
          emoji: '🚀',
          xpReward: 70,
          durationMinutes: 7,
          content: '''El interés compuesto es ganar interés sobre los intereses anteriores. Con el tiempo, crea un efecto de "bola de nieve" que multiplica tu dinero.

**Interés simple vs compuesto**
• Simple: ganas interés solo sobre el capital original
• Compuesto: ganas interés sobre capital + intereses acumulados

**Ejemplo: S/. 1,000 al 10% anual**
• Año 1: S/. 1,100 (simple y compuesto igual)
• Año 5: Simple S/. 1,500 vs Compuesto S/. 1,611
• Año 10: Simple S/. 2,000 vs Compuesto S/. 2,594
• Año 20: Simple S/. 3,000 vs Compuesto S/. 6,727

**La Regla del 72**
Divide 72 entre la tasa de interés anual para saber en cuántos años se duplica tu dinero.
• 72 ÷ 10% = 7.2 años
• 72 ÷ 6% = 12 años
• 72 ÷ 12% = 6 años

**El secreto: el tiempo**
El interés compuesto necesita tiempo para brillar. Empezar a los 25 años vs a los 35 puede significar el doble de dinero al retirarte.''',
          quiz: [
            QuizQuestion(
              question: 'Con la Regla del 72 y una tasa del 9% anual, ¿en cuántos años se duplica el dinero?',
              options: ['4 años', '8 años', '12 años', '18 años'],
              correctIndex: 1,
              explanation: '72 ÷ 9 = 8 años. La regla del 72 es una estimación rápida y muy práctica.',
            ),
          ],
        ),
        Lesson(
          id: 'l3_3',
          title: 'Fondos Mutuos',
          subtitle: 'Invierte en un portafolio diversificado desde poco dinero',
          emoji: '🧺',
          xpReward: 70,
          durationMinutes: 7,
          content: '''Un fondo mutuo junta el dinero de muchos inversionistas para comprar una cartera diversificada de activos. Es una de las formas más accesibles de invertir.

**¿Cómo funciona?**
Tú compras "cuotas" del fondo. Un gestor profesional administra el dinero invirtiendo en acciones, bonos u otros activos. Ganas (o pierdes) en proporción a tu participación.

**Tipos de fondos en Perú**
• Fondos de renta fija: invierten en bonos, bajo riesgo (~4-8% anual)
• Fondos de renta variable: invierten en acciones, mayor riesgo (~8-15% anual)
• Fondos mixtos: combinan ambos
• Fondos de mercado de dinero: muy líquidos, para plazos cortos

**Ventajas**
• Diversificación desde montos bajos (desde S/. 100)
• Gestión profesional sin necesitar expertise
• Liquidez (puedes retirar en días hábiles)
• Regulados por la SBS/SMV

**Dónde en Perú**
BCP, Credicorp, Sura, Fondo Scotia, Interfondos, entre otros. Compara comisiones (TGA) antes de elegir.''',
          quiz: [
            QuizQuestion(
              question: '¿Qué tipo de fondo mutuo tiene menor riesgo?',
              options: ['Renta variable', 'Mixto', 'Renta fija', 'Mercado de dinero'],
              correctIndex: 2,
              explanation: 'Los fondos de renta fija invierten en bonos y tienen menor volatilidad, aunque también menor rendimiento potencial.',
            ),
          ],
        ),
        Lesson(
          id: 'l3_4',
          title: 'Acciones',
          subtitle: 'Conviértete en dueño de empresas',
          emoji: '📉',
          xpReward: 80,
          durationMinutes: 8,
          content: '''Una acción es una fracción de propiedad de una empresa. Al comprar acciones de una empresa, te conviertes en su dueño parcial.

**¿Cómo ganas dinero con acciones?**
• Plusvalía: la acción sube de precio y la vendes más cara
• Dividendos: la empresa reparte utilidades a sus accionistas

**Riesgo de las acciones**
• Alta volatilidad: pueden subir o bajar mucho en poco tiempo
• Requieren conocimiento del mercado y la empresa
• No hay garantía de rendimiento

**Principios para principiantes**
• Invierte solo lo que no necesitas en el corto plazo
• Diversifica: no pongas todo en una sola empresa
• Piensa a largo plazo: el mercado sube con el tiempo
• No tomes decisiones basadas en emociones o rumores

**Bolsa de Valores de Lima (BVL)**
En Perú puedes invertir en la BVL en empresas locales como Credicorp, Alicorp, Cerro Verde. También puedes acceder a mercados internacionales (NYSE, NASDAQ) a través de brokers como Kallpa SAB o TD Ameritrade.''',
          quiz: [
            QuizQuestion(
              question: '¿De qué dos formas puedes ganar dinero con acciones?',
              options: [
                'Intereses y comisiones',
                'Plusvalía y dividendos',
                'Bonos y préstamos',
                'Ahorro y depósito',
              ],
              correctIndex: 1,
              explanation: 'Con acciones ganas por plusvalía (precio sube) o dividendos (empresa reparte utilidades).',
            ),
          ],
        ),
        Lesson(
          id: 'l3_5',
          title: 'Bienes Raíces',
          subtitle: 'El activo favorito del peruano',
          emoji: '🏠',
          xpReward: 80,
          durationMinutes: 8,
          content: '''Invertir en bienes raíces significa comprar propiedades para generar ingresos o plusvalía. Es la inversión más popular en Perú.

**Formas de invertir en inmuebles**
• Comprar para alquilar: ingresos pasivos por renta mensual
• Comprar para vender: esperar que suba el valor y vender más caro
• Comprar en preventa: precios más bajos en proyectos en construcción

**Ventajas**
• Activo tangible: la propiedad física no desaparece
• Protección contra inflación: los precios inmobiliarios suelen subir
• Ingresos pasivos por alquiler
• Buena plusvalía en zonas de crecimiento

**Desventajas**
• Alta inversión inicial (cuota inicial + gastos notariales)
• Baja liquidez: no puedes vender una casa en un día
• Costos de mantenimiento, impuestos y vacancia
• Puede haber problemas con inquilinos

**En Perú: MiVivienda**
El Fondo MiVivienda ofrece créditos hipotecarios con tasas más bajas para primera vivienda. El Bono del Buen Pagador puede darte hasta S/. 25,700 de subsidio.''',
          quiz: [
            QuizQuestion(
              question: '¿Qué es la "preventa" en bienes raíces?',
              options: [
                'Vender una propiedad antes de terminar el pago',
                'Comprar en proyectos aún en construcción a precio menor',
                'Alquilar antes de comprar',
                'Vender en subasta',
              ],
              correctIndex: 1,
              explanation: 'En preventa compras cuando el proyecto aún se construye. El precio es menor pero debes esperar y hay riesgo si el proyecto se retrasa.',
            ),
          ],
        ),
        Lesson(
          id: 'l3_6',
          title: 'Inversión para Principiantes',
          subtitle: 'Por dónde empezar si nunca has invertido',
          emoji: '🌱',
          xpReward: 60,
          durationMinutes: 6,
          content: '''Si nunca has invertido, aquí está la hoja de ruta más segura para comenzar en Perú.

**Paso 1: Fondo de emergencia primero**
Antes de invertir, asegúrate de tener 3-6 meses de gastos en una cuenta de ahorros. Esto protege tus inversiones de tener que venderlas en mal momento.

**Paso 2: Liquida deudas de alto costo**
Si tienes deudas con tasas mayores al 15-20%, pagar esas deudas es la mejor "inversión" que puedes hacer.

**Paso 3: Empieza con fondos mutuos**
Son la forma más accesible de invertir. Puedes empezar con S/. 100-500 y aprender cómo funciona el mercado sin riesgo excesivo.

**Paso 4: Aprende mientras inviertes**
Lee, toma cursos, sigue noticias financieras. El conocimiento reduce el riesgo.

**Errores comunes del principiante**
• Invertir dinero que va a necesitar pronto
• Buscar "hacerse rico rápido"
• Vender en pánico cuando el mercado baja
• No diversificar (todo en una sola cosa)
• Seguir "tips" de redes sociales sin investigar''',
          quiz: [
            QuizQuestion(
              question: '¿Qué deberías hacer ANTES de empezar a invertir?',
              options: [
                'Comprar acciones de moda',
                'Tener fondo de emergencia y liquidar deudas caras',
                'Abrir una cuenta en cripto',
                'Esperar tener mucho dinero',
              ],
              correctIndex: 1,
              explanation: 'El orden correcto: fondo de emergencia → pagar deudas caras → invertir. Sin base sólida, las inversiones son muy riesgosas.',
            ),
          ],
        ),
      ],
    ),

    // ── Módulo 4: Impuestos y formalización ──────────────────────────
    LearningPath(
      id: 'path_4',
      title: 'Impuestos y formalización',
      description: 'Entiende SUNAT y cumple sin complicaciones',
      emoji: '🏛️',
      gradient: AppGradients.navyGradient,
      lessons: [
        Lesson(
          id: 'l4_1',
          title: 'Cómo Funciona la SUNAT',
          subtitle: 'El organismo tributario del Perú',
          emoji: '⚖️',
          xpReward: 50,
          durationMinutes: 5,
          content: '''SUNAT (Superintendencia Nacional de Aduanas y de Administración Tributaria) es el organismo del Estado que administra los impuestos en Perú.

**¿Qué hace la SUNAT?**
• Recauda impuestos como el IGV e Impuesto a la Renta
• Controla el cumplimiento de obligaciones tributarias
• Facilita el comercio exterior
• Orienta a los contribuyentes sobre sus obligaciones
• Sanciona a quienes evaden impuestos

**¿A quién le afecta?**
Si generas ingresos en Perú, tienes obligaciones con SUNAT: empleados dependientes, freelancers, dueños de negocio, arrendadores de propiedades.

**Clave SOL**
Es tu acceso al portal de SUNAT (sunat.gob.pe). Aquí puedes consultar tu RUC, presentar declaraciones y recibir notificaciones oficiales.

**Mito común**
"Si cobro en efectivo, SUNAT no se entera." FALSO. SUNAT cruza información con bancos, clientes y otras fuentes. Siempre declara todos tus ingresos.''',
          quiz: [
            QuizQuestion(
              question: '¿Qué es la Clave SOL?',
              options: [
                'Una cuenta bancaria especial',
                'El acceso al portal web de SUNAT',
                'Un tipo de impuesto',
                'El número de contribuyente',
              ],
              correctIndex: 1,
              explanation: 'La Clave SOL es tu usuario y contraseña para el portal de SUNAT, donde realizas trámites y declaraciones.',
            ),
          ],
        ),
        Lesson(
          id: 'l4_2',
          title: 'RUC y Tipos de Régimen',
          subtitle: 'El primer paso para operar formalmente',
          emoji: '📋',
          xpReward: 60,
          durationMinutes: 6,
          content: '''El RUC (Registro Único de Contribuyentes) es un número de 11 dígitos que te identifica ante SUNAT. Es el primer paso para formalizarte.

**¿Quién necesita RUC?**
• Freelancers y profesionales independientes
• Dueños de cualquier negocio
• Personas que alquilan propiedades
• Cualquiera que emita comprobantes de pago

**Cómo obtener el RUC**
• En la web de SUNAT (sunat.gob.pe) en minutos
• En oficinas de SUNAT con tu DNI
• Es gratuito

**Regímenes tributarios para pequeños negocios**
• NRUS (Nuevo RUS): Para negocios muy pequeños. Cuota fija mensual de S/. 20 o S/. 50. Sin declaración de IGV.
• RER (Régimen Especial de Renta): Ventas hasta S/. 525,000/año. Paga 1.5% de ingresos netos + IGV.
• MYPE Tributario: Para MYPES. Paga 10% hasta 15 UIT y 29.5% sobre el exceso + IGV.
• Régimen General: Sin límite de ingresos. Más complejo, para negocios grandes.''',
          quiz: [
            QuizQuestion(
              question: '¿Cuál es el régimen más simple para un negocio muy pequeño?',
              options: ['Régimen General', 'MYPE Tributario', 'NRUS', 'RER'],
              correctIndex: 2,
              explanation: 'El NRUS tiene cuotas fijas muy bajas (S/. 20-50/mes) y es el más simple para negocios pequeños con ventas limitadas.',
            ),
          ],
        ),
        Lesson(
          id: 'l4_3',
          title: 'Declaración de Impuestos',
          subtitle: 'Cómo y cuándo declarar',
          emoji: '📝',
          xpReward: 70,
          durationMinutes: 7,
          content: '''Declarar impuestos es informar a SUNAT cuánto ganaste y cuánto debes pagar. Hacerlo bien y a tiempo evita multas.

**Declaración mensual**
La mayoría de negocios declara mensualmente el IGV y los pagos a cuenta del Impuesto a la Renta. Se hace en el portal de SUNAT con la Clave SOL.

**Declaración anual**
Se presenta entre marzo y abril del año siguiente. Consolida todos los ingresos del año y determina si debes pagar más impuesto o si te devuelven algo.

**¿Quién debe presentar declaración anual?**
• Personas con rentas de 4ta categoría si sus ingresos superan 7 UIT (S/. 36,050 en 2024)
• Todos los negocios bajo Régimen General y MYPE Tributario

**Cronograma de vencimientos**
SUNAT publica cada año el cronograma según el último dígito del RUC. Cumplir las fechas evita multas automáticas.

**Multas comunes y cómo evitarlas**
• No declarar: multa del 50% del impuesto omitido
• Declarar tarde: 1 UIT para medianos y grandes
• No emitir comprobante: cierre del local o multa''',
          quiz: [
            QuizQuestion(
              question: '¿Cuándo se presenta la declaración anual de impuestos?',
              options: [
                'Enero del mismo año',
                'Marzo-Abril del año siguiente',
                'Diciembre del mismo año',
                'Julio de cualquier año',
              ],
              correctIndex: 1,
              explanation: 'La declaración anual se presenta entre marzo y abril del año siguiente al período declarado.',
            ),
          ],
        ),
        Lesson(
          id: 'l4_4',
          title: 'Recibos por Honorarios',
          subtitle: 'El comprobante del trabajador independiente',
          emoji: '🧾',
          xpReward: 60,
          durationMinutes: 6,
          content: '''Si trabajas de forma independiente (freelancer, consultor, profesional), el recibo por honorarios es tu comprobante de pago oficial.

**¿Qué es la renta de 4ta categoría?**
Son los ingresos por ejercicio independiente de una profesión, oficio o arte. Si eres diseñador, abogado, médico, programador freelance o consultor, generas rentas de 4ta categoría.

**¿Cómo emitir un recibo por honorarios?**
• Entra al portal de SUNAT con tu Clave SOL
• Módulo de Comprobantes Electrónicos
• Emite el recibo indicando cliente, monto y descripción del servicio
• Es completamente digital y gratuito

**La retención del 8%**
Cuando emites un recibo, tu cliente está obligado a retenerte el 8% como pago adelantado del Impuesto a la Renta. Eso no es que "pierdas" ese dinero: es un anticipo que se descuenta en tu declaración anual.

**Suspensión de retenciones**
Si tus ingresos anuales no superan S/. 36,313 (aproximadamente), puedes pedir a SUNAT la suspensión de retenciones. Así recibes el 100% de tus honorarios.''',
          quiz: [
            QuizQuestion(
              question: '¿Qué porcentaje retiene el cliente al pagar un recibo por honorarios?',
              options: ['5%', '8%', '18%', '30%'],
              correctIndex: 1,
              explanation: 'El cliente retiene el 8% como pago adelantado del Impuesto a la Renta de 4ta categoría.',
            ),
          ],
        ),
        Lesson(
          id: 'l4_5',
          title: 'IGV y Renta',
          subtitle: 'Los dos impuestos más importantes del Perú',
          emoji: '💹',
          xpReward: 70,
          durationMinutes: 7,
          content: '''El IGV y el Impuesto a la Renta son los dos pilares del sistema tributario peruano. Entenderlos es esencial para cualquier negocio o profesional.

**IGV (Impuesto General a las Ventas)**
• Tasa: 18% sobre el precio de venta
• Lo paga el consumidor final, pero el negocio lo recauda y entrega a SUNAT
• Si tu negocio compra insumos con IGV, puedes usar ese IGV como crédito fiscal
• Ejemplo: vendes S/. 100 → cobras S/. 118 → los S/. 18 van a SUNAT

**Impuesto a la Renta (IR)**
Grava las ganancias. Diferentes tasas según el tipo de ingreso:
• 1ra categoría (alquileres): 5% de la renta
• 3ra categoría (empresas): 29.5% de utilidades netas
• 4ta categoría (independientes): tasa progresiva de 8-30%
• 5ta categoría (empleados): retenida por empleador, tasa progresiva

**La UIT 2024**
La UIT (Unidad Impositiva Tributaria) es S/. 5,150. Muchos límites y tramos tributarios se expresan en múltiplos de UIT.''',
          quiz: [
            QuizQuestion(
              question: '¿Cuál es la tasa del IGV en Perú?',
              options: ['10%', '15%', '18%', '21%'],
              correctIndex: 2,
              explanation: 'El IGV en Perú es del 18% sobre el precio de venta de bienes y servicios.',
            ),
          ],
        ),
      ],
    ),

    // ── Módulo 5: Planificación financiera ───────────────────────────
    LearningPath(
      id: 'path_5',
      title: 'Planificación financiera',
      description: 'Planifica tu futuro y protege lo que construiste',
      emoji: '🎯',
      gradient: AppGradients.navyGradient,
      lessons: [
        Lesson(
          id: 'l5_1',
          title: 'Metas Financieras',
          subtitle: 'Define a dónde quieres llegar con tu dinero',
          emoji: '🏁',
          xpReward: 50,
          durationMinutes: 5,
          content: '''Sin metas claras, el dinero simplemente se va. Las metas financieras convierten tus sueños en planes concretos.

**Tipos de metas por plazo**
• Corto plazo (menos de 1 año): fondo de emergencia, vacaciones, laptop
• Mediano plazo (1-5 años): auto, cuota inicial de depa, negocio
• Largo plazo (más de 5 años): casa propia, jubilación, educación de hijos

**El método SMART para metas**
• Específica: "ahorrar S/. 5,000" en vez de "ahorrar más"
• Medible: saber exactamente cuánto y cuándo
• Alcanzable: realista con tus ingresos actuales
• Relevante: que realmente importe en tu vida
• Con tiempo: fecha límite concreta

**Ejemplo de meta SMART**
"Ahorrar S/. 3,600 para mi fondo de emergencia en 12 meses, guardando S/. 300 mensuales."

**Prioriza tus metas**
No intentes alcanzar todas las metas a la vez. Ordénalas por importancia y urgencia. El fondo de emergencia siempre va primero.''',
          quiz: [
            QuizQuestion(
              question: '¿Qué tipo de meta es "ahorrar para la jubilación en 30 años"?',
              options: ['Corto plazo', 'Mediano plazo', 'Largo plazo', 'Urgente'],
              correctIndex: 2,
              explanation: 'Las metas de más de 5 años son de largo plazo. La jubilación es el ejemplo más importante de meta financiera de largo plazo.',
            ),
          ],
        ),
        Lesson(
          id: 'l5_2',
          title: 'Ahorro para Objetivos Grandes',
          subtitle: 'Estrategias para metas que requieren mucho dinero',
          emoji: '🏆',
          xpReward: 60,
          durationMinutes: 6,
          content: '''Un auto, una casa, estudiar en el extranjero, montar un negocio. Estas metas requieren planificación a mediano y largo plazo.

**El método del objetivo inverso**
1. Define el monto total que necesitas (ej: S/. 30,000)
2. Define la fecha límite (ej: en 3 años = 36 meses)
3. Divide: S/. 30,000 ÷ 36 = S/. 833/mes
4. Ajusta según tu capacidad real

**Cuentas de ahorro para objetivos**
• Depósitos a plazo fijo: tasas más altas a cambio de no tocar el dinero
• Cuenta de ahorros con meta: algunos bancos ofrecen cuentas que "bloquean" el dinero hasta alcanzar la meta
• CETES y bonos: para metas largas con rendimiento moderado

**El poder de los plazos fijos en Perú**
Los depósitos a plazo fijo en bancos peruanos ofrecen entre 4% y 7% anual según el banco y el plazo. Es una opción segura para ahorros a mediano plazo.

**Cuota inicial para vivienda**
En Perú, la cuota inicial mínima es generalmente el 10-20% del valor del inmueble. Para un depa de S/. 200,000 necesitas entre S/. 20,000 y S/. 40,000 de entrada.''',
          quiz: [
            QuizQuestion(
              question: 'Para ahorrar S/. 12,000 en 12 meses, ¿cuánto debes guardar mensualmente?',
              options: ['S/. 500', 'S/. 800', 'S/. 1,000', 'S/. 1,200'],
              correctIndex: 2,
              explanation: 'S/. 12,000 ÷ 12 meses = S/. 1,000 por mes. El método del objetivo inverso es así de simple.',
            ),
          ],
        ),
        Lesson(
          id: 'l5_3',
          title: 'Jubilación: AFP y ONP',
          subtitle: 'Prepara tu futuro financiero desde hoy',
          emoji: '👴',
          xpReward: 80,
          durationMinutes: 8,
          content: '''En Perú, todos los trabajadores en planilla deben estar afiliados a un sistema de pensiones. Entender las diferencias puede significar miles de soles en tu jubilación.

**Los dos sistemas**

AFP (Administradoras de Fondos de Pensiones):
• Sistema privado de capitalización individual
• Tu dinero está en una cuenta personal a tu nombre
• Aporte: 10% de tu sueldo + comisión AFP (~1.5%)
• Al jubilarte recibes lo que acumulaste + rendimientos
• Puedes elegir el fondo según tu perfil de riesgo (Fondo 1, 2 o 3)
• Si falleces, tus herederos reciben el fondo acumulado

ONP (Oficina de Normalización Previsional):
• Sistema público de reparto
• Tu aporte financia las pensiones actuales (no es tu cuenta)
• Aporte: 13% de tu sueldo
• Pensión máxima: S/. 893 (con 20 años de aportes mínimos)
• Requiere mínimo 20 años de aportes para jubilarte

**¿AFP o ONP?**
Para la mayoría de trabajadores jóvenes de hoy, la AFP puede ser más conveniente dado que la ONP tiene beneficios más limitados y menos certeza.

**Independientes y jubilación**
Si trabajas de forma independiente, no tienes obligación de aportar, pero sí puedes afiliarte voluntariamente a una AFP. Es muy recomendable hacerlo.''',
          quiz: [
            QuizQuestion(
              question: '¿Cuál es la principal diferencia entre AFP y ONP?',
              options: [
                'La AFP es obligatoria y la ONP no',
                'En la AFP el dinero es tuyo; en la ONP es del sistema',
                'La ONP ofrece mayor rendimiento',
                'Solo la AFP permite jubilarse',
              ],
              correctIndex: 1,
              explanation: 'En la AFP tu dinero está en una cuenta individual a tu nombre. En la ONP, tus aportes financian pensiones actuales (sistema de reparto).',
            ),
          ],
        ),
        Lesson(
          id: 'l5_4',
          title: 'Seguros',
          subtitle: 'Protege lo que has construido',
          emoji: '🛡️',
          xpReward: 60,
          durationMinutes: 6,
          content: '''Los seguros son la herramienta de protección financiera más importante. Un evento no asegurado puede destruir años de trabajo en días.

**¿Qué es un seguro?**
Pagas una prima mensual/anual a cambio de protección ante eventos que podrían generar grandes gastos. TransfierEs el riesgo a la aseguradora.

**Tipos de seguros prioritarios**

Seguro de salud (EsSalud / privado):
• Si trabajas en planilla, EsSalud cubre atenciones básicas
• Un seguro privado da acceso a clínicas y reduce tiempos
• Prioridad alta: una emergencia médica puede costar S/. 20,000+

Seguro de vida:
• Paga a tus beneficiarios si falleces
• Fundamental si tienes dependientes (hijos, cónyuge)
• En Perú desde S/. 30-50 mensuales

Seguro vehicular:
• SOAT: obligatorio por ley, cubre accidentes con terceros
• Seguro todo riesgo: protege tu propio vehículo
• Seguro contra robos: importante en zonas de alto riesgo

**Regla del seguro**
Solo asegura lo que no puedes permitirte perder o pagar de tu bolsillo. No necesitas seguro para tu celular si tienes fondo de emergencia suficiente.''',
          quiz: [
            QuizQuestion(
              question: '¿Cuál seguro es OBLIGATORIO por ley en Perú para vehículos?',
              options: ['Seguro todo riesgo', 'SOAT', 'Seguro de vida', 'Seguro vehicular privado'],
              correctIndex: 1,
              explanation: 'El SOAT (Seguro Obligatorio de Accidentes de Tránsito) es exigido por ley para todos los vehículos que circulan en Perú.',
            ),
          ],
        ),
        Lesson(
          id: 'l5_5',
          title: 'Protección Financiera',
          subtitle: 'Blindar tu patrimonio ante cualquier situación',
          emoji: '🔒',
          xpReward: 70,
          durationMinutes: 7,
          content: '''La protección financiera va más allá de los seguros. Es el conjunto de estrategias para que tu patrimonio esté seguro sin importar lo que pase.

**Los 5 pilares de protección financiera**

1. Fondo de emergencia (3-6 meses de gastos)
Tu primera línea de defensa ante cualquier imprevisto.

2. Seguros adecuados
Salud, vida y propiedad según tu situación familiar y patrimonial.

3. Diversificación de ingresos
No depender de una sola fuente de ingresos. Freelance, inversiones, negocio secundario.

4. Diversificación de inversiones
Nunca todo en un solo activo. Distintos tipos, monedas, geografías.

5. Documentación en orden
Testamento, poderes notariales, contratos formales. Lo legal protege lo financiero.

**Protección contra inflación**
La inflación erosiona el poder adquisitivo del dinero. Tener solo efectivo o cuenta de ahorros no es suficiente. Parte de tus ahorros deben estar en activos que superen la inflación (inversiones, inmuebles).

**Dolarización parcial**
Mantener parte de tus ahorros en dólares protege ante la devaluación del sol. No tienes que cambiar todo, pero 20-30% en dólares es razonable para muchas personas.''',
          quiz: [
            QuizQuestion(
              question: '¿Cuál es el primer pilar de protección financiera?',
              options: [
                'Tener seguros de vida',
                'Invertir en bolsa',
                'Fondo de emergencia de 3-6 meses',
                'Dolarizar los ahorros',
              ],
              correctIndex: 2,
              explanation: 'El fondo de emergencia es la base de toda protección financiera. Sin él, cualquier imprevisto puede desestabilizar tus finanzas.',
            ),
          ],
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
