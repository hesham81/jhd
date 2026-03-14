import 'package:dartz/dartz.dart';
import 'package:jhd/features/home/presentation/pages/collections/presentation/pages/add_collections/data/models/category_data_model.dart';
import 'package:jhd/features/user_home/data/repositories/get_all_data_user_home_reposatory.dart';

class GetAllUserHomeDataUseCase {
  late final GetAllDataUserHomeReposatory _reposatory;
  GetAllUserHomeDataUseCase(
    this._reposatory,
  );
  Future<Either<String, List<CategoryDataModel>>> call() async {
    return await _reposatory.getAllData();
  }
}
