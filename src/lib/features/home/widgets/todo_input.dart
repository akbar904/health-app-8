import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TodoInput extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final VoidCallback onSubmit;

  const TodoInput({
    Key? key,
    required this.titleController,
    required this.descriptionController,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Todo Title',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const Gap(16),
            ElevatedButton(
              onPressed: onSubmit,
              child: const Text('Add Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
