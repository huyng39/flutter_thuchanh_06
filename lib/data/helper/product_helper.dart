import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_thuchanh_06/data/model/product.dart';

class DatabaseHelper {
  // Singleton pattern
  static final DatabaseHelper _databaseService = DatabaseHelper._internal();
  factory DatabaseHelper() => _databaseService;
  DatabaseHelper._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, 'db_product.db');
    print(
        "Đường dẫn database: $databasePath"); // in đường dẫn chứa file database
    return await openDatabase(path, onCreate: _onCreate, version: 1
        // ,
        // onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
        );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE product(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, price INTEGER, img TEXT, desc TEXT, catID INTEGER, FOREIGN KEY (catID) REFERENCES category(id))',
    );
  }

  Future<void> insertCategory(Product_Model productModel) async {
    final db = await _databaseService.database;

    await db.insert(
      'product',
      productModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Product_Model>> products() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('product');
    return List.generate(
        maps.length, (index) => Product_Model.fromMap(maps[index]));
  }

  Future<Product_Model> product(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('product', where: 'id = ?', whereArgs: [id]);
    return Product_Model.fromMap(maps[0]);
  }

  Future<void> updateProduct(Product_Model pro) async {
    final db = await _databaseService.database;
    await db.update(
      'product',
      pro.toMap(),
      where: 'id = ?',
      whereArgs: [pro.id],
    );
  }

  Future<void> deleteProduct(int id) async {
    final db = await _databaseService.database;
    await db.delete(
      'product',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
