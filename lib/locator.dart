import 'package:classconnect/services/auth.dart';
import 'package:classconnect/services/db.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
}
