import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:inventory_management_system/app/data/models/staff.model.dart';
import 'package:reactive_forms/reactive_forms.dart';

class StaffController extends GetxController {
  Rx<Staff> selectedStaff = Rx<Staff>(null);

  FormGroup form = FormGroup(
    {
      'username': FormControl<String>(
          validators: [Validators.required], disabled: true),
      'email': FormControl<String>(
        validators: [Validators.email, Validators.required],
        disabled: true,
      ),
      'name': FormControl<String>(validators: [Validators.required]),
      'landlineNumber': FormControl<String>(validators: [Validators.number]),
      'mobileNumber': FormControl<String>(
          validators: [Validators.required, Validators.number]),
      'address': FormControl<String>(validators: [Validators.required]),
      'userType': FormControl<UserType>(validators: [Validators.required]),
      'createdAt': FormControl<String>(disabled: true),
    },
  );

  void selectStaff(Staff staff) {
    selectedStaff.value = staff;
    form.updateValue(staff.toMap());
  }
}
