import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/manage_candidates_model.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "ManageCandidates.db";

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async => await db.execute(
        "CREATE TABLE ManageCandidates(id INTEGER PRIMARY KEY, name TEXT NOT NULL, semester TEXT NOT NULL, post_id INTEGER, department TEXT NOT NULL, usn TEXT NOT NULL, phone_number INTEGER NOT NULL, email TEXT NOT NULL, election_id INTEGER NOT NULL);",
      ),
      version: _version,
    );
  }

  // Insert
  static Future<int> addCandidate(ManageCandidatesModel candidate) async {
    final db = await _getDB();
    return await db.insert(
      "ManageCandidates",
      candidate.toJson(), // Corrected method name to 'toJson'
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update
  static Future<int> updateCandidate(ManageCandidatesModel candidate) async {
    final db = await _getDB();
    return await db.update(
      "ManageCandidates",
      candidate.toJson(),
      where: 'id=?',
      whereArgs: [candidate.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Delete
  static Future<int> deleteCandidate(ManageCandidatesModel candidate) async {
    final db = await _getDB();
    return await db.delete(
      "ManageCandidates",
      where: 'id=?',
      whereArgs: [candidate.id],
    );
  }

  // Retrieve list of candidates

  static Future<List<ManageCandidatesModel>> getAllCandidates() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("ManageCandidates");

    return List.generate(
      maps.length,
      (index) => ManageCandidatesModel.fromJson(maps[index]),
    );
  }
}
