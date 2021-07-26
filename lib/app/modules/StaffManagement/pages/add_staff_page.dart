import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_management_system/app/modules/StaffManagement/pages/add_staff_controller.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddStaffPage extends StatelessWidget {
  AddStaffPage({Key key}) : super(key: key);

  final AddStaffController _addStaffController = Get.find<AddStaffController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Staff'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: ReactiveForm(
            formGroup: _addStaffController.newStaff,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                ReactiveTextField(
                  formControlName: 'username',
                  decoration: decoration('Username'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ReactiveTextField(
                  formControlName: 'email',
                  decoration: decoration('Email'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ReactiveTextField(
                  formControlName: 'name',
                  decoration: decoration('Name'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ReactiveTextField(
                  formControlName: 'password',
                  // obscureText: true,
                  decoration: decoration('Password'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ReactiveTextField(
                  formControlName: 'password2',
                  // obscureText: true,
                  decoration: decoration('Password Confirmation'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ReactiveTextField(
                  formControlName: 'Landline_number',
                  decoration: decoration('Landline Number'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ReactiveTextField(
                  formControlName: 'mobile_number',
                  decoration: decoration('Mobile Number'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ReactiveTextField(
                  formControlName: 'address',
                  decoration: decoration('Address'),
                ),
                SizedBox(
                  height: 30.0,
                ),
                GetX<AddStaffController>(
                  builder: (AddStaffController controller) {
                    if (controller.currentState.value ==
                        AddUserStates.AddingState) {
                      return ElevatedButton(
                        onPressed: () {},
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ReactiveFormConsumer(
                        builder: (BuildContext context, FormGroup formGroup,
                            Widget child) {
                          return ElevatedButton.icon(
                            onPressed: () async {
                              if (controller.newStaff.valid) {
                                await controller.addStaff();
                              }
                            },
                            icon: Icon(Icons.done),
                            label: Text('Add User'),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
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
