import 'package:flutter/material.dart';

import '../../../application/utils/utils.dart';
import '../../../data/model/customer_model.dart';

class CustomerListItem extends StatelessWidget {
  final CustomerModel customerModel;

  const CustomerListItem({required this.customerModel, super.key});

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: Utils.mediumPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${customerModel.firstNameValueObject.firstName} '
                    '${customerModel.lastNameValueObject.lastName}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Utils.smallHorizontalSpacer,
                  Text(customerModel.emailValueObject.email),
                ],
              ),
              Utils.mediumVerticalSpacer,
              Text(
                '${customerModel.phoneNumberValueObject.countryCode} '
                '${customerModel.phoneNumberValueObject.phoneNumber}',
              ),
            ],
          ),
        ),
      );
}
