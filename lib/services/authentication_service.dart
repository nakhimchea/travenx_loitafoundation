import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travenx_loitafoundation/widgets/custom_snackbar_content.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  SnackBar _buildSnackBar(
      {required String contentCode, String? phoneNumber, int duration = 5}) {
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

    if (!kIsWeb) {
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
        ScaffoldMessenger.of(context)
            .showSnackBar(_buildSnackBar(contentCode: 'technical_problem'));
      }
    } else {
      try {
        final ConfirmationResult _confirmationResult =
            await _auth.signInWithPhoneNumber(phoneNumber);
        setData(_confirmationResult.verificationId);
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
    }
  }

  Future<bool> containData(String userId) async => await _firestore
      .collection('profile_screen')
      .doc(userId)
      .get()
      .then((_document) => _document.data() != null ? true : false);

  Future<void> signInWithPhoneNumber(
      BuildContext context,
      String smsCodeId,
      String otpNumber,
      void Function() successfulLoggedInCallback,
      void Function() setProfileCallback,
      [AuthCredential? fbGgAuthCredential]) async {
    try {
      final AuthCredential _phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: smsCodeId,
        smsCode: otpNumber,
      );
      final UserCredential _phoneUserCredential =
          await _auth.signInWithCredential(_phoneAuthCredential);

      if (_phoneUserCredential.user != null) {
        if (fbGgAuthCredential != null) {
          await _auth.signOut();
          final UserCredential _fbGgUserCredential =
              await _auth.signInWithCredential(fbGgAuthCredential);

          try {
            await _firestore
                .collection('profile_screen')
                .doc(_fbGgUserCredential.user!.uid)
                .set({
              'displayName': _fbGgUserCredential.user!.displayName,
              'phoneNumber': _phoneUserCredential.user!.phoneNumber,
              'profileUrl': _fbGgUserCredential.user!.photoURL,
              'backgroundUrl':
                  'assets/images/profile_screen/dummy_background.png',
            });
            await _secureStorage.write(
                key: 'userId', value: _fbGgUserCredential.user!.uid);
            await _secureStorage.write(key: 'isAnonymous', value: 'false');
            setProfileCallback();
          } catch (e) {
            print(
                'Push Data to Firestore with FB/Google SignIn: ${e.toString()}');
          }
        } else {
          if (await containData(_phoneUserCredential.user!.uid)) {
            await _secureStorage.write(
                key: 'userId', value: _phoneUserCredential.user!.uid);
            await _secureStorage.write(key: 'isAnonymous', value: 'false');
            setProfileCallback();
          } else {
            try {
              await _firestore
                  .collection('profile_screen')
                  .doc(_phoneUserCredential.user!.uid)
                  .set({
                'displayName': 'ដើរ លេង',
                'phoneNumber': _phoneUserCredential.user!.phoneNumber,
                'profileUrl': 'assets/images/profile_screen/dummy_profile.png',
                'backgroundUrl':
                    'assets/images/profile_screen/dummy_background.png',
              });
              await _secureStorage.write(
                  key: 'userId', value: _phoneUserCredential.user!.uid);
              await _secureStorage.write(key: 'isAnonymous', value: 'false');
              setProfileCallback();
            } catch (e) {
              print(
                  'Push Data to Firestore with Phone SignIn: ${e.toString()}');
            }
          }
        }
        successfulLoggedInCallback();
        ScaffoldMessenger.of(context).showSnackBar(
            _buildSnackBar(contentCode: 'successful_login', duration: 3));
      } else
        print('Can\'t logged in user.');
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(_buildSnackBar(contentCode: 'invalid_sms_code'));
    }
  }

  Future<void> signInWithFacebook(
      BuildContext context,
      void Function() successfulLoggedInCallback,
      void Function(AuthCredential) pushFacebookAuthCredential,
      void Function() setProfileCallback) async {
    try {
      late AuthCredential _facebookAuthCredential;
      late UserCredential _userCredential;

      if (kIsWeb) {
        _userCredential = await _auth
            .signInWithPopup(FacebookAuthProvider())
            .onError((_, __) async =>
                await _auth.signInWithPopup(GoogleAuthProvider()));
        _facebookAuthCredential = _userCredential.credential!;
      } else {
        final LoginResult facebookLoginResult =
            await FacebookAuth.instance.login();

        _facebookAuthCredential = FacebookAuthProvider.credential(
            facebookLoginResult.accessToken!.token);

        _userCredential = await _auth
            .signInWithCredential(_facebookAuthCredential)
            .onError((_, __) async {
          final GoogleSignInAuthentication googleSignInAuthentication =
              await GoogleSignIn().signIn().then((googleSignInAccount) async =>
                  await googleSignInAccount!.authentication);
          // Google Automatically SignOut from App
          final googleAuthCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken,
          );
          _facebookAuthCredential = googleAuthCredential;
          return await _auth.signInWithCredential(googleAuthCredential);
        });

        // Facebook Logout from App
        await FacebookAuth.instance.logOut();
      }

      if (_userCredential.user != null) {
        final User user = _userCredential.user!;

        if (await containData(user.uid)) {
          await _secureStorage.write(key: 'userId', value: user.uid);
          await _secureStorage.write(key: 'isAnonymous', value: 'false');
          setProfileCallback();

          successfulLoggedInCallback();
          ScaffoldMessenger.of(context).showSnackBar(
              _buildSnackBar(contentCode: 'successful_login', duration: 3));
        } else {
          pushFacebookAuthCredential(_facebookAuthCredential);
        }
      } else
        print('Can\'t logged in user.');
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
          _buildSnackBar(contentCode: 'invalid_facebook_account'));
    }
  }

  Future<void> signInWithGoogle(
      BuildContext context,
      void Function() successfulLoggedInCallback,
      void Function(AuthCredential) pushGoogleAuthCredential,
      void Function() setProfileCallback) async {
    try {
      late AuthCredential _googleAuthCredential;
      late UserCredential _userCredential;

      if (kIsWeb) {
        _userCredential = await _auth
            .signInWithPopup(GoogleAuthProvider())
            .whenComplete(
                () => _googleAuthCredential = _userCredential.credential!);
      } else {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await GoogleSignIn().signIn().then((googleSignInAccount) async =>
                await googleSignInAccount!.authentication);
        // Google Automatically SignOut from App
        _googleAuthCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        _userCredential =
            await _auth.signInWithCredential(_googleAuthCredential);
      }

      if (_userCredential.user != null) {
        final User user = _userCredential.user!;

        if (await containData(user.uid)) {
          await _secureStorage.write(key: 'userId', value: user.uid);
          await _secureStorage.write(key: 'isAnonymous', value: 'false');
          setProfileCallback();

          successfulLoggedInCallback();
          ScaffoldMessenger.of(context).showSnackBar(
              _buildSnackBar(contentCode: 'successful_login', duration: 3));
        } else {
          pushGoogleAuthCredential(_googleAuthCredential);
        }
      } else
        print('Can\'t logged in user.');
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(_buildSnackBar(contentCode: 'invalid_google_account'));
    }
  }
}
