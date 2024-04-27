import '../../../data/model/modify_customer_dto.dart';

abstract class ModifyCustomerBaseEvent {}

class ModifyCustomerEvent extends ModifyCustomerBaseEvent {
  final ModifyCustomerDto modifyCustomerDto;

  ModifyCustomerEvent(this.modifyCustomerDto);
}

class GetCustomerByIdEvent extends ModifyCustomerBaseEvent {
  final String id;

  GetCustomerByIdEvent(this.id);
}


