import 'add_section_dialog.dart';
import 'package:flutter/material.dart';

class PopMenu extends StatelessWidget {
  const PopMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (func) => func(),
      itemBuilder: (context) {
        return <PopupMenuItem<Function()>>[
          PopupMenuItem(
            value: () => addSection(context),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.add, size: 20),
                SizedBox(width: 5),
                Text(
                  "Add Section",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        ];
      },
    );
  }
}
