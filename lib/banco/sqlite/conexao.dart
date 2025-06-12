import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

late List<String> criarTabelas;
late List<String> inserirFabricantes;

class Conexao {
  static Database? _database;

  static Future<Database> get() async {
    if (_database != null) return _database!;

    try {
      if (kIsWeb) {
        databaseFactory = databaseFactoryFfiWeb;
        _database = await databaseFactory.openDatabase('spin_flow.db');
      } else {
        String path = join(await getDatabasesPath(), 'spin_flow.db');
        await deleteDatabase(
            path); // Descomente para resetar o banco a cada inicialização

        _database = await openDatabase(
          path,
          version: 1,
          onCreate: (db, version) async {
            for (var comando in criarTabelas) {
              await db.execute(comando);
            }
            for (var comando in inserirFabricantes) {
              await db.execute(comando);
            }
          },
          onUpgrade: (db, oldVersion, newVersion) async {
            // Lógica de migração de banco de dados, se necessário
          },
        );
      }
      return _database!;
    } catch (e) {
      // Você pode logar o erro ou lançar uma exceção mais específica
      print(e);
      rethrow;
    }
  }
}
