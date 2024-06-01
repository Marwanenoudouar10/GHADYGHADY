import 'package:flutter/material.dart';
import 'package:myapp/widgets/text_input_config.dart';

class DynamicInputList extends StatelessWidget {
  final List<TextInputConfig> inputConfigs;
  const DynamicInputList({super.key, required this.inputConfigs});

  @override
  Widget build(BuildContext context) {
    List<Widget> fields = []; // Initialize an empty list of widgets

    for (var i = 0; i < inputConfigs.length; i++) {
      fields.add(
        SizedBox(
          width: 350,
          child: TextFormField(
            controller: inputConfigs[i].controller,
            validator: (value) {
              if (value!.isEmpty) {
                return "${inputConfigs[i].labelText} is required";
              }
              return null;
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              labelText: inputConfigs[i].labelText,
              filled: true,
              suffixIcon: inputConfigs[i].icon != null
                  ? Icon(inputConfigs[i].icon)
                  : null,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            obscureText: inputConfigs[i].isObsecure,
            keyboardType: inputConfigs[i].keyboardType,
          ),
        ),
      );

      // Add a SizedBox for spacing after each TextField, except after the last one
      if (i < inputConfigs.length - 1) {
        fields.add(const SizedBox(height: 10));
      }
    }
    return Column(
      children: fields,
    );
  }
}
