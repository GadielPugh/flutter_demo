import 'package:audio_service/audio_service.dart';
import 'package:flutter_demo/app_state.dart';
import 'package:flutter_demo/services/audio_handler.dart';
import 'package:flutter_demo/services/auth/auth.dart';
import 'package:flutter_demo/services/local_storage/local_storage.dart';
import 'package:flutter_demo/ui/demos/5_sqlite/databse.dart';
import 'package:flutter_demo/ui/demos/10_audio/playlist_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());
  getIt.registerLazySingleton<Auth>(() => Auth());
  getIt.registerLazySingleton<AppState>(() => AppState());
  getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  getIt.registerLazySingleton<PlaylistRepository>(() => PlaylistRepository());
}
