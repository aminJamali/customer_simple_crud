import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/config/router/route_names.dart';
import '../../application/utils/utils.dart';
import 'bloc/get_all_customers_bloc.dart';
import 'bloc/get_all_customers_event.dart';
import 'bloc/get_all_customers_state.dart';
import 'widgets/customer_list_item.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  @override
  void initState() {
    context.read<GetAllCustomersBloc>().add(GetAllCustomersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, RouteNames.addCustomer);
            if (context.mounted) {
              context.read<GetAllCustomersBloc>().add(GetAllCustomersEvent());
            }
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Customers'),
        ),
        body: SafeArea(
          child: Padding(
            padding: Utils.mediumPadding,
            child: BlocConsumer<GetAllCustomersBloc, GetAllCustomersState>(
              listener: (final _, final state) {
                if (state is GetAllCustomersExceptionState) {
                  BotToast.showText(text: state.exceptionModel.message);
                }
              },
              builder: (final _, final state) {
                if (state is GetAllCustomersLoadingState) {
                  return _loading();
                }
                if (state is GetAllCustomersDoneState) {
                  return _customersList(state, context);
                }
                if (state is GetAllCustomersEmptyState) {
                  return _emptyText();
                }
                return _retry(context);
              },
            ),
          ),
        ),
      );

  Widget _emptyText() => const Center(
        child: Text('Nothing to show!'),
      );

  Widget _loading() => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _retry(BuildContext context) => Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<GetAllCustomersBloc>().add(GetAllCustomersEvent());
          },
          child: const Text('Try Again'),
        ),
      );

  Widget _customersList(GetAllCustomersDoneState state, BuildContext context) =>
      ListView.builder(
        itemCount: state.customers.length,
        itemBuilder: (final _, final index) => CustomerListItem(
          customerModel: state.customers[index],
          onEdit: () async {
            await Navigator.pushNamed(
              context,
              RouteNames.editCustomer,
              arguments: state.customers[index].id,
            );
            if (mounted) {
              context.read<GetAllCustomersBloc>().add(GetAllCustomersEvent());
            }
          },
        ),
      );
}
