import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// Base interface for serializing and deserializing values.
abstract class ValueSerializer<T> {
  /// Serializes a value to a JSON-compatible format.
  Map<String, dynamic> serialize(T value);

  /// Deserializes a value from a JSON format.
  T deserialize(Map<String, dynamic> json);

  /// The type this serializer handles.
  Type get type;
}

/// Registry of serializers for different value types.
class SerializerRegistry {
  static final Map<Type, ValueSerializer> _serializers = {
    Color: ColorSerializer(),
    Duration: DurationSerializer(),
    Offset: OffsetSerializer(),
    Size: SizeSerializer(),
    Rect: RectSerializer(),
    EdgeInsets: EdgeInsetsSerializer(),
    BoxShadow: BoxShadowSerializer(),
    TextStyle: TextStyleSerializer(),
  };

  /// Gets a serializer for the given type.
  static ValueSerializer<T>? getSerializer<T>() {
    return _serializers[T] as ValueSerializer<T>?;
  }

  /// Registers a custom serializer.
  static void registerSerializer<T>(ValueSerializer<T> serializer) {
    _serializers[T] = serializer;
  }

  /// Serializes any supported value to JSON.
  static Map<String, dynamic>? serializeValue(dynamic value) {
    if (value == null) return null;
    
    // Handle Color and MaterialColor together
    if (value is Color) {
      return {
        'type': 'Color',
        'value': ColorSerializer().serialize(value),
      };
    }
    
    final serializer = _serializers[value.runtimeType];
    if (serializer != null) {
      return {
        'type': value.runtimeType.toString(),
        'value': serializer.serialize(value),
      };
    }
    
    // Handle primitive types
    if (value is String || value is num || value is bool) {
      return {
        'type': value.runtimeType.toString(),
        'value': value,
      };
    }
    
    // Handle enums
    if (value is Enum) {
      return {
        'type': value.runtimeType.toString(),
        'value': value.name,
      };
    }
    
    throw UnsupportedError('Cannot serialize type ${value.runtimeType}');
  }

  /// Deserializes a value from JSON.
  static T deserializeValue<T>(Map<String, dynamic> json) {
    final typeString = json['type'] as String;
    final valueData = json['value'];
    
    // Handle null
    if (valueData == null) return null as T;
    
    // Handle primitives
    if (valueData is String || valueData is num || valueData is bool) {
      return valueData as T;
    }
    
    // Find serializer by type string
    for (final entry in _serializers.entries) {
      if (entry.key.toString() == typeString) {
        return entry.value.deserialize(valueData as Map<String, dynamic>) as T;
      }
    }
    
    throw UnsupportedError('Cannot deserialize type $typeString');
  }
}

/// Serializer for [Color] values.
class ColorSerializer implements ValueSerializer<Color> {
  @override
  Type get type => Color;

  @override
  Map<String, dynamic> serialize(Color value) {
    return {'value': value.toARGB32()};
  }

  @override
  Color deserialize(Map<String, dynamic> json) {
    return Color(json['value'] as int);
  }
}

/// Serializer for [Duration] values.
class DurationSerializer implements ValueSerializer<Duration> {
  @override
  Type get type => Duration;

  @override
  Map<String, dynamic> serialize(Duration value) {
    return {'microseconds': value.inMicroseconds};
  }

  @override
  Duration deserialize(Map<String, dynamic> json) {
    return Duration(microseconds: json['microseconds'] as int);
  }
}

/// Serializer for [Offset] values.
class OffsetSerializer implements ValueSerializer<Offset> {
  @override
  Type get type => Offset;

  @override
  Map<String, dynamic> serialize(Offset value) {
    return {'dx': value.dx, 'dy': value.dy};
  }

  @override
  Offset deserialize(Map<String, dynamic> json) {
    return Offset(json['dx'] as double, json['dy'] as double);
  }
}

