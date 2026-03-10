import 'package:dartz/dartz.dart';
import 'package:jhd/core/utils/categories.dart';
import 'package:jhd/features/home/presentation/pages/collections/data/data_sources/get_all_categorise_interface_data_source.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';

class RemoteGetAllCategoriseDataSource
    implements GetAllCategoriseInterfaceDataSource {
  @override
  Future<Either<String, List<CategoryDataModel>>> getAllCategorise() async {
    return await CategoriesCollections().getAllCategorise();
  }
}
