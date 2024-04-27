import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/get_customer_by_id_use_case.dart';
import 'modify_customer_base_bloc.dart';
import 'modify_customer_event.dart';
import 'modify_customer_state.dart';

class EditCustomerBloc extends ModifyCustomerBaseBloc {
  final String id;
  final GetCustomerByIdUseCase getCustomerUseCaseEvent;

  EditCustomerBloc(
    super.initialState, {
    required this.getCustomerUseCaseEvent,
    required this.id,
  }) {
    on<GetCustomerByIdEvent>(_onGetCustomerByIdEvent);
    add(
      GetCustomerByIdEvent(id),
    );
  }

  Future<void> _onGetCustomerByIdEvent(
    GetCustomerByIdEvent getCustomerByIdEvent,
    Emitter<ModifyCustomerState> emit,
  ) async {
    emit(GetCustomerByIdLoadingState());
    final result = await getCustomerUseCaseEvent.call(getCustomerByIdEvent.id);

    result.fold(
      (l) => emit(GetCustomerByIdExceptionState(l, getCustomerByIdEvent.id)),
      (r) => emit(GetCustomerByIdDoneState(r)),
    );
  }
}
