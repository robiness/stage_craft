# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

**Testing:**
- `flutter test` - Run all tests
- `flutter test test/controls/value_control_test.dart` - Run specific test file

**Analysis and Linting:**
- `flutter analyze` - Run static analysis (uses lint package rules)
- Analysis configuration is in `analysis_options.yaml` with `public_member_api_docs` rule enforced

**Building:**
- `flutter pub get` - Install dependencies
- `cd example && flutter run` - Run the example app for testing

## Architecture Overview

StageCraft is a Flutter package for developing and testing UI widgets in a controlled environment. The architecture follows a clear separation between:

### Core Components

**Stage System (`lib/src/stage/`):**
- `StageBuilder` - Main widget that creates a stage environment with controls sidebar
- `StageCanvas` - Interactive canvas where widgets are displayed and manipulated
- `StageCanvasController` - Controls zoom, rulers, crosshair, text scaling
- `StageRect` - Positioning and constraint handling for staged widgets
- `control_bar.dart` - Sidebar containing all widget controls
- `stage_style.dart` - Theming and visual styling system

**Control System (`lib/src/controls/`):**
- `ValueControl<T>` - Abstract base class for all widget parameter controls
- Concrete implementations: `BoolControl`, `StringControl`, `IntControl`, `DoubleControl`, `ColorControl`, etc.
- `ControlGroup` - Groups related controls together
- Each control provides a `builder()` method returning a widget for the control sidebar

**Widget Layer (`lib/src/widgets/`):**
- Custom UI components for the stage environment
- `StageCraftColorPicker`, `StageCraftTextField`, etc.

### Key Patterns

**Control Pattern:**
- All controls extend `ValueControl<T>` which extends `ValueNotifier<T>`
- Controls handle validation (min/max values), null handling, and change notifications
- Widget rebuilds happen automatically via `ListenableBuilder` in stage.dart:470

**Stage Interaction:**
- Interactive canvas with zoom, pan, resize handles
- Rulers, measurement grid, and crosshair for precise positioning
- Stage modes: standard (full controls) vs preview (widget only)

**Hot Reload Support:**
- Uses `_hotReloadListener` (stage.dart:274) to trigger rebuilds during development
- `KeyedSubtree` ensures widgets rebuild properly with hot reload

## Testing

Uses `spot` package for widget testing instead of standard Flutter test finders. Key testing patterns:
- `await tester.pumpControl()` helper for testing controls
- `spotControl<T>()` helper for finding controls in tests
- Test coverage for control validation, null handling, and value persistence