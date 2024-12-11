import 'package:flutter/material.dart';

class TodoInput extends StatefulWidget {
  final Function(String) onSubmit;

  const TodoInput({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSubmit(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Add a new todo...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _handleSubmit(),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: _handleSubmit,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
