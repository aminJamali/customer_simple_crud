import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_customer_event.dart';
import 'add_customer_state.dart';

abstract class ModifyCustomerBaseBloc
    extends Bloc<AddCustomerEvent, AddCustomerState> {
  ModifyCustomerBaseBloc(super.initialState);
}
