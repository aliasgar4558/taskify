import 'package:json_annotation/json_annotation.dart';
import 'package:taskify/feature/todos/domain/models/todo.dart';

part 'todo_list_response.g.dart';

@JsonSerializable()
class TodoListResponse {
  final List<Todo> todos;

  const TodoListResponse({
    this.todos = const [],
  });

  factory TodoListResponse.fromJson(Map<String, dynamic> json) => _$TodoListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TodoListResponseToJson(this);
}
