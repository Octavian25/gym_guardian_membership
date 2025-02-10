import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_guardian_membership/utility/constant.dart';

void showError(String message, BuildContext context) {
  FToast fToast;
  fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: const Color.fromARGB(255, 219, 88, 78),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        )),
        TextButton(
          onPressed: () {
            fToast.removeCustomToast();
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            visualDensity: VisualDensity.compact,
          ),
          child: const Text("OK"),
        )
      ],
    ),
  );
  fToast.removeCustomToast();
  fToast.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 5),
  );
}

void showSuccess(String message, BuildContext context) {
  FToast fToast;
  fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      color: primaryColor,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: Text(
          message,
          style: TextStyle(color: onPrimaryColor, fontWeight: FontWeight.bold),
        )),
        TextButton(
          onPressed: () {
            fToast.removeCustomToast();
          },
          style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              foregroundColor: Colors.black,
              backgroundColor: Colors.white),
          child: const Text("OK"),
        )
      ],
    ),
  );
  fToast.removeCustomToast();
  fToast.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 5),
  );
}

void showSuccessWithoutButton(String message, BuildContext context) {
  FToast fToast;
  fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      color: primaryColor,
    ),
    child: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(color: onPrimaryColor, fontWeight: FontWeight.bold),
    ),
  );
  fToast.removeCustomToast();
  fToast.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 5),
  );
}
