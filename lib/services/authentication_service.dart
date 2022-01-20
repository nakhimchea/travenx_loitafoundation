import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/widgets/custom_snackbar_content.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SnackBar _buildSnackBar({
    required String contentCode,
    String? phoneNumber,
    int duration = 5,
  }) {
    return SnackBar(
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        elevation: 0.0,
        content: CustomSnackBarContent(
          contentCode: contentCode,
          phoneNumber: phoneNumber,
        ),
        duration: Duration(seconds: duration));
  }

  Future<void> verifyPhoneNumber(BuildContext context, String phoneNumber,
      int timeoutDuration, void Function(String) setData) async {
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException firebaseAuthException) async {
      ScaffoldMessenger.of(context)
          .showSnackBar(firebaseAuthException.code == 'invalid-phone-number'
              ? _buildSnackBar(contentCode: 'invalid_phone_number')
              : firebaseAuthException.code == 'network-request-failed'
                  ? _buildSnackBar(contentCode: 'network_request_failed')
                  : _buildSnackBar(contentCode: 'technical_problem'));
    };

    PhoneCodeSent codeSent =
        (String verificationId, int? forceResendingToken) async {
      setData(verificationId);
      ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar(
          contentCode: 'code_sent', phoneNumber: phoneNumber, duration: 3));
    };

    if (kIsWeb) {
      try {
        ConfirmationResult confirmationResult =
            await _auth.signInWithPhoneNumber(phoneNumber);
        setData(confirmationResult.verificationId);
        ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar(
            contentCode: 'code_sent', phoneNumber: phoneNumber, duration: 3));
      } catch (firebaseAuthException) {
        ScaffoldMessenger.of(context).showSnackBar(
            firebaseAuthException.toString().split(' ')[0] ==
                    '[firebase_auth/invalid-phone-number]'
                ? _buildSnackBar(contentCode: 'invalid_phone_number')
                : firebaseAuthException.toString().split(' ')[0] ==
                        '[firebase_auth/network-request-failed]'
                    ? _buildSnackBar(contentCode: 'network_request_failed')
                    : _buildSnackBar(contentCode: 'technical_problem'));
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
