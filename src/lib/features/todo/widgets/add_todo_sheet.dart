import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class AddTodoSheet extends StatelessWidget {
  final Function(SheetResponse response) completer;
  final SheetRequest request;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  AddTodoSheet({
    required this.completer,
    required this.request,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => completer(SheetResponse(confirmed: false)),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => completer(
                  SheetResponse(
                    confirmed: true,
                    data: {
                      'title': _titleController.text,
                      'description': _descriptionController.text,
                    },
                  ),
                ),
                child: const Text('Add'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}