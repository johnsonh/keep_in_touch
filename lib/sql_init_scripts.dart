
class SQLInitScripts {
  static const String CREATE_FRIENDS_SQL = """
    CREATE TABLE IF NOT EXISTS friends(
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      name TEXT NOT NULL,
      email TEXT UNIQUE, 
      phoneNumber INTEGER UNIQUE
    );
  """; 

  static const initScript = [CREATE_FRIENDS_SQL];

  // Migration sql scripts, containing ONE STATEMENT PER MIGRATION VERSION
  static const migrationScripts = [];
}