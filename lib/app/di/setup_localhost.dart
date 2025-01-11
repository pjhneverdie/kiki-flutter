import 'package:injectable/injectable.dart';

import 'package:kiki/app/di/custom_profile.dart';
import 'package:kiki/app/di/get_it_instance.dart';
import 'package:kiki/app/di/setup_localhost.config.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependenciesLocalhost(
    {Environment environment = localhost}) async {
  getIt.init(environment: environment.name);
}
