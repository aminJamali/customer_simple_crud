import 'package:flutter_bloc/flutter_bloc.dart';

import 'modify_customer_event.dart';
import 'modify_customer_state.dart';

abstract class ModifyCustomerBaseBloc
    extends Bloc<ModifyCustomerBaseEvent, ModifyCustomerState> {
  ModifyCustomerBaseBloc(super.initialState);
}
