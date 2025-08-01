// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_scenario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestScenarioImpl _$$TestScenarioImplFromJson(Map<String, dynamic> json) =>
    _$TestScenarioImpl(
      name: json['name'] as String,
      stateFrames: (json['stateFrames'] as List<dynamic>)
          .map((e) => StateFrame.fromJson(e as Map<String, dynamic>))
          .toList(),
      drawingFrames: (json['drawingFrames'] as List<dynamic>?)
              ?.map((e) => DrawingFrame.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$TestScenarioImplToJson(_$TestScenarioImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'stateFrames': instance.stateFrames,
      'drawingFrames': instance.drawingFrames,
      'createdAt': instance.createdAt.toIso8601String(),
      'metadata': instance.metadata,
    };