/// Serializer for [Size] values.
class SizeSerializer implements ValueSerializer<Size> {
  @override
  Type get type => Size;

  @override
  Map<String, dynamic> serialize(Size value) {
    return {'width': value.width, 'height': value.height};
  }

  @override
  Size deserialize(Map<String, dynamic> json) {
    return Size(json['width'] as double, json['height'] as double);
  }
}

/// Serializer for [Rect] values.
class RectSerializer implements ValueSerializer<Rect> {
  @override
  Type get type => Rect;

  @override
  Map<String, dynamic> serialize(Rect value) {
    return {
      'left': value.left,
      'top': value.top,
      'right': value.right,
      'bottom': value.bottom,
    };
  }

  @override
  Rect deserialize(Map<String, dynamic> json) {
    return Rect.fromLTRB(
      json['left'] as double,
      json['top'] as double,
      json['right'] as double,
      json['bottom'] as double,
    );
  }
}

/// Serializer for [EdgeInsets] values.
class EdgeInsetsSerializer implements ValueSerializer<EdgeInsets> {
  @override
  Type get type => EdgeInsets;

  @override
  Map<String, dynamic> serialize(EdgeInsets value) {
    return {
      'left': value.left,
      'top': value.top,
      'right': value.right,
      'bottom': value.bottom,
    };
  }

  @override
  EdgeInsets deserialize(Map<String, dynamic> json) {
    return EdgeInsets.fromLTRB(
      json['left'] as double,
      json['top'] as double,
      json['right'] as double,
      json['bottom'] as double,
    );
  }
}

/// Serializer for [BoxShadow] values.
class BoxShadowSerializer implements ValueSerializer<BoxShadow> {
  @override
  Type get type => BoxShadow;

  @override
  Map<String, dynamic> serialize(BoxShadow value) {
    return {
      'color': ColorSerializer().serialize(value.color),
      'offset': OffsetSerializer().serialize(value.offset),
      'blurRadius': value.blurRadius,
      'spreadRadius': value.spreadRadius,
    };
  }

  @override
  BoxShadow deserialize(Map<String, dynamic> json) {
    return BoxShadow(
      color: ColorSerializer().deserialize(json['color'] as Map<String, dynamic>),
      offset: OffsetSerializer().deserialize(json['offset'] as Map<String, dynamic>),
      blurRadius: json['blurRadius'] as double,
      spreadRadius: json['spreadRadius'] as double,
    );
  }
}

/// Serializer for [TextStyle] values.
class TextStyleSerializer implements ValueSerializer<TextStyle> {
  @override
  Type get type => TextStyle;

  @override
  Map<String, dynamic> serialize(TextStyle value) {
    return {
      if (value.color != null) 'color': ColorSerializer().serialize(value.color!),
      if (value.fontSize != null) 'fontSize': value.fontSize,
      if (value.fontWeight != null) 'fontWeight': value.fontWeight!.index,
      if (value.fontStyle != null) 'fontStyle': value.fontStyle!.index,
      if (value.letterSpacing != null) 'letterSpacing': value.letterSpacing,
      if (value.wordSpacing != null) 'wordSpacing': value.wordSpacing,
      if (value.height != null) 'height': value.height,
    };
  }

  @override
  TextStyle deserialize(Map<String, dynamic> json) {
    return TextStyle(
      color: json['color'] != null 
        ? ColorSerializer().deserialize(json['color'] as Map<String, dynamic>)
        : null,
      fontSize: json['fontSize'] as double?,
      fontWeight: json['fontWeight'] != null 
        ? FontWeight.values[json['fontWeight'] as int]
        : null,
      fontStyle: json['fontStyle'] != null 
        ? FontStyle.values[json['fontStyle'] as int]
        : null,
      letterSpacing: json['letterSpacing'] as double?,
      wordSpacing: json['wordSpacing'] as double?,
      height: json['height'] as double?,
    );
  }
}