import 'package:flutter/material.dart';

class TodoInput extends StatelessWidget {
  final Function(String) onSubmit;

  const TodoInput({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

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
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              onSubmit(controller.text);
              controller.clear();
            },
          ),
        ],
      ),
    );
  }
}
