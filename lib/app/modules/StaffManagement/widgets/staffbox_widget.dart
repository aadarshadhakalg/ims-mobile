import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/staff.model.dart';
import '../../DashBoard/ui/constants.dart';
import '../pages/pay_staff.dart';
import '../pages/pay_staff_controller.dart';
import '../staff.controller.dart';
import 'staff_detail.widget.dart';

class StaffBox extends StatelessWidget {
  final Staff staff;

  StaffBox({@required this.staff});

  final StaffController _staffController = Get.find<StaffController>();
  final PayrollController _payrollController = Get.find<PayrollController>();

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: secondaryColor,
      transitionType: ContainerTransitionType.fadeThrough,
      openColor: bgColor,
      openBuilder:
          (BuildContext context, void Function({Object returnValue}) action) {
        Get.find<StaffController>().selectStaff(staff);
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          _staffController.form.markAsDisabled();
                          _staffController.currentState.value =
                              StaffControllerStates.InitialState;
                          action.call();
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      Spacer(),
                      Text(
                        '${staff.name}',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: IconButton(
                          focusColor: Colors.blue,
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _staffController.form.markAsEnabled();
                            _staffController.currentState.value =
                                StaffControllerStates.EditingState;
                          },
                        ),
                      ),
                    ],
                  ),
                  StaffDetailWidget(),
                ],
              ),
            ),
          ),
        );
      },
      closedBuilder: (BuildContext context, void Function() action) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(defaultPadding),
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  color: secondaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: Text('${staff.id}'),
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('${staff.name}'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                _payrollController.selectedStaff.value = staff;
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Payroll(),
                );
              },
              child: Container(
                width: 150,
                padding: const EdgeInsets.all(5.0),
                color: Colors.red,
                child: Center(child: Text('PAY')),
              ),
            ),
          ],
        );
      },
    );
  }
}
