import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/app/data/models/staff.model.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/constants.dart';
import 'package:inventory_management_system/app/modules/StaffManagement/staff.controller.dart';
import 'package:inventory_management_system/app/modules/StaffManagement/widgets/staff_detail.widget.dart';

class StaffBox extends StatelessWidget {
  final Staff staff;

  StaffBox({@required this.staff});

  final StaffController _staffController = Get.find<StaffController>();

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
        return Container(
          padding: const EdgeInsets.all(defaultPadding),
          width: 200,
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
        );
      },
    );
  }
}
