import "dart:io";

import "package:image_picker/image_picker.dart";
import "package:intl/intl.dart";

import "../theme/app_palette.dart";
import "package:flutter/material.dart";

void showErrorDialog({
  required BuildContext context,
  required String message,
}) {
  showDialog(
    context: context,
    useSafeArea: true,
    builder: (_) => SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: AlertDialog(
        icon: const Icon(Icons.dangerous_rounded, size: 64.0),
        iconColor: AppPalette.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        backgroundColor: AppPalette.error.withOpacity(0.9),
        // title: const Icon(
        //   Icons.cancel,
        //   size: 64.0,
        //   color: AppPalette.error,
        // ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w300,
            color: AppPalette.white,
          ),
        ),
      ),
    ),
  );

  // await Future.delayed(const Duration(seconds: 2));
  // if (context.mounted) Navigator.pop(context);
}

void showSuccessDialog({
  required BuildContext context,
  required String message,
}) async {
  showDialog(
    context: context,
    useSafeArea: true,
    builder: (_) => SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: AlertDialog(
        icon: const Icon(Icons.done_outline_rounded, size: 64.0),
        iconColor: AppPalette.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        backgroundColor: AppPalette.success.withOpacity(0.9),
        // title: const Icon(
        //   Icons.cancel,
        //   size: 64.0,
        //   color: AppPalette.error,
        // ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w300,
            color: AppPalette.white,
          ),
        ),
      ),
    ),
  );

  await Future.delayed(const Duration(seconds: 1));
  if (context.mounted) Navigator.pop(context);
}

Future<File?> pickImageFromGallery() async {
  try {
    final XFile? xFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      return File(xFile.path);
    }
    return null;
  } catch (_) {
    return null;
  }
}

int calculateReadingTime({required String blogContent}) {
  const int avgReadingSpeed = 250;
  final int wordCount = blogContent.split(RegExp(r"\s+")).length;
  return (wordCount / avgReadingSpeed).ceil();
}

String formatDateForBlog({required DateTime dateTime}) =>
    DateFormat("d MMM, yyyy").format(dateTime);
