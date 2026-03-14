import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';
import 'package:jhd/features/user_home/data/data_sources/get_data_user_home_interface_data_source.dart';
import 'package:jhd/features/user_home/data/repositories/get_all_data_user_home_reposatory.dart';

class GetAllDataUserHomeReposatoryImplementation
    implements GetAllDataUserHomeReposatory {
  late final GetDataUserHomeInterfaceDataSource _dataSource;

  GetAllDataUserHomeReposatoryImplementation(
    this._dataSource,
  );
  @override
  Future<Either<String, List<CategoryDataModel>>> getAllData() async {
    return await _dataSource.getAllData();
  }
}
