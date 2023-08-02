import 'package:flutter/material.dart';

class RadioBox extends StatefulWidget {
  final Function(String? value) callback;
  const RadioBox({super.key, required this.callback});

  @override
  State<RadioBox> createState() => _RadioBoxState();
}

class _RadioBoxState extends State<RadioBox> {
  String genderList = 'Male';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Gender',
            style: TextStyle(fontSize: 16),
          ),
          Radio<String>(
            value: 'Male',
            groupValue: genderList,
            onChanged: (value) {
              setState(() {
                genderList = value!;
                widget.callback(value);
              });
            },
          ),
          const Text('Male'),
          Radio(
              value: 'Female',
              groupValue: genderList,
              onChanged: (value) {
                setState(() {
                  genderList = value!;
                  widget.callback(value);
                });
              }),
          const Text('Female'),
          Radio(
              value: 'Other',
              groupValue: genderList,
              onChanged: (value) {
                setState(() {
                  genderList = value!;
                  widget.callback(value);
                });
              }),
          const Text('Other'),
        ],
      ),
    );
  }
}
