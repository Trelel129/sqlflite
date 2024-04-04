
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite1_todolist/database/todo_db.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {

    // Check if the database already exists
    if (_database != null){
      return _database!;
    }

    _database = await _initialize();
    return _database!;

  }

  // Get the default database location/path of the device
  Future<String> get fullPath async {
    const name = 'todo.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  // Initialize database on the default location/path
  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      // Version of the dataset
      version: 1,
      // Create database using this function if it does not exist yet
      onCreate: create,
      singleInstance: true,
    );
    return database;
  }

  // Create the actual database
  Future<void> create(Database database, int version) async => await TodoDB().createTable(database);

}