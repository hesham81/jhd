import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/data_sources/add_collection_interface_data_source.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/repositories/category_reposatory.dart';

class AddCategoryReposatoryImplementation implements AddCategoryReposatory {
  late final AddCategoriesInterfaceDataSource _dataSource;
  AddCategoryReposatoryImplementation(
    this._dataSource,
  );
  @override
  Future<Either<String, bool>> addCategory(
    CategoryDataModel category,
  ) async {
    try {
      return await _dataSource.addCategory(
        category,
      );
    } catch (error) {
      return Left(
        error.toString(),
      );
    }
  }
}
