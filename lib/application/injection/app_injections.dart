import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/data_source/local_data_source.dart';
import '../../data/repository_impl/customer_repository_impl.dart';
import '../../domain/use_case/add_customer_use_case.dart';
import '../../domain/use_case/edit_customer_use_case.dart';
import '../../domain/use_case/get_all_customers_use_case.dart';
import '../../domain/use_case/get_customer_by_id_use_case.dart';

class AppInjections {
  static final GetIt customerGetIt = GetIt.instance;
  static const String db = 'CustomerDb';
  static const String customers = 'customers';

  static Future<void> initAppInjections() async {
    customerGetIt.registerSingleton<LocalDataSource>(
      LocalDataSource(
        await openOrCreateDb(),
      ),
    );
    customerGetIt.registerSingleton<CustomerRepositoryImpl>(
      CustomerRepositoryImpl(
        customerGetIt<LocalDataSource>(),
      ),
    );
    customerGetIt.registerSingleton<AddCustomerUseCase>(
      AddCustomerUseCase(customerGetIt<CustomerRepositoryImpl>()),
    );

    customerGetIt.registerSingleton<GetAllCustomersUseCase>(
      GetAllCustomersUseCase(customerGetIt<CustomerRepositoryImpl>()),
    );
    customerGetIt.registerSingleton<GetCustomerByIdUseCase>(
      GetCustomerByIdUseCase(customerGetIt<CustomerRepositoryImpl>()),
    );
    customerGetIt.registerSingleton<EditCustomerUseCase>(
      EditCustomerUseCase(customerGetIt<CustomerRepositoryImpl>()),
    );
  }

 static Future<BoxCollection> openOrCreateDb() async {
    final directory = await getApplicationDocumentsDirectory();

    return BoxCollection.open(
      db,
      {customers},
      path: directory.path,
    );
  }
}
