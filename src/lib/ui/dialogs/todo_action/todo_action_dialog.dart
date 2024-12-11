import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoActionDialogData {
  final String? initialTitle;
  final bool isEditing;

  TodoActionDialogData({
    this.initialTitle,
    this.isEditing = false,
  });
}

class TodoActionDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const TodoActionDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  State<TodoActionDialog> createState() => _TodoActionDialogState();
}

class _TodoActionDialogState extends State<TodoActionDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final data = widget.request.data as TodoActionDialogData;
    _controller = TextEditingController(text: data.initialTitle);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.request.data as TodoActionDialogData;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data.isEditing ? 'Edit Todo' : 'Add Todo',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Todo Title',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () =>
                      widget.completer(DialogResponse(confirmed: false)),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      widget.completer(
                        DialogResponse(
                          confirmed: true,
                          data: _controller.text.trim(),
                        ),
                      );
                    }
                  },
                  child: Text(data.isEditing ? 'Update' : 'Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
