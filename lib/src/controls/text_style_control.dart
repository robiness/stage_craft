import 'package:flutter/material.dart';
import 'package:stage_craft/src/controls/control.dart';
import 'package:stage_craft/src/widgets/default_control_bar_row.dart';
import 'package:stage_craft/src/widgets/stage_craft_color_picker.dart';
import 'package:stage_craft/src/widgets/stage_craft_hover_control.dart';
import 'package:stage_craft/src/widgets/stage_craft_text_field.dart';

/// A control to modify a TextStyle parameter with organized, collapsible sections.
class TextStyleControl extends ValueControl<TextStyle> {
  /// Creates a TextStyle control.
  TextStyleControl({
    required super.initialValue,
    required super.label,
  })  : _fontSize = initialValue.fontSize ?? 14.0,
        _color = initialValue.color ?? Colors.black,
        _fontWeight = initialValue.fontWeight ?? FontWeight.normal,
        _fontStyle = initialValue.fontStyle ?? FontStyle.normal,
        _letterSpacing = initialValue.letterSpacing ?? 0.0,
        _wordSpacing = initialValue.wordSpacing ?? 0.0,
        _height = initialValue.height ?? 1.0,
        _decoration = initialValue.decoration ?? TextDecoration.none,
        _decorationColor = initialValue.decorationColor,
        _fontFamily = initialValue.fontFamily;

  // Core properties
  double _fontSize;
  Color _color;
  FontWeight _fontWeight;

  // Typography properties
  FontStyle _fontStyle;
  double _letterSpacing;
  double _wordSpacing;
  double _height;
  String? _fontFamily;

  // Style properties
  TextDecoration _decoration;
  Color? _decorationColor;

  // Expansion state for sections
  bool _typographyExpanded = false;
  bool _styleExpanded = false;

  late final TextEditingController _fontSizeController =
      TextEditingController(text: _fontSize.toString());
  late final TextEditingController _letterSpacingController =
      TextEditingController(text: _letterSpacing.toString());
  late final TextEditingController _wordSpacingController =
      TextEditingController(text: _wordSpacing.toString());
  late final TextEditingController _heightController =
      TextEditingController(text: _height.toString());
  late final TextEditingController _fontFamilyController =
      TextEditingController(text: _fontFamily ?? '');

  void _updateTextStyle() {
    value = TextStyle(
      fontSize: _fontSize,
      color: _color,
      fontWeight: _fontWeight,
      fontStyle: _fontStyle,
      letterSpacing: _letterSpacing,
      wordSpacing: _wordSpacing,
      height: _height,
      decoration: _decoration,
      decorationColor: _decorationColor,
      fontFamily: _fontFamily?.isNotEmpty == true ? _fontFamily : null,
    );
  }

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Core properties - always visible
          _TextStyleCoreSection(
            fontSize: _fontSize,
            color: _color,
            fontWeight: _fontWeight,
            fontSizeController: _fontSizeController,
            onFontSizeChanged: (size) {
              _fontSize = size;
              _updateTextStyle();
            },
            onColorChanged: (color) {
              _color = color;
              _updateTextStyle();
            },
            onFontWeightChanged: (weight) {
              _fontWeight = weight;
              _updateTextStyle();
            },
          ),
          
          const SizedBox(height: 8),
          
          // Typography section - collapsible
          _TextStyleSection(
            title: 'Typography',
            isExpanded: _typographyExpanded,
            onToggle: () {
              _typographyExpanded = !_typographyExpanded;
              notifyListeners();
            },
            child: _typographyExpanded ? _TextStyleTypographySection(
              fontStyle: _fontStyle,
              letterSpacing: _letterSpacing,
              wordSpacing: _wordSpacing,
              height: _height,
              fontFamily: _fontFamily,
              letterSpacingController: _letterSpacingController,
              wordSpacingController: _wordSpacingController,
              heightController: _heightController,
              fontFamilyController: _fontFamilyController,
              onFontStyleChanged: (style) {
                _fontStyle = style;
                _updateTextStyle();
              },
              onLetterSpacingChanged: (spacing) {
                _letterSpacing = spacing;
                _updateTextStyle();
              },
              onWordSpacingChanged: (spacing) {
                _wordSpacing = spacing;
                _updateTextStyle();
              },
              onHeightChanged: (height) {
                _height = height;
                _updateTextStyle();
              },
              onFontFamilyChanged: (family) {
                _fontFamily = family.isNotEmpty ? family : null;
                _updateTextStyle();
              },
            ) : null,
          ),
          
          const SizedBox(height: 4),
          
          // Style section - collapsible
          _TextStyleSection(
            title: 'Decoration',
            isExpanded: _styleExpanded,
            onToggle: () {
              _styleExpanded = !_styleExpanded;
              notifyListeners();
            },
            child: _styleExpanded ? _TextStyleDecorationSection(
              decoration: _decoration,
              decorationColor: _decorationColor,
              onDecorationChanged: (decoration) {
                _decoration = decoration;
                _updateTextStyle();
              },
              onDecorationColorChanged: (color) {
                _decorationColor = color;
                _updateTextStyle();
              },
            ) : null,
          ),
        ],
      ),
    );
  }
}

/// Widget for collapsible sections.
class _TextStyleSection extends StatelessWidget {
  const _TextStyleSection({
    required this.title,
    required this.isExpanded,
    required this.onToggle,
    this.child,
  });

  final String title;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with expand/collapse button
          GestureDetector(
            onTap: onToggle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content
          if (child != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            ),
        ],
      ),
    );
  }
}

/// Widget for core TextStyle properties (always visible).
class _TextStyleCoreSection extends StatelessWidget {
  const _TextStyleCoreSection({
    required this.fontSize,
    required this.color,
    required this.fontWeight,
    required this.fontSizeController,
    required this.onFontSizeChanged,
    required this.onColorChanged,
    required this.onFontWeightChanged,
  });

  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextEditingController fontSizeController;
  final ValueChanged<double> onFontSizeChanged;
  final ValueChanged<Color> onColorChanged;
  final ValueChanged<FontWeight> onFontWeightChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Font size
        Row(
          children: [
            Expanded(
              child: Text(
                'Size',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 60,
              child: StageCraftTextField(
                controller: fontSizeController,
                onChanged: (value) {
                  final size = double.tryParse(value) ?? fontSize;
                  onFontSizeChanged(size);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        
        // Color
        Row(
          children: [
            Expanded(
              child: Text(
                'Color',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const SizedBox(width: 8),
            StageCraftColorPicker(
              initialColor: color,
              onColorSelected: onColorChanged,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    height: 24,
                    width: 48,
                    color: color,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        
        // Font weight
        StageCraftHoverControl(
          child: DropdownButton<FontWeight>(
            style: Theme.of(context).textTheme.labelSmall,
            borderRadius: BorderRadius.circular(4),
            value: fontWeight,
            onChanged: (FontWeight? newWeight) {
              if (newWeight != null) {
                onFontWeightChanged(newWeight);
              }
            },
            isDense: true,
            itemHeight: null,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            underline: const SizedBox(),
            isExpanded: true,
            items: const [
              DropdownMenuItem(value: FontWeight.w100, child: Text('Thin')),
              DropdownMenuItem(value: FontWeight.w200, child: Text('Extra Light')),
              DropdownMenuItem(value: FontWeight.w300, child: Text('Light')),
              DropdownMenuItem(value: FontWeight.w400, child: Text('Regular')),
              DropdownMenuItem(value: FontWeight.w500, child: Text('Medium')),
              DropdownMenuItem(value: FontWeight.w600, child: Text('Semi Bold')),
              DropdownMenuItem(value: FontWeight.w700, child: Text('Bold')),
              DropdownMenuItem(value: FontWeight.w800, child: Text('Extra Bold')),
              DropdownMenuItem(value: FontWeight.w900, child: Text('Black')),
            ],
          ),
        ),
      ],
    );
  }
}

/// Widget for typography properties.
class _TextStyleTypographySection extends StatelessWidget {
  const _TextStyleTypographySection({
    required this.fontStyle,
    required this.letterSpacing,
    required this.wordSpacing,
    required this.height,
    required this.fontFamily,
    required this.letterSpacingController,
    required this.wordSpacingController,
    required this.heightController,
    required this.fontFamilyController,
    required this.onFontStyleChanged,
    required this.onLetterSpacingChanged,
    required this.onWordSpacingChanged,
    required this.onHeightChanged,
    required this.onFontFamilyChanged,
  });

  final FontStyle fontStyle;
  final double letterSpacing;
  final double wordSpacing;
  final double height;
  final String? fontFamily;
  final TextEditingController letterSpacingController;
  final TextEditingController wordSpacingController;
  final TextEditingController heightController;
  final TextEditingController fontFamilyController;
  final ValueChanged<FontStyle> onFontStyleChanged;
  final ValueChanged<double> onLetterSpacingChanged;
  final ValueChanged<double> onWordSpacingChanged;
  final ValueChanged<double> onHeightChanged;
  final ValueChanged<String> onFontFamilyChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Font style
        StageCraftHoverControl(
          child: DropdownButton<FontStyle>(
            style: Theme.of(context).textTheme.labelSmall,
            borderRadius: BorderRadius.circular(4),
            value: fontStyle,
            onChanged: (FontStyle? newStyle) {
              if (newStyle != null) {
                onFontStyleChanged(newStyle);
              }
            },
            isDense: true,
            itemHeight: null,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            underline: const SizedBox(),
            isExpanded: true,
            items: const [
              DropdownMenuItem(value: FontStyle.normal, child: Text('Normal')),
              DropdownMenuItem(value: FontStyle.italic, child: Text('Italic')),
            ],
          ),
        ),
        const SizedBox(height: 4),
        
        // Font family
        StageCraftTextField(
          controller: fontFamilyController,
          onChanged: onFontFamilyChanged,
        ),
        const SizedBox(height: 4),
        
        // Letter spacing
        Row(
          children: [
            Expanded(
              child: Text(
                'Letter',
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                'Word',
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Expanded(
              child: StageCraftTextField(
                controller: letterSpacingController,
                onChanged: (value) {
                  final spacing = double.tryParse(value) ?? letterSpacing;
                  onLetterSpacingChanged(spacing);
                },
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: StageCraftTextField(
                controller: wordSpacingController,
                onChanged: (value) {
                  final spacing = double.tryParse(value) ?? wordSpacing;
                  onWordSpacingChanged(spacing);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        
        // Line height
        Row(
          children: [
            Expanded(
              child: Text(
                'Line Height',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 60,
              child: StageCraftTextField(
                controller: heightController,
                onChanged: (value) {
                  final lineHeight = double.tryParse(value) ?? height;
                  onHeightChanged(lineHeight);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Widget for decoration properties.
class _TextStyleDecorationSection extends StatelessWidget {
  const _TextStyleDecorationSection({
    required this.decoration,
    required this.decorationColor,
    required this.onDecorationChanged,
    required this.onDecorationColorChanged,
  });

  final TextDecoration decoration;
  final Color? decorationColor;
  final ValueChanged<TextDecoration> onDecorationChanged;
  final ValueChanged<Color?> onDecorationColorChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Decoration type
        StageCraftHoverControl(
          child: DropdownButton<TextDecoration>(
            style: Theme.of(context).textTheme.labelSmall,
            borderRadius: BorderRadius.circular(4),
            value: decoration,
            onChanged: (TextDecoration? newDecoration) {
              if (newDecoration != null) {
                onDecorationChanged(newDecoration);
              }
            },
            isDense: true,
            itemHeight: null,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            underline: const SizedBox(),
            isExpanded: true,
            items: const [
              DropdownMenuItem(value: TextDecoration.none, child: Text('None')),
              DropdownMenuItem(value: TextDecoration.underline, child: Text('Underline')),
              DropdownMenuItem(value: TextDecoration.overline, child: Text('Overline')),
              DropdownMenuItem(value: TextDecoration.lineThrough, child: Text('Line Through')),
            ],
          ),
        ),
        const SizedBox(height: 4),
        
        // Decoration color
        if (decoration != TextDecoration.none)
          Row(
            children: [
              Expanded(
                child: Text(
                  'Decoration Color',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
              const SizedBox(width: 8),
              StageCraftColorPicker(
                initialColor: decorationColor ?? Colors.black,
                onColorSelected: onDecorationColorChanged,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      height: 24,
                      width: 48,
                      color: decorationColor ?? Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

/// A control to modify a nullable TextStyle parameter.
class TextStyleControlNullable extends ValueControl<TextStyle?> {
  /// Creates a nullable TextStyle control.
  TextStyleControlNullable({
    super.initialValue,
    required super.label,
  });

  @override
  Widget builder(BuildContext context) {
    return DefaultControlBarRow(
      control: this,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'TextStyle (nullable) - TODO: Implement',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
