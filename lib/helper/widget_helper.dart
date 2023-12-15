import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final String formName;
  final TextEditingController controller;
  final bool type;

  const FormWidget({
    Key? key,
    required this.formName,
    required this.controller,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              formName,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0), // Adjusted spacing
            TextFormField(
              enabled: type,
              controller: controller,
              decoration: const InputDecoration(labelText: 'Enter data'),
            ),
          ],
        ),
      ),
    );
  }
}
