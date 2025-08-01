// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawing_frame.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DrawingFrameImpl _$$DrawingFrameImplFromJson(Map<String, dynamic> json) =>
    _$DrawingFrameImpl(
      timestamp: Duration(microseconds: (json['timestamp'] as num).toInt()),
      commands:
          DrawingCommands.fromJson(json['commands'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DrawingFrameImplToJson(_$DrawingFrameImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.inMicroseconds,
      'commands': instance.commands,
    };

_$DrawingCommandsImpl _$$DrawingCommandsImplFromJson(
        Map<String, dynamic> json) =>
    _$DrawingCommandsImpl(
      operations: (json['operations'] as List<dynamic>)
          .map((e) => DrawingOperation.fromJson(e as Map<String, dynamic>))
          .toList(),
      canvasSize: _sizeFromJson(json['canvasSize'] as Map<String, dynamic>?),
      clipBounds: _rectFromJson(json['clipBounds'] as Map<String, dynamic>?),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$DrawingCommandsImplToJson(
        _$DrawingCommandsImpl instance) =>
    <String, dynamic>{
      'operations': instance.operations,
      'canvasSize': _sizeToJson(instance.canvasSize),
      'clipBounds': _rectToJson(instance.clipBounds),
      'metadata': instance.metadata,
    };

_$DrawRectImpl _$$DrawRectImplFromJson(Map<String, dynamic> json) =>
    _$DrawRectImpl(
      rect: _rectFromMap(json['rect'] as Map<String, dynamic>),
      paint: json['paint'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DrawRectImplToJson(_$DrawRectImpl instance) =>
    <String, dynamic>{
      'rect': _rectToMap(instance.rect),
      'paint': instance.paint,
      'runtimeType': instance.$type,
    };

_$DrawCircleImpl _$$DrawCircleImplFromJson(Map<String, dynamic> json) =>
    _$DrawCircleImpl(
      center: _offsetFromMap(json['center'] as Map<String, dynamic>),
      radius: (json['radius'] as num).toDouble(),
      paint: json['paint'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DrawCircleImplToJson(_$DrawCircleImpl instance) =>
    <String, dynamic>{
      'center': _offsetToMap(instance.center),
      'radius': instance.radius,
      'paint': instance.paint,
      'runtimeType': instance.$type,
    };

_$DrawOvalImpl _$$DrawOvalImplFromJson(Map<String, dynamic> json) =>
    _$DrawOvalImpl(
      rect: _rectFromMap(json['rect'] as Map<String, dynamic>),
      paint: json['paint'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DrawOvalImplToJson(_$DrawOvalImpl instance) =>
    <String, dynamic>{
      'rect': _rectToMap(instance.rect),
      'paint': instance.paint,
      'runtimeType': instance.$type,
    };

_$DrawLineImpl _$$DrawLineImplFromJson(Map<String, dynamic> json) =>
    _$DrawLineImpl(
      p1: _offsetFromMap(json['p1'] as Map<String, dynamic>),
      p2: _offsetFromMap(json['p2'] as Map<String, dynamic>),
      paint: json['paint'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DrawLineImplToJson(_$DrawLineImpl instance) =>
    <String, dynamic>{
      'p1': _offsetToMap(instance.p1),
      'p2': _offsetToMap(instance.p2),
      'paint': instance.paint,
      'runtimeType': instance.$type,
    };

_$DrawPathImpl _$$DrawPathImplFromJson(Map<String, dynamic> json) =>
    _$DrawPathImpl(
      pathData: json['pathData'] as String,
      paint: json['paint'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DrawPathImplToJson(_$DrawPathImpl instance) =>
    <String, dynamic>{
      'pathData': instance.pathData,
      'paint': instance.paint,
      'runtimeType': instance.$type,
    };

_$DrawTextImpl _$$DrawTextImplFromJson(Map<String, dynamic> json) =>
    _$DrawTextImpl(
      text: json['text'] as String,
      offset: _offsetFromMap(json['offset'] as Map<String, dynamic>),
      textStyle: json['textStyle'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DrawTextImplToJson(_$DrawTextImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'offset': _offsetToMap(instance.offset),
      'textStyle': instance.textStyle,
      'runtimeType': instance.$type,
    };

_$DrawImageImpl _$$DrawImageImplFromJson(Map<String, dynamic> json) =>
    _$DrawImageImpl(
      offset: _offsetFromMap(json['offset'] as Map<String, dynamic>),
      size: _sizeFromMap(json['size'] as Map<String, dynamic>),
      imageHash: json['imageHash'] as String,
      paint: json['paint'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DrawImageImplToJson(_$DrawImageImpl instance) =>
    <String, dynamic>{
      'offset': _offsetToMap(instance.offset),
      'size': _sizeToMap(instance.size),
      'imageHash': instance.imageHash,
      'paint': instance.paint,
      'runtimeType': instance.$type,
    };

_$DrawPointsImpl _$$DrawPointsImplFromJson(Map<String, dynamic> json) =>
    _$DrawPointsImpl(
      points: _offsetListFromJson(json['points'] as List),
      pointMode: json['pointMode'] as String,
      paint: json['paint'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DrawPointsImplToJson(_$DrawPointsImpl instance) =>
    <String, dynamic>{
      'points': _offsetListToJson(instance.points),
      'pointMode': instance.pointMode,
      'paint': instance.paint,
      'runtimeType': instance.$type,
    };

_$DrawRoundedRectImpl _$$DrawRoundedRectImplFromJson(
        Map<String, dynamic> json) =>
    _$DrawRoundedRectImpl(
      rect: _rectFromMap(json['rect'] as Map<String, dynamic>),
      radiusX: (json['radiusX'] as num).toDouble(),
      radiusY: (json['radiusY'] as num).toDouble(),
      paint: json['paint'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DrawRoundedRectImplToJson(
        _$DrawRoundedRectImpl instance) =>
    <String, dynamic>{
      'rect': _rectToMap(instance.rect),
      'radiusX': instance.radiusX,
      'radiusY': instance.radiusY,
      'paint': instance.paint,
      'runtimeType': instance.$type,
    };

_$DrawCustomImpl _$$DrawCustomImplFromJson(Map<String, dynamic> json) =>
    _$DrawCustomImpl(
      operationType: json['operationType'] as String,
      parameters: json['parameters'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DrawCustomImplToJson(_$DrawCustomImpl instance) =>
    <String, dynamic>{
      'operationType': instance.operationType,
      'parameters': instance.parameters,
      'runtimeType': instance.$type,
    };
