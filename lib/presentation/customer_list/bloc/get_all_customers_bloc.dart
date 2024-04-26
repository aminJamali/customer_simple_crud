import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/get_all_customers_use_case.dart';
import 'get_all_customers_event.dart';
import 'get_all_customers_state.dart';

class GetAllCustomersBloc
    extends Bloc<GetAllCustomersEvent, GetAllCustomersState> {
  final GetAllCustomersUseCase getAllCustomersUseCase;

  GetAllCustomersBloc(super.initialState, this.getAllCustomersUseCase) {
    on<GetAllCustomersEvent>(_onGetAllCustomersEvent);
  }

  Future<void> _onGetAllCustomersEvent(
    GetAllCustomersEvent getAllCustomersEvent,
    Emitter<GetAllCustomersState> emit,
  ) async {
    emit(GetAllCustomersLoadingState());
    final result = await getAllCustomersUseCase.call(null);

    result.fold(
      (l) => emit(GetAllCustomersExceptionState(l)),
      (r) {
        if (r.isNotEmpty) {
          emit(GetAllCustomersDoneState(r));
        } else {
          emit(
            GetAllCustomersEmptyState(),
          );
        }
      },
    );
  }
}
