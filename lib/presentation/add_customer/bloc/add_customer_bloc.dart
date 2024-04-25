import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/add_customer_use_case.dart';
import 'add_customer_event.dart';
import 'add_customer_state.dart';
import 'modify_customer_base_bloc.dart';

class AddCustomerBloc extends ModifyCustomerBaseBloc {
  final AddCustomerUseCase addCustomerUseCase;

  AddCustomerBloc({
    required this.addCustomerUseCase,
    required final AddCustomerState initialState,
  }) : super(initialState) {
    on<AddCustomerEvent>(_onAddCustomerEvent);
  }

  Future<void> _onAddCustomerEvent(
    AddCustomerEvent addCustomerEvent,
    Emitter<AddCustomerState> emit,
  ) async {
    emit(AddCustomerLoadingState());
    final result =
        await addCustomerUseCase.call(addCustomerEvent.addCustomerDto);

    result.fold(
      (l) => emit(AddCustomerExceptionState(l)),
      (r) => emit(AddCustomerDoneState(r)),
    );
  }
}
