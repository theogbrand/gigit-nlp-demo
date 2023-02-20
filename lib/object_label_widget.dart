import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ObjectLabelWidget extends StatelessWidget {
  const ObjectLabelWidget({
    Key? key,
    required this.onClick,
    required this.isSelected,
    required this.name,
  }) : super(key: key);

  final VoidCallback onClick;
  final bool isSelected;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: isSelected ? 64.w : 44.w,
        height: isSelected ? 64.w : 44.w,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.blueAccent,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.white,
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        padding: EdgeInsets.all(isSelected ? 6.w : 12.w),
        child: FittedBox(
          child: Text(
            getFirstNameLetter(name),
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }

  String getFirstNameLetter(String name) {
    List<String> names = name.split(' ');
    String initials = '';
    int noWords = names.length > 2 ? 2 : names.length;
    for (var i = 0; i < noWords; i++) {
      initials += names[i][0];
    }
    return initials;
  }
}
