import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:dsw52703/models/note.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    db.execute('''
    CREATE TABLE $tableNotes ( 
      ${NoteFields.id} $idType, 
      ${NoteFields.number} $integerType,
      ${NoteFields.isFavourite} $boolType,
      ${NoteFields.title} $textType,
      ${NoteFields.createdTime} $textType,
      ${NoteFields.data} $textType
    )
    ''');
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.number}, ${NoteFields.isFavourite}, ${NoteFields.title}, ${NoteFields.createdTime}, ${NoteFields.data}';
    // final values =
    //     '${json[NoteFields.number]}, ${json[NoteFields.isFavourite] ? 1 : 0}, "${json[NoteFields.title]}", "${json[NoteFields.createdTime]}", "${json[NoteFields.data]}"';


    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future<Note> readNote (int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future <List<Note>> readAllNotes() async {
    final db = await instance.database;

    final result = await db.query(tableNotes);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }


}