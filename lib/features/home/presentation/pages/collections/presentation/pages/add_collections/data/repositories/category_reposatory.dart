import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';

abstract class AddCategoryReposatory {
  Future<Either<String, bool>> addCategory(
    CategoryDataModel category,
  );
}
