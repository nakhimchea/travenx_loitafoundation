import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(BuildContext context, String phoneNumber,
      int timeoutDuration, void Function(String) setData) async {
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException firebaseAuthException) async {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(firebaseAuthException.code == 'invalid-phone-number'
              ? 'លេខទូរសព្ទ ៖ មិនត្រឹមត្រូវ។ សូមបញ្ចូលម្តងទៀត!'
              : firebaseAuthException.code == 'network-request-failed'
                  ? 'អ៉ីនធឺណែត ៖ មិនដំណើរការ។ សូមព្យាយាមម្តងទៀត!'
                  : 'មានបញ្ហាបច្ចេកទេស!'),
          duration: Duration(seconds: 5)));
    };

    PhoneCodeSent codeSent =
        (String verificationId, int? forceResendingToken) async {
      setData(verificationId);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('លេខកូដ SMS បានផ្ញើទៅកាន់លេខ $phoneNumber'),
          duration: Duration(seconds: 3)));
    };

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (_) {},
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (_) {},
        timeout: Duration(seconds: timeoutDuration),
      );
      // ConfirmationResult confirmationResult =
      //     await _auth.signInWithPhoneNumber(phoneNumber);
      // await confirmationResult.confirm('555555').then((value) async =>
      //     value.user != null
      //         ? print('user logged in')
      //         : print('undefined user'));
    } catch (e) {
      print(e.toString());
    }
  }
}
