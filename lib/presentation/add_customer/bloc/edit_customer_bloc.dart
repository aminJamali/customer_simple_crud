import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/edit_customer_use_case.dart';
import '../../../domain/use_case/get_customer_by_id_use_case.dart';
import 'modify_customer_base_bloc.dart';
import 'modify_customer_event.dart';
import 'modify_customer_state.dart';

class EditCustomerBloc extends ModifyCustomerBaseBloc {
  final GetCustomerByIdUseCase getCustomerUseCase;
  final EditCustomerUseCase editCustomerUseCase;

  EditCustomerBloc(
    super.initialState, {
    required this.getCustomerUseCase,
    required this.editCustomerUseCase,
  }) {
    on<GetCustomerByIdEvent>(_onGetCustomerByIdEvent);
    on<ModifyCustomerEvent>(_onEditCustomerEvent);
  }

  Future<void> _onEditCustomerEvent(
    ModifyCustomerEvent editCustomerEvent,
    Emitter<ModifyCustomerState> emit,
  ) async {
    emit(ModifyCustomerLoadingState());
    final result =
        await editCustomerUseCase.call(editCustomerEvent.modifyCustomerDto);

    result.fold(
      (l) => emit(ModifyCustomerExceptionState(l)),
      (r) => emit(ModifyCustomerDoneState(r)),
    );
  }

  Future<void> _onGetCustomerByIdEvent(
    GetCustomerByIdEvent getCustomerByIdEvent,
    Emitter<ModifyCustomerState> emit,
  ) async {
    emit(GetCustomerByIdLoadingState());
    final result = await getCustomerUseCase.call(getCustomerByIdEvent.id);

    result.fold(
      (l) => emit(GetCustomerByIdExceptionState(l)),
      (r) => emit(GetCustomerByIdDoneState(r)),
    );
  }
}
