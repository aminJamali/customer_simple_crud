import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/add_customer_use_case.dart';
import 'modify_customer_state.dart';
import 'modify_customer_base_bloc.dart';
import 'modify_customer_event.dart';

class AddCustomerBloc extends ModifyCustomerBaseBloc {
  final AddCustomerUseCase addCustomerUseCase;

  AddCustomerBloc({
    required this.addCustomerUseCase,
    required final ModifyCustomerState initialState,
  }) : super(initialState) {
    on<ModifyCustomerEvent>(_onAddCustomerEvent);
  }

  Future<void> _onAddCustomerEvent(
    ModifyCustomerEvent addCustomerEvent,
    Emitter<ModifyCustomerState> emit,
  ) async {
    emit(ModifyCustomerLoadingState());
    final result =
        await addCustomerUseCase.call(addCustomerEvent.modifyCustomerDto);

    result.fold(
      (l) => emit(ModifyCustomerExceptionState(l)),
      (r) => emit(ModifyCustomerDoneState(r)),
    );
  }
}
