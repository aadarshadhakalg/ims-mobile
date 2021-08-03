import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/constants.dart';
import 'package:inventory_management_system/app/modules/StaffManagement/staff.controller.dart';
import 'package:reactive_forms/reactive_forms.dart';

class StaffDetailWidget extends StatelessWidget {
  final StaffController _staffController = Get.find<StaffController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.0,
          ),
          CircleAvatar(
            backgroundColor: secondaryColor,
            radius: 100,
            backgroundImage: AssetImage(
              "assets/images/staff-avatar.jpg",
            ),
          ),
          ReactiveForm(
            formGroup: _staffController.form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                ReactiveTextField(
                  formControlName: 'username',
                  decoration: decoration('Username'),
                ),
                SizedBox(height: 10),
                ReactiveTextField(
                  formControlName: 'email',
                  decoration: decoration('Email'),
                ),
                SizedBox(height: 10),
                ReactiveTextField(
                  formControlName: 'name',
                  decoration: decoration('Name'),
                ),
                SizedBox(height: 10),
                ReactiveTextField(
                  formControlName: 'Landline_number',
                  decoration: decoration('Landline Number'),
                ),
                SizedBox(height: 10),
                ReactiveTextField(
                  formControlName: 'mobile_number',
                  decoration: decoration('Mobile Number'),
                ),
                SizedBox(height: 10),
                ReactiveTextField(
                  formControlName: 'address',
                  decoration: decoration('Address'),
                ),
                SizedBox(height: 20),
                GetX<StaffController>(
                  builder: (StaffController controller) {
                    if (controller.currentState.value ==
                        StaffControllerStates.ChangingState) {
                      return ElevatedButton(
                        onPressed: () {},
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ReactiveFormConsumer(
                        builder: (BuildContext context, FormGroup formGroup,
                            Widget child) {
                          return ElevatedButton(
                            onPressed: (controller.currentState.value ==
                                    StaffControllerStates.EditingState)
                                ? () async {
                                    print('Her');
                                    if (controller.form.valid) {
                                      print('valie');
                                      await controller.updateStaff();
                                    }
                                  }
                                : null,
                            child: Text('Update Staff'),
                          );
                        },
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                GetX<StaffController>(
                  builder: (StaffController controller) {
                    if (controller.currentState.value ==
                        StaffControllerStates.ChangingState) {
                      return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.red),
                        ),
                        onPressed: () {},
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.red),
                        ),
                        onPressed: () {
                          controller.deleteStaff();
                        },
                        child: Text('Delete Staff'),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration decoration(String label) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );
}
