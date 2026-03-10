import 'package:dartz/dartz.dart';
import 'package:jhd/core/utils/categories.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/data_sources/add_collection_interface_data_source.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/domain/entities/add_category_entity.dart';

class AddCategoryRemoteDataSource
    implements AddCategoriesInterfaceDataSource {
  @override
  Future<Either<String, bool>> addCategory(
    CategoryDataModel category,
  ) async {
    return await CategoriesCollections().addCategory(
      category,
    );
  }
}
