
import 'package:get_it/get_it.dart';

import 'features/pdflow/data/repository/home_repository_impl.dart';
import 'features/pdflow/data/repository/pdf_repository_impl.dart';
import 'features/pdflow/domain/repository/home_repository.dart';
import 'features/pdflow/domain/repository/pdf_repository.dart';
import 'features/pdflow/domain/usecases/home/get_files.dart';
import 'features/pdflow/domain/usecases/pdf/create_pdf.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  //! UseCases
  sl.registerSingleton(() => GetFilesUseCase(homeRepository: sl()));
  sl.registerSingleton(() => CreatePdfUseCase(pdfRepository: sl()));
  sl.registerLazySingleton(() => GetFilesUseCase(homeRepository: sl()));

  //! Repository
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  sl.registerLazySingleton<PdfRepository>(() => PdfRepositoryImpl());
}
