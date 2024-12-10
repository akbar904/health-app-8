import 'package:flutter/material.dart';

class TodoInput extends StatelessWidget {
  final Function(String) onSubmit;
  final TextEditingController controller = TextEditingController();

  TodoInput({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Add a new todo...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                onSubmit(value);
                controller.clear();
              },
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {
              onSubmit(controller.text);
              controller.clear();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
