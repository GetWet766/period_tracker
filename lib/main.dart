import 'package:periodility/bootstrap.dart';
import 'package:periodility/core/app/periodility_app.dart';

Future<void> main() async {
  await bootstrap(() => const Periodility());
}
