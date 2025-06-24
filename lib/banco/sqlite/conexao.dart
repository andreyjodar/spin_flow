<<<<<<< HEAD
import 'package:sqflite/sqflite.dart';
import 'package:flutter_application_1/banco/sqlite/script.dart';
=======
import 'package:flutter/foundation.dart';
>>>>>>> main
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
<<<<<<< HEAD
            for (var comando in criarTabelas) {
              await db.execute(comando);
            }
            for (var comando in insertFabricantes) {
              await db.execute(comando);
            }            
            for (var comando in insertTiposManutencao) {
              await db.execute(comando);
            }
          },
          onUpgrade: (db, oldVersion, newVersion) async {
=======
            await db.transaction((txn) async {
              for (final tabela in criarTabelas) {
                await txn.execute(tabela);
              }
              for (final insert in insertFabricantes) {
                await txn.execute(insert);
              }
            });
>>>>>>> main
          },
        );
      }
      return _database!;
    } catch (e) {
<<<<<<< HEAD
      print(e);
=======
      print('Erro ao abrir o banco de dados: $e');
>>>>>>> main
      rethrow;
    }
  }
}