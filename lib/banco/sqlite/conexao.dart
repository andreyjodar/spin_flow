import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:spin_flow/banco/sqlite/script.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class Conexao {
  static Database? _database;

  static Future<Database> get() async {
    if (_database != null) {
      return _database!;
    }

    try {
      if (kIsWeb) {
        final factory = databaseFactoryFfiWeb;
        const path = 'banco.db';
        await factory.deleteDatabase(path);
        _database = await factory.openDatabase(
          path,
          options: OpenDatabaseOptions(
            version: 1,
            onCreate: (db, version) async {
              await db.transaction((txn) async {
                for (final tabela in criarTabelas) {
                  await txn.execute(tabela);
                }
                for (final insert in insertFabricantes) {
                  await txn.execute(insert);
                }
                for (final insert in insertTiposManutencao) {
                  await txn.execute(insert);
                }
              });
            },
          ),
        );
      } else {
        final path = join(await getDatabasesPath(), 'banco.db');
        await deleteDatabase(path);
        _database = await openDatabase(
          path,
          version: 1,
          onCreate: (db, version) async {
            await db.transaction((txn) async {
              for (final tabela in criarTabelas) {
                await txn.execute(tabela);
              }
              for (final insert in insertFabricantes) {
                await txn.execute(insert);
              }
            });
          },
        );
      }
      return _database!;
    } catch (e) {
      print('Erro ao abrir o banco de dados: $e');
      rethrow;
    }
  }
}