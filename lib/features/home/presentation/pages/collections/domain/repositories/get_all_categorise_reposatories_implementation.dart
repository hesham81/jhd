import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/collections/data/data_sources/get_all_categorise_interface_data_source.dart';
import 'package:jhd/features/home/presentation/pages/collections/data/repositories/get_all_categorise_reposatories.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';

class GetAllCategoriseReposatoriesImplementation
    implements GetAllCategoriseReposatories {
  late final GetAllCategoriseInterfaceDataSource _dataSource;

  GetAllCategoriseReposatoriesImplementation(
    this._dataSource,
  );
  @override
  Future<Either<String, List<CategoryDataModel>>> getAllCategorise() async {
    try {
      var response = await _dataSource.getAllCategorise();
      return response;
    } catch (error) {
      return Left(
        error.toString(),
      );
    }
  }
}
