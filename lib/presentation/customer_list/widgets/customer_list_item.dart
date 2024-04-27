import 'package:flutter/material.dart';

import '../../../application/utils/utils.dart';
import '../../../data/model/customer_model.dart';

class CustomerListItem extends StatelessWidget {
  final CustomerModel customerModel;
  final void Function() onEdit;

  const CustomerListItem({
    required this.onEdit,
    required this.customerModel,
    super.key,
  });

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
                  const Spacer(),
                  _menu(),
                  Utils.mediumHorizontalSpacer,
                ],
              ),
              Utils.mediumVerticalSpacer,
              Text(
                '${customerModel.phoneNumberValueObject.countryCode} '
                '${customerModel.phoneNumberValueObject.phoneNumber}',
              ),
              Utils.mediumVerticalSpacer,
            ],
          ),
        ),
      );

  Widget _menu() => PopupMenuButton<int>(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) => <PopupMenuEntry<int>>[
          PopupMenuItem<int>(
            onTap: onEdit,
            value: 1,
            child: const Icon(Icons.edit),
          ),
        ],
      );
}
