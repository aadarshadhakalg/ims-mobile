import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:inventory_management_system/app/data/models/staff.model.dart';
import 'package:inventory_management_system/app/data/repositories/staff_repository.dart';
import 'package:inventory_management_system/core/utils/notification.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum StaffControllerStates {
  InitialState,
  ChangingState,
  EditingState,
}

class StaffController extends GetxController {
  Rx<Staff> selectedStaff = Rx<Staff>(null);
  Rx<StaffModel> allStaffs = Rx<StaffModel>(null);

  Rx<StaffControllerStates> currentState =
      Rx<StaffControllerStates>(StaffControllerStates.InitialState);

  @override
  onInit() async {
    await refreshStaff();
    super.onInit();
  }

  FormGroup form = FormGroup(
    {
      'username': FormControl<String>(validators: [Validators.required]),
      'email': FormControl<String>(
        validators: [Validators.email, Validators.required],
      ),
      'name': FormControl<String>(validators: [Validators.required]),
      'Landline_number': FormControl<String>(validators: [Validators.number]),
      'mobile_number': FormControl<String>(
          validators: [Validators.required, Validators.number]),
      'address': FormControl<String>(validators: [Validators.required]),
      'pay': FormControl<int>(
          validators: [Validators.required, Validators.number]),
    },
  );

  void selectStaff(Staff staff) {
    selectedStaff.value = staff;
    form.markAsDisabled();
    form.updateValue(staff.toMap());
  }

  Future<void> updateStaff() async {
    currentState.value = StaffControllerStates.ChangingState;
    form.markAsDisabled();

    await StaffRepository()
        .updateStaff(
          Staff.fromMap(form.value),
          selectedStaff.value.id.toString(),
        )
        .then(
          (value) => value.fold(
            (l) async {
              Get.rawSnackbar(
                  title: 'Success', message: 'Staff Added Successfully');
              await refreshStaff();
              currentState.value = StaffControllerStates.InitialState;
            },
            (r) {
              Get.rawSnackbar(title: 'Error Adding Staff', message: r.message);
              currentState.value = StaffControllerStates.EditingState;
              form.markAsEnabled();
            },
          ),
        );
  }

  Future deleteStaff() async {
    var res = await StaffRepository().deleteStaff(selectedStaff.value.id);

    if (res) {
      await client.notify('Staff Deleted');
      Get.back();
    } else {
      await client.notify('Error! Staff Not Deleted');
    }

    await refreshStaff();
  }

  Future<void> refreshStaff() async {
    await StaffRepository().listStaff().then(
          (value) => value.fold(
            (l) {
              allStaffs.value = l;
            },
            (r) {
              Get.rawSnackbar(title: "Error", message: "${r.message}");
            },
          ),
        );
  }
}
