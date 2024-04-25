import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/use_case/add_customer_use_case.dart';
import '../../../presentation/add_customer/bloc/add_customer_bloc.dart';
import '../../../presentation/add_customer/bloc/add_customer_state.dart';
import '../../../presentation/add_customer/modify_customer_screen.dart';
import '../../../presentation/not_found/presentation/not_found_screen.dart';
import '../../injection/customer_injections.dart';
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
                  CustomerInjections.customerGetIt<AddCustomerUseCase>(),
            ),
            child: const ModifyCustomerScreen<AddCustomerBloc>(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (final context) => const NotFoundScreen(),
        );
    }
  }
}
