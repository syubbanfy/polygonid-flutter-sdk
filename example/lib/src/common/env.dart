import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'ENV_POLYGON_MUMBAI')
  static const String polygonMumbai = _Env.polygonMumbai;
}
