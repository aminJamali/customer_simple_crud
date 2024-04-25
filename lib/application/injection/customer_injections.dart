import 'package:get_it/get_it.dart';

import '../../data/data_source/local_data_source.dart';
import '../../data/repository_impl/customer_repository_impl.dart';
import '../../domain/use_case/add_customer_use_case.dart';

class CustomerInjections {
  static final GetIt customerGetIt = GetIt.asNewInstance();

  static Future<void> initAddCustomerInjection() async {
    customerGetIt.registerSingleton<LocalDataSource>(LocalDataSource());
    customerGetIt.registerSingleton<CustomerRepositoryImpl>(
      CustomerRepositoryImpl(
        customerGetIt<LocalDataSource>(),
      ),
    );
    customerGetIt.registerSingleton<AddCustomerUseCase>(
      AddCustomerUseCase(customerGetIt<CustomerRepositoryImpl>()),
    );
  }
}
