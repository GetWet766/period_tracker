# Implementation Plan: Expressive Navigation Rail

## Overview

Реализация Material 3 Expressive NavigationRail с pill-shaped индикаторами, spring-анимациями и улучшенной визуальной обратной связью. Реализация будет модифицировать существующий `ExpressiveNavigationRail` в `lib/core/common/widgets/expressive_navigation_rail.dart`.

## Tasks

- [x] 1. Создать Expressive defaults и константы
  - [x] 1.1 Создать класс `_ExpressiveNavigationRailDefaults` с новыми значениями
    - minWidth: 88.0dp, minExtendedWidth: 280.0dp
    - indicatorRadius: 28.0dp, indicatorMinSize: 56.0dp
    - selectedIconSize: 28.0dp, unselectedIconSize: 24.0dp
    - hoverOpacity: 0.08, pressOpacity: 0.12, disabledOpacity: 0.38
    - _Requirements: 1.1, 1.2, 3.1, 3.2, 4.1, 4.2, 4.4, 7.3_
  - [ ]* 1.2 Write property test for rail width constraints
    - **Property 6: Rail Width Constraints**
    - **Validates: Requirements 4.1, 4.2**

- [x] 2. Реализовать Spring-анимации
  - [x] 2.1 Создать `_ExpressiveSpringConfig` класс
    - damping: 0.8, stiffness: 300.0, mass: 1.0
    - duration: 400ms
    - _Requirements: 2.1, 2.3, 2.4, 6.4_
  - [x] 2.2 Заменить стандартные AnimationController на spring-based
    - Использовать `SpringSimulation` для selection и extended анимаций
    - _Requirements: 2.1, 2.3_
  - [ ]* 2.3 Write property test for spring animation configuration
    - **Property 2: Spring Animation Configuration**
    - **Validates: Requirements 2.1, 2.3, 2.4, 6.4**

- [x] 3. Реализовать Expressive Indicator
  - [x] 3.1 Создать `_ExpressiveIndicator` виджет
    - Pill-shaped форма с StadiumBorder и радиусом 28dp
    - Минимальные размеры 56x56dp
    - Анимированное расширение в extended режиме
    - _Requirements: 1.1, 1.2, 1.3, 1.4_
  - [ ]* 3.2 Write property test for indicator shape and size
    - **Property 1: Indicator Shape and Size Constraints**
    - **Validates: Requirements 1.1, 1.2**
  - [ ]* 3.3 Write property test for extended mode indicator expansion
    - **Property 7: Extended Mode Indicator Expansion**
    - **Validates: Requirements 1.3, 6.2**

- [x] 4. Checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

- [x] 5. Реализовать Icon Scale Animation
  - [x] 5.1 Добавить scale анимацию для иконок
    - Scale от 1.0 до 1.1 при выборе
    - Использовать spring animation
    - _Requirements: 2.2_
  - [x] 5.2 Обновить icon theme для selected/unselected состояний
    - Selected: 28dp, onSecondaryContainer
    - Unselected: 24dp, onSurfaceVariant
    - _Requirements: 3.3, 3.4, 4.4_
  - [ ]* 5.3 Write property test for icon scale animation
    - **Property 3: Icon Scale Animation**
    - **Validates: Requirements 2.2**
  - [ ]* 5.4 Write property test for icon color based on selection
    - **Property 4: Icon Color Based on Selection State**
    - **Validates: Requirements 3.3, 3.4**

- [x] 6. Реализовать Enhanced Visual Feedback
  - [x] 6.1 Обновить hover и press состояния
    - Hover: 8% opacity primary color
    - Press: 12% opacity primary color
    - _Requirements: 3.1, 3.2_
  - [ ]* 6.2 Write property test for hover and press opacity
    - **Property 5: Hover and Press Opacity**
    - **Validates: Requirements 3.1, 3.2**

- [x] 7. Реализовать Extended Mode Transitions
  - [x] 7.1 Добавить fade и slide анимации для labels
    - Labels fade in после начала расширения
    - Labels fade out до завершения сжатия
    - _Requirements: 6.1, 6.3_
  - [x] 7.2 Обновить indicator expansion в extended режиме
    - Плавное расширение для включения label
    - _Requirements: 6.2_
  - [ ]* 7.3 Write property test for label animation sequencing
    - **Property 8: Label Animation Sequencing**
    - **Validates: Requirements 6.1, 6.3**

- [x] 8. Checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

- [x] 9. Реализовать Disabled State
  - [x] 9.1 Обновить disabled state визуализацию
    - Opacity 0.38 для disabled destinations
    - Блокировка tap events
    - _Requirements: 7.3, 7.4_
  - [ ]* 9.2 Write property test for disabled state behavior
    - **Property 9: Disabled State Behavior**
    - **Validates: Requirements 7.3, 7.4**

- [x] 10. Реализовать Accessibility
  - [x] 10.1 Добавить semantic labels для всех destinations
    - Semantics widget с container и selected properties
    - Index labels для screen readers
    - _Requirements: 5.1, 5.2_
  - [ ]* 10.2 Write property test for semantic accessibility
    - **Property 10: Semantic Accessibility**
    - **Validates: Requirements 5.1**

- [x] 11. Интеграция и финализация
  - [x] 11.1 Обновить `_RailDestination` для использования новых компонентов
    - Интегрировать _ExpressiveIndicator
    - Интегрировать spring animations
    - Интегрировать scale animations
    - _Requirements: All_
  - [x] 11.2 Обновить `_ExpressiveNavigationRailState.build()` метод
    - Использовать новые defaults
    - Применить expressive styling
    - _Requirements: All_

- [x] 12. Final checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

## Notes

- Tasks marked with `*` are optional and can be skipped for faster MVP
- Each task references specific requirements for traceability
- Checkpoints ensure incremental validation
- Property tests validate universal correctness properties
- Unit tests validate specific examples and edge cases
- Реализация модифицирует существующий файл `lib/core/common/widgets/expressive_navigation_rail.dart`
