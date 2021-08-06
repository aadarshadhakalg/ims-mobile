import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/payroll_model.dart';
import 'pay_staff_controller.dart';

class Payroll extends StatelessWidget {
  Payroll({Key key}) : super(key: key);

  final PayrollController _payrollController = Get.find<PayrollController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () async {
              await _payrollController
                  .payStaff(_payrollController.selectedStaff.value);
            },
            child: Text('Pay Staff'),
          ),
          Obx(
            () {
              return _payrollController.selectedStaff.value != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: _payrollController.allPayments.value.results
                          .where((element) =>
                              element.staff ==
                              _payrollController.selectedStaff.value.id)
                          .length,
                      itemBuilder: (context, index) {
                        List<Payments> staffPayments = _payrollController
                            .allPayments.value.results
                            .where((element) =>
                                element.staff ==
                                _payrollController.selectedStaff.value.id)
                            .toList();
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              '${staffPayments[index].paidAt.day}',
                            ),
                          ),
                          title: Text(
                            'Amount: ${staffPayments[index].paidMoney}',
                          ),
                          subtitle: Text(
                            'Amount: ${staffPayments[index].paidAt}',
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No Staff Selected',
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
