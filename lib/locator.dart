import 'package:get_it/get_it.dart';

import 'package:app/services/dynamicLinkService.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => DynamicLinkService());
}