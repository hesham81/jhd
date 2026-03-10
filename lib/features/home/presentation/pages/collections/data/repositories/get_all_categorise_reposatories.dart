import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';

abstract class GetAllCategoriseReposatories {
  Future<Either<String, List<CategoryDataModel>>> getAllCategorise();
}
