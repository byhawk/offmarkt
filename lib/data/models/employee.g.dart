// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeImpl _$$EmployeeImplFromJson(Map<String, dynamic> json) =>
    _$EmployeeImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      position: json['position'] as String,
      salary: (json['salary'] as num).toDouble(),
      morale: (json['morale'] as num).toDouble(),
      hiredAt: DateTime.parse(json['hiredAt'] as String),
    );

Map<String, dynamic> _$$EmployeeImplToJson(_$EmployeeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'position': instance.position,
      'salary': instance.salary,
      'morale': instance.morale,
      'hiredAt': instance.hiredAt.toIso8601String(),
    };
