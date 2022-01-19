import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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

    if (kIsWeb) {
      try {
        ConfirmationResult confirmationResult =
            await _auth.signInWithPhoneNumber(phoneNumber);
        setData(confirmationResult.verificationId);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('លេខកូដ SMS បានផ្ញើទៅកាន់លេខ $phoneNumber'),
            duration: Duration(seconds: 3)));
      } catch (firebaseAuthException) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(firebaseAuthException.toString().split(' ')[0] ==
                    '[firebase_auth/invalid-phone-number]'
                ? 'លេខទូរសព្ទ ៖ មិនត្រឹមត្រូវ។ សូមបញ្ចូលម្តងទៀត!'
                : firebaseAuthException.toString().split(' ')[0] ==
                        '[firebase_auth/network-request-failed]'
                    ? 'អ៉ីនធឺណែត ៖ មិនដំណើរការ។ សូមព្យាយាមម្តងទៀត!'
                    : 'មានបញ្ហាបច្ចេកទេស!'),
            duration: Duration(seconds: 5)));
      }
    } else {
      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (_) {},
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: (_) {},
          timeout: Duration(seconds: timeoutDuration),
        );
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
