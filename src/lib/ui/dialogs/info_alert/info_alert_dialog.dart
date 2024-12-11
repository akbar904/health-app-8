import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class InfoAlertDialog extends StatelessWidget {
  final DialogRequest dialogRequest;
  final Function onDialogTap;

  const InfoAlertDialog({
    Key? key,
    required this.dialogRequest,
    required this.onDialogTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              dialogRequest.title ?? '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(dialogRequest.description ?? ''),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => onDialogTap(),
              child: Text(dialogRequest.mainButtonTitle ?? 'OK'),
            ),
          ],
        ),
      ),
    );
  }
}