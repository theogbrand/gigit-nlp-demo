import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ObjectTileWidget extends StatelessWidget {
  const ObjectTileWidget({
    Key? key,
    required this.labelName,
    required this.onClick,
    required this.onDelete,
  }) : super(key: key);

  final String labelName;
  final VoidCallback onClick;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        title: Text(labelName),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: onClick,
              child: Text(
                'Change Label',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: VerticalDivider(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
