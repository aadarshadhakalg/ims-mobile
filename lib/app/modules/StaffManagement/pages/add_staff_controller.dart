import 'package:get/get.dart';
import 'package:inventory_management_system/app/data/models/staff.model.dart';
import 'package:inventory_management_system/app/data/repositories/staff_repository.dart';
import 'package:inventory_management_system/app/modules/StaffManagement/staff.controller.dart';
import 'package:inventory_management_system/core/utils/mailer.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum AddUserStates { InitialState, AddingState }

class AddStaffController extends GetxController {
  Rx<AddUserStates> currentState =
      Rx<AddUserStates>(AddUserStates.InitialState);
  StaffController _controller = Get.find<StaffController>();

  FormGroup newStaff;

  @override
  onInit() {
    newStaff = FormGroup(
      {
        'username': FormControl<String>(validators: [Validators.required]),
        'email': FormControl<String>(
          validators: [Validators.email, Validators.required],
        ),
        'password': FormControl<String>(
          validators: [Validators.minLength(8), Validators.required],
        ),
        'password2': FormControl<String>(),
        'name': FormControl<String>(validators: [Validators.required]),
        'Landline_number': FormControl<String>(validators: [Validators.number]),
        'mobile_number': FormControl<String>(
            validators: [Validators.required, Validators.number]),
        'address': FormControl<String>(validators: [Validators.required]),
        'user_type': FormControl<UserType>(
            value: UserType.ST, validators: [Validators.required]),
      },
      validators: [
        Validators.mustMatch('password', 'password2'),
      ],
    );
    super.onInit();
  }

  Future<void> addStaff() async {
    currentState.value = AddUserStates.AddingState;

    print(newStaff.value);

    await StaffRepository()
        .addStaff(
          Staff.fromMap(newStaff.value),
        )
        .then(
          (value) => value.fold(
            (l) async {
              await Mailer.instance.sendStaffPassword(
                  newStaff.control('email').value,
                  newStaff.control('password').value);
              newStaff.reset();
              Get.back();
              Get.snackbar('Success', 'Staff Added Successfully');
              await _controller.refreshStaff();
            },
            (r) {
              Get.snackbar('Error Adding Staff', r.message);
            },
          ),
        );

    currentState.value = AddUserStates.InitialState;
  }
}