import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path : ".env",obfuscate: true)
abstract class Env {
  @EnviedField(varName : 'SUPABASE_ANON_KEY',useConstantCase: true)
  static String anonKey = _Env.anonKey;

  @EnviedField(varName : 'PROJECT_ID',useConstantCase: true)
  static String projectId = _Env.projectId;

  @EnviedField(varName : "EMAIL",useConstantCase: true)
  static String email = _Env.email;

  @EnviedField(varName : 'PASSWORD', useConstantCase: true)
  static String password = _Env.password;

  @EnviedField(varName: "BASE_URL", useConstantCase: true)
  static String baseUrl = _Env.baseUrl;
}