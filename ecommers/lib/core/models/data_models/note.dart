import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  final int id;
  final String title;
  final String imageUrl;
  final String commandText;
  final String description;
  final String shortDescription;

  Note(
    this.id,
    this.title,
    this.imageUrl,
    this.commandText,
    this.description,
    this.shortDescription,
  );

  static const fromJsonFactory = _$NoteFromJson;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
