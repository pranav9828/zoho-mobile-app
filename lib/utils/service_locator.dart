import 'package:feedback_app/features/auth/auth_service.dart';
import 'package:feedback_app/features/feedback/feedback_service.dart';
import 'package:feedback_app/utils/refresh_service.dart';
import 'package:feedback_app/utils/shared_preference_utils.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<SharedPreferenceUtils>(SharedPreferenceUtils());
  getIt.registerSingleton<RefreshService>(RefreshService());
  getIt.registerSingleton<FeedbackService>(FeedbackService());
}
