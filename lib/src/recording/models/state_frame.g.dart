// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_frame.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StateFrameImpl _$$StateFrameImplFromJson(Map<String, dynamic> json) =>
    _$StateFrameImpl(
      timestamp: Duration(microseconds: (json['timestamp'] as num).toInt()),
      controlValues: json['controlValues'] as Map<String, dynamic>,
      canvasState: json['canvasState'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$StateFrameImplToJson(_$StateFrameImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.inMicroseconds,
      'controlValues': instance.controlValues,
      'canvasState': instance.canvasState,
    };
