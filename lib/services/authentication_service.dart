import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void showSnackBar(BuildContext context, String text) {
    final snackBar =
        SnackBar(content: Text(text), duration: Duration(seconds: 3));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<String> verifyPhoneNumber(
      BuildContext context, String phoneNumber, int timeoutDuration) async {
    String _smsCodeId = '';

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential).then(
          (value) async => value.user != null
              ? print('user logged in')
              : print('undefined user'));
      showSnackBar(context, 'Verification completed');
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException firebaseAuthException) {
      showSnackBar(context, firebaseAuthException.toString());
    };

    PhoneCodeSent codeSent = (String verificationId, int? forceResendingToken) {
      _smsCodeId = verificationId;
      //print(_smsCodeId);
      showSnackBar(context, 'SMS Code sent to $phoneNumber');
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _smsCodeId = verificationId;
      //print(_smsCodeId);
      showSnackBar(context, 'Time out');
    };

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: Duration(seconds: timeoutDuration),
      );
      // ConfirmationResult confirmationResult =
      //     await _auth.signInWithPhoneNumber(phoneNumber);
      // await confirmationResult.confirm('555555').then((value) async =>
      //     value.user != null
      //         ? print('user logged in')
      //         : print('undefined user'));
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return _smsCodeId;
  }
}
