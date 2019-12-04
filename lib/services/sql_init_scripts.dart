class SQLInitScripts {
  static const String CREATE_FRIENDS_SQL = '''
    CREATE TABLE friends(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      name TEXT NOT NULL,
      email TEXT UNIQUE, 
      phoneNumber INTEGER UNIQUE
    );
  ''';

  static const List<String> initScript = <String>[CREATE_FRIENDS_SQL];

  // Migration sql scripts, containing ONE STATEMENT PER MIGRATION VERSION
  static const List<String> migrationScripts = <String>[];
}
