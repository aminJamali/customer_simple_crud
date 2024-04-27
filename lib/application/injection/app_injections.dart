import 'package:get_it/get_it.dart';

import '../../data/data_source/local_data_source.dart';
import '../../data/repository_impl/customer_repository_impl.dart';
import '../../domain/use_case/add_customer_use_case.dart';
import '../../domain/use_case/get_all_customers_use_case.dart';
import '../../domain/use_case/get_customer_by_id_use_case.dart';

class AppInjections {
  static final GetIt customerGetIt = GetIt.instance;

  static Future<void> initAppInjections() async {
    customerGetIt.registerSingleton<LocalDataSource>(LocalDataSource());
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
  }
}
