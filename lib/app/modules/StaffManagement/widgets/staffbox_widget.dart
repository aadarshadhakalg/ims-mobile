import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/app/modules/DashBoard/ui/constants.dart';
import 'package:inventory_management_system/app/modules/StaffManagement/widgets/staff_detail.widget.dart';

class StaffBox extends StatelessWidget {
  final String name;
  final String id;

  StaffBox({@required this.id, @required this.name});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: secondaryColor,
      transitionType: ContainerTransitionType.fadeThrough,
      openColor: bgColor,
      openBuilder:
          (BuildContext context, void Function({Object returnValue}) action) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: action,
                      icon: Icon(Icons.arrow_back),
                    ),
                    Spacer(),
                    Text(
                      '$name',
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
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                StaffDetailWidget(),
              ],
            ),
          ),
        );
      },
      closedBuilder: (BuildContext context, void Function() action) {
        return Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              color: secondaryColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Text('$id'),
                backgroundColor: Colors.grey,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text('$name'),
            ],
          ),
        );
      },
    );
  }
}
