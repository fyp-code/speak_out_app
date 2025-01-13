import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:speak_out_app/utils/app_snackbar.dart';

/// Extension to handle Firestore exceptions and show a message to the user.
extension FirestoreExceptionHandler on FirebaseException {
  void showError(BuildContext? context) {
    String message = _getErrorMessage();

    context == null
        ? Fluttertoast.showToast(msg: message)
        : $showSnackBar(context: context, message: message);
  }

  FirebaseException throwError() {
    String message = _getErrorMessage();

    throw FirebaseException(plugin: 'Firestore', code: code, message: message);
  }

  String showErrorMessage() {
    return _getErrorMessage();
  }

  String _getErrorMessage() {
    switch (code) {
      case 'invalid-argument':
        return 'The request contains invalid arguments. Please check your input and try again.';
      case 'failed-precondition':
        return 'The request could not be completed due to an invalid state. Please try again later.';
      case 'permission-denied':
        return 'You do not have permission to perform this action. Please check your access rights.';
      case 'unauthenticated':
        return 'You must be logged in to perform this action. Please log in and try again.';
      case 'not-found':
        return 'The requested resource could not be found. Please check the identifier and try again.';
      case 'already-exists':
        return 'The resource you are trying to create already exists. Please check and try with a different identifier.';
      case 'resource-exhausted':
        return 'Resource limits have been exceeded. Please try again later.';
      case 'unavailable':
        return 'The service is currently unavailable. Please check your network connection and try again later.';
      case 'internal':
        return 'An internal error occurred. Please try again later. If the problem persists, contact support.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}
