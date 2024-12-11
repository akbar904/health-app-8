import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const TodoDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = request.data?['title'] as String? ?? '';
    final description = request.data?['description'] as String? ?? '';
    final showConfirmButton = request.data?['showConfirmButton'] as bool? ?? false;
    final confirmationTitle = request.data?['confirmationTitle'] as String? ?? 'Confirm';

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request.title ?? 'Todo Details',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Title: $title',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Description: $description',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                  child: const Text('Close'),
                ),
                if (showConfirmButton) ...[
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => completer(DialogResponse(confirmed: true)),
                    child: Text(confirmationTitle),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}