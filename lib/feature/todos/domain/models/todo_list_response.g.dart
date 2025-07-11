// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoListResponse _$TodoListResponseFromJson(Map<String, dynamic> json) =>
    TodoListResponse(
      todos:
          (json['todos'] as List<dynamic>?)
              ?.map((e) => Todo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TodoListResponseToJson(TodoListResponse instance) =>
    <String, dynamic>{'todos': instance.todos.map((e) => e.toJson()).toList()};
