import 'package:flutter/material.dart';
import '../utilities/location_style.dart';
class ReusedIcon extends StatelessWidget {
  final IconData ico;
  final String label;
  final String value;

  ReusedIcon(this.ico, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          ico,
          color: Colors.white,
          size: 45,
        ),
        SizedBox(width:10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(label,style: kRow2LabelStyle,),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(value,style:kRow2TextStyle),
            ),
          ],
        )
      ],
    );
  }
}
