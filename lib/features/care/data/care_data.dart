import 'package:flutter/material.dart';

class CareCategory {
  const CareCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.tips,
  });

  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final List<CareTip> tips;
}

class CareTip {
  const CareTip({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;
}

class Medication {
  const Medication({
    required this.id,
    required this.name,
    required this.time,
    this.isEnabled = true,
  });

  final String id;
  final String name;
  final TimeOfDay time;
  final bool isEnabled;

  Medication copyWith({
    String? id,
    String? name,
    TimeOfDay? time,
    bool? isEnabled,
  }) {
    return Medication(
      id: id ?? this.id,
      name: name ?? this.name,
      time: time ?? this.time,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

class WaterReminder {
  const WaterReminder({
    required this.targetGlasses,
    required this.currentGlasses,
    this.isEnabled = true,
  });

  final int targetGlasses;
  final int currentGlasses;
  final bool isEnabled;

  WaterReminder copyWith({
    int? targetGlasses,
    int? currentGlasses,
    bool? isEnabled,
  }) {
    return WaterReminder(
      targetGlasses: targetGlasses ?? this.targetGlasses,
      currentGlasses: currentGlasses ?? this.currentGlasses,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

class ReliefInstruction {
  const ReliefInstruction({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.steps,
    this.videoUrl,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final List<String> steps;
  final String? videoUrl;
}

const List<ReliefInstruction> reliefInstructions = [
  ReliefInstruction(
    id: 'heat_therapy',
    title: 'Тепловая терапия',
    description: 'Тепло помогает расслабить мышцы матки и уменьшить спазмы',
    icon: Icons.whatshot,
    steps: [
      'Возьмите грелку или бутылку с тёплой водой',
      'Оберните её полотенцем, чтобы избежать ожогов',
      'Приложите к нижней части живота',
      'Держите 15-20 минут',
      'Повторяйте по необходимости',
    ],
  ),
  ReliefInstruction(
    id: 'gentle_stretching',
    title: 'Лёгкая растяжка',
    description: 'Мягкие упражнения улучшают кровообращение и снимают напряжение',
    icon: Icons.self_improvement,
    steps: [
      'Лягте на спину, согните колени',
      'Медленно притяните колени к груди',
      'Обхватите колени руками',
      'Покачивайтесь из стороны в сторону',
      'Удерживайте позу 30 секунд',
      'Повторите 3-5 раз',
    ],
    videoUrl: 'https://youtube.com/watch?v=example1',
  ),
  ReliefInstruction(
    id: 'breathing',
    title: 'Дыхательные упражнения',
    description: 'Глубокое дыхание помогает расслабиться и уменьшить боль',
    icon: Icons.air,
    steps: [
      'Сядьте или лягте в удобное положение',
      'Положите руку на живот',
      'Медленно вдохните через нос на 4 счёта',
      'Задержите дыхание на 4 счёта',
      'Медленно выдохните через рот на 6 счётов',
      'Повторите 5-10 раз',
    ],
  ),
  ReliefInstruction(
    id: 'massage',
    title: 'Самомассаж живота',
    description: 'Массаж улучшает кровообращение и снимает мышечное напряжение',
    icon: Icons.spa,
    steps: [
      'Нанесите немного масла или крема на живот',
      'Положите ладони на нижнюю часть живота',
      'Делайте круговые движения по часовой стрелке',
      'Слегка надавливайте, но не до боли',
      'Массируйте 5-10 минут',
    ],
  ),
  ReliefInstruction(
    id: 'child_pose',
    title: 'Поза ребёнка (йога)',
    description: 'Расслабляющая поза, которая снимает напряжение в спине и животе',
    icon: Icons.accessibility_new,
    steps: [
      'Встаньте на колени на коврик',
      'Сядьте на пятки',
      'Наклонитесь вперёд, вытянув руки',
      'Лоб положите на пол',
      'Расслабьте плечи и спину',
      'Дышите глубоко 1-3 минуты',
    ],
    videoUrl: 'https://youtube.com/watch?v=example2',
  ),
];

const List<CareCategory> careCategories = [
  CareCategory(
    id: 'nutrition',
    title: 'Питание',
    icon: Icons.restaurant,
    color: Colors.green,
    tips: [
      CareTip(
        title: 'Пейте больше воды',
        description: 'Во время менструации организм теряет жидкость. Пейте 8-10 стаканов воды в день.',
      ),
      CareTip(
        title: 'Ешьте продукты с железом',
        description: 'Красное мясо, шпинат, бобовые помогут восполнить потерю железа.',
      ),
      CareTip(
        title: 'Ограничьте соль и кофеин',
        description: 'Это поможет уменьшить вздутие и задержку жидкости.',
      ),
    ],
  ),
  CareCategory(
    id: 'exercise',
    title: 'Физическая активность',
    icon: Icons.fitness_center,
    color: Colors.orange,
    tips: [
      CareTip(
        title: 'Лёгкие упражнения',
        description: 'Йога, растяжка и прогулки помогают уменьшить спазмы.',
      ),
      CareTip(
        title: 'Избегайте интенсивных нагрузок',
        description: 'В первые дни менструации лучше снизить интенсивность тренировок.',
      ),
      CareTip(
        title: 'Дыхательные упражнения',
        description: 'Глубокое дыхание помогает расслабиться и уменьшить боль.',
      ),
    ],
  ),
  CareCategory(
    id: 'sleep',
    title: 'Сон и отдых',
    icon: Icons.bedtime,
    color: Colors.indigo,
    tips: [
      CareTip(
        title: 'Спите 7-9 часов',
        description: 'Достаточный сон помогает организму восстанавливаться.',
      ),
      CareTip(
        title: 'Используйте грелку',
        description: 'Тёплая грелка на животе помогает уменьшить спазмы.',
      ),
      CareTip(
        title: 'Создайте комфортную обстановку',
        description: 'Прохладная, тёмная комната способствует качественному сну.',
      ),
    ],
  ),
  CareCategory(
    id: 'hygiene',
    title: 'Гигиена',
    icon: Icons.clean_hands,
    color: Colors.blue,
    tips: [
      CareTip(
        title: 'Меняйте средства гигиены',
        description: 'Прокладки и тампоны нужно менять каждые 4-6 часов.',
      ),
      CareTip(
        title: 'Используйте мягкие средства',
        description: 'Выбирайте средства без отдушек для интимной гигиены.',
      ),
      CareTip(
        title: 'Носите удобное бельё',
        description: 'Хлопковое бельё обеспечивает комфорт и воздухопроницаемость.',
      ),
    ],
  ),
  CareCategory(
    id: 'mood',
    title: 'Настроение',
    icon: Icons.mood,
    color: Colors.pink,
    tips: [
      CareTip(
        title: 'Практикуйте осознанность',
        description: 'Медитация и осознанное дыхание помогают справиться с перепадами настроения.',
      ),
      CareTip(
        title: 'Общайтесь с близкими',
        description: 'Поддержка друзей и семьи важна в этот период.',
      ),
      CareTip(
        title: 'Занимайтесь любимым делом',
        description: 'Хобби и приятные занятия улучшают эмоциональное состояние.',
      ),
    ],
  ),
];
