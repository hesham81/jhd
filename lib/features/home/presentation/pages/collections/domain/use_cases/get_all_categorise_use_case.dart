import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/collections/data/repositories/get_all_categorise_reposatories.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';

class GetAllCategoriseUseCase {
  late final GetAllCategoriseReposatories _reposatories;
  GetAllCategoriseUseCase(
    this._reposatories,
  );

  Future<Either<String, List<CategoryDataModel>>> call() async {
    try {
      return _reposatories.getAllCategorise();
    } catch (error) {
      return Left(
        error.toString(),
      );
    }
  }
}
