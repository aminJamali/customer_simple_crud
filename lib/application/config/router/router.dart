import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_case/add_customer_use_case.dart';
import '../../../domain/use_case/get_all_customers_use_case.dart';
import '../../../domain/use_case/get_customer_by_id_use_case.dart';
import '../../../presentation/add_customer/bloc/add_customer_bloc.dart';
import '../../../presentation/add_customer/bloc/edit_customer_bloc.dart';
import '../../../presentation/add_customer/bloc/modify_customer_state.dart';
import '../../../presentation/add_customer/modify_customer_screen.dart';
import '../../../presentation/customer_list/bloc/get_all_customers_bloc.dart';
import '../../../presentation/customer_list/bloc/get_all_customers_state.dart';
import '../../../presentation/customer_list/customer_list_screen.dart';
import '../../../presentation/not_found/presentation/not_found_screen.dart';
import '../../injection/app_injections.dart';
import 'route_names.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.addCustomer:
        return MaterialPageRoute(
          builder: (final context) => BlocProvider(
            create: (
              final _,
            ) =>
                AddCustomerBloc(
              initialState: AddCustomerInitialState(),
              addCustomerUseCase:
                  AppInjections.customerGetIt<AddCustomerUseCase>(),
            ),
            child: const ModifyCustomerScreen<AddCustomerBloc>(
              screenTitle: 'Add Customer',
            ),
          ),
        );
      case RouteNames.customerList:
        return MaterialPageRoute(
          builder: (final context) => BlocProvider(
            create: (
              final _,
            ) =>
                GetAllCustomersBloc(
              GetAllCustomersLoadingState(),
              AppInjections.customerGetIt<GetAllCustomersUseCase>(),
            ),
            child: const CustomerListScreen(),
          ),
        );
      case RouteNames.editCustomer:
        return MaterialPageRoute(
          builder: (final context) {
            final customerId = settings.arguments! as String;
            return BlocProvider(
              create: (
                final _,
              ) =>
                  EditCustomerBloc(
                ModifyCustomerLoadingState(),
                id: customerId,
                getCustomerUseCaseEvent:
                    AppInjections.customerGetIt<GetCustomerByIdUseCase>(),
              ),
              child: const ModifyCustomerScreen<EditCustomerBloc>(
                screenTitle: 'Edit Customer',
              ),
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (final context) => const NotFoundScreen(),
        );
    }
  }
}
