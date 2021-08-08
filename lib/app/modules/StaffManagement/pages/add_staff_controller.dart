import 'package:get/get.dart';
import '../../../data/models/staff.model.dart';
import '../../../data/repositories/staff_repository.dart';
import '../staff.controller.dart';
import '../../../../core/utils/mailer.dart';
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
        'pay': FormControl<int>(
            validators: [Validators.required, Validators.number]),
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
                  newStaff.control('name').value,
                  newStaff.control('email').value,
                  newStaff.control('username').value,
                  newStaff.control('password').value);
              newStaff.reset();
              Get.back();
              Get.rawSnackbar(
                  title: 'Success', message: 'Staff Added Successfully');
              await _controller.refreshStaff();
            },
            (r) {
              Get.rawSnackbar(title: 'Error Adding Staff', message: r.message);
            },
          ),
        );

    currentState.value = AddUserStates.InitialState;
  }
}
