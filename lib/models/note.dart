final String tableNotes = 'notes';

class NoteFields{
  static final List<String> values = [
    id, number, isFavourite, title, createdTime, data
  ];

  static final String id = 'id';
  static final String number = 'number';
  static final String isFavourite = 'isFavourite';
  static final String title = 'title';
  static final String createdTime = 'createdTime';
  static final String data = 'data';
}


class Note{
  final int? id;
  final int number;
  final bool isFavourite;
  final String title;
  final String createdTime;
  final String data;

  const Note({
    this.id,
    required this.number,
    required this.isFavourite,
    required this.title,
    required this.createdTime,
    required this.data,
  });

  Map<String, Object?> toJson() => {
    NoteFields.id: id,
    NoteFields.number: number,
    NoteFields.isFavourite: isFavourite ? 1 : 0,
    NoteFields.title: title,
    NoteFields.createdTime: createdTime,
    NoteFields.data: data,
  };

 static Note fromJson(Map<String, Object?> json) => Note(
    id: json[NoteFields.id] as int?,
    number: json[NoteFields.number] as int,
    isFavourite: json[NoteFields.isFavourite] == 1,
    title: json[NoteFields.title] as String,
    createdTime: json[NoteFields.createdTime] as String,
    data: json[NoteFields.data] as String,
  );

  Note copy({
    int? id,
    int? number,
    bool? isFavourite,
    String? title,
    String? createdTime,
    String? data,
  }) => Note(
    id: id ?? this.id,
    number: number ?? this.number,
    isFavourite: isFavourite ?? this.isFavourite,
    title: title ?? this.title,
    createdTime: createdTime ?? this.createdTime,
    data: data ?? this.data,
  );
}