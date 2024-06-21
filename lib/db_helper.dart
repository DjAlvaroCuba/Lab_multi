import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
CREATE TABLE teams (
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
team_name TEXT,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
last_match_date TIMESTAMP)
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("team_database.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createTeam(String teamName) async {
    final db = await SQLHelper.db();
    final data = {'team_name': teamName};
    final id = await db.insert('teams', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllTeams() async {
    final db = await SQLHelper.db();
    return db.query('teams', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleTeam(int id) async {
    final db = await SQLHelper.db();
    return db.query('teams', where: "id=?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateTeam(int id, String teamName) async {
    final db = await SQLHelper.db();
    final data = {
      'team_name': teamName,
    };
    final result =
        await db.update('teams', data, where: "id=?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteTeam(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('teams', where: "id=?", whereArgs: [id]);
    } catch (e) {
      print("Error deleting team: $e");
    }
  }

  static Future<void> updateLastMatchDate(int teamId, DateTime lastMatchDate) async {
    final db = await SQLHelper.db();
    final data = {'last_match_date': lastMatchDate.toIso8601String()};
    await db.update('teams', data, where: "id=?", whereArgs: [teamId]);
  }
}
