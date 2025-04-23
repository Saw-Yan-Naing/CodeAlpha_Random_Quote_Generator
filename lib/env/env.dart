import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path : ".env",obfuscate: true)
abstract class Env {
  @EnviedField(varName : "EMAIL",useConstantCase: true)
  static String email = _Env.email;

  @EnviedField(varName : 'PASSWORD', useConstantCase: true)
  static String password = _Env.password;

  @EnviedField(varName: "BASE_URL", useConstantCase: true)
  static String baseUrl = _Env.baseUrl;
}