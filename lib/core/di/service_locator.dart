import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:movieapp/core/di/service_locator.config.dart';

final sl = GetIt.instance; // Service Locator

@InjectableInit()
void setupLocator() => sl.init();