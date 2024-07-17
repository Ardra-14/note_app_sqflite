import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:my_app/models/note.dart';

class DatabaseHelper{

  static DatabaseHelper? _databaseHelper;//singleton DatabaseHelper
  static Database? _database;//singleton database object

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String  colDescription = 'description';
  String colDate = 'date';

  DatabaseHelper._createInstance(); //named constructor to create instance of DatabaseHelper

  factory DatabaseHelper(){

    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();//this is executed once ,singleton object
    }
    return _databaseHelper!;
  }

  Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database!;
  } 

  Future <Database>initializeDatabase() async{
    //get the directory path for both android and ios to store database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    //open/create a database at a given path

    var notesDatabase = await openDatabase(path,version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT, $colDate TEXT)');
  }


  //fetch operation

  Future<List<Map<String, dynamic>>> getNoteMapList() async{
    Database db = await this.database;
    // var result = await db.rawQuery('SELECT * FROM $noteTable order by $colDate ASC');
    var result = await db.query(noteTable, orderBy: '$colDate ASC');
    return result;
  }

  //insert

  Future<int> insertNote(Note note) async{
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  //update

  Future<int> updateNote(Note note) async{
    Database db = await this.database;
    var result = await db.update(noteTable, note.toMap(),where: '$colId = ?',whereArgs: [note.id]);
    return result;
  }

  //delete

  Future<int> deleteNote(int id) async{
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

 


  // get the 'Map List' List<Map> and convert it to 'Note List' List<Note>

  Future <List<Note>> getNoteList() async{
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;

    List<Note> noteList = [];
    for (var i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }

}