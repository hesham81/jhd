import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/repositories/category_reposatory.dart';

class AddCategoryUseCase {
  late final AddCategoryReposatory _reposatory;
  AddCategoryUseCase(
    this._reposatory,
  );

  Future<Either<String, bool>> call(
    CategoryDataModel category,
  ) async {
    return await _reposatory.addCategory(
      category,
    );
  }
}
