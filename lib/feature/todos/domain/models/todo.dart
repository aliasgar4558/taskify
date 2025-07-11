import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo extends Equatable {
  @JsonKey(name: "id")
  final String id;

  @JsonKey(name: "label")
  final String label;

  @JsonKey(name: "completed")
  final bool completed;

  @JsonKey(name: "createdAt")
  final int createdAt;

  @JsonKey(name: "updatedAt")
  final int updatedAt;

  const Todo({
    required this.id,
    required this.label,
    required this.createdAt,
    required this.updatedAt,
    this.completed = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  Todo copyWith({
    String? label,
    bool? completed,
    int? updatedAt,
  }) => Todo(
    label: label ?? this.label,
    completed: completed ?? this.completed,
    updatedAt: updatedAt ?? this.updatedAt,
    id: id,
    createdAt: createdAt,
  );

  @override
  String toString() =>
      'Todo{id: $id, label: $label, completed: $completed, createdAt: $createdAt, updatedAt: $updatedAt}';

  @override
  List<Object?> get props => [
    id,
    label,
    completed,
  ];
}
