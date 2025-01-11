import 'package:injectable/injectable.dart';

import 'package:kiki/app/di/get_it_instance.dart';
import 'package:kiki/app/di/setup_prod.config.dart';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies({Environment environment = prod}) async {
  getIt.init(environment: environment.name);
}
