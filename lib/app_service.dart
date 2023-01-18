import 'dart:io';

import 'package:conduit/conduit.dart';

class AppService extends ApplicationChannel {
  late final ManagedContext managedContext;

  @override
  Future prepare() {
    final persistentStore = _initDatabase();
    managedContext = ManagedContext(
        ManagedDataModel.fromCurrentMirrorSystem(), persistentStore);
    return super.prepare();
  }

  @override
  Controller get entryPoint => Router();

  PersistentStore _initDatabase() {
    final username = Platform.environment["DB_USERNAME"] ?? 'postgres';
    final password = Platform.environment["DB_PASSWORD"] ?? 'Parol123';
    final host = Platform.environment["DB_HOST"] ?? 'localhost';
    final port = int.parse(Platform.environment["DB_PORT"] ?? "5432");
    final database = Platform.environment["DB_DATABASE"] ?? 'database';
    return PostgreSQLPersistentStore(username, password, host, port, database);
  }
}
