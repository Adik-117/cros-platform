import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'items_model.dart'; // Import your model class here

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    String path = join(await getDatabasesPath(), 'app_database.db');
    _db = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(
        'CREATE TABLE products(id INTEGER PRIMARY KEY, name TEXT, description TEXT)',
      );
    });
    return _db!;
  }

  // Product CRUD operations
  Future<void> insertProduct(Product product) async {
    final db = await database;
    await db.insert('products', product.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Product>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  Future<void> updateProduct(Product product) async {
    final db = await database;
    await db.update('products', product.toMap(), where: 'id = ?', whereArgs: [product.id]);
  }

  Future<void> deleteProduct(int id) async {
    final db = await database;
    await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }
}