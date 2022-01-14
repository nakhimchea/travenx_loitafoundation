import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/variable.dart';
import 'package:travenx_loitafoundation/screens/portrait/profile_screen/profile.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/profile_widget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPhoneLogin = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/profile_screen/scaffold_background.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: !isPhoneLogin ? CustomAppBar() : LoginAppBar(),
          ),
          Positioned(
            width: constraints.maxWidth,
            bottom: 10.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 67.0),
                  child: !isPhoneLogin
                      ? LoginMethods(isPhoneLogin: isPhoneLogin)
                      : PhoneLogin(),
                ),
                PolicyAgreement(),
                !isPhoneLogin ? SignUpRequest() : SignInRequest(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(top: 44.0, left: 16.0),
          child: Text(
            'Travenx',
            textScaleFactor: textScaleFactor,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 56.0, right: 30.0),
          child: Text(
            'រំលង',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontFamily: 'Nokora',
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    );
  }
}

class LoginAppBar extends StatelessWidget {
  const LoginAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87.0,
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: 50.0),
          Text(
            'ចុះឈ្មោះគណនី លេខទូរសព្ទ',
            textScaleFactor: textScaleFactor,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontFamily: 'Nokora',
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, right: 20.0),
            child: Text(
              'រំលង',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: 'Nokora',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginMethods extends StatelessWidget {
  final bool isPhoneLogin;
  const LoginMethods({
    Key? key,
    required this.isPhoneLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoginCardButton(
          leadingUrl: 'assets/icons/profile_screen/phone_logo.png',
          title: 'ចុះឈ្មោះគណនី លេខទូរសព្ទ',
          onTap: () {
            //isPhoneLogin = true;
          },
        ),
        SizedBox(height: 18.0),
        LoginCardButton(
          leadingUrl: 'assets/icons/profile_screen/facebook_logo.png',
          title: 'ចូលតាមគណនី ហ្វេសប៊ុក',
        ),
        SizedBox(height: 18.0),
        LoginCardButton(
            leadingUrl: 'assets/icons/profile_screen/google_logo.png',
            title: 'ចូលតាមគណនី ',
            trailing: 'Google'),
      ],
    );
  }
}

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();

  bool isCodeSent = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            !isCodeSent ? 'សូមបំពេញលេខទូរសព្ទ' : 'សូមបំពេញលេខកូដ',
            textScaleFactor: textScaleFactor,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontFamily: 'Nokora',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 50.0),
          Column(
            children: [
              Visibility(
                visible: !isCodeSent,
                child: LoginTextField(
                  logoUrl: 'assets/icons/profile_screen/phone_logo.png',
                  hintText: '012345678',
                  constraints: constraints,
                  controller: phoneController,
                ),
              ),
              Visibility(
                visible: isCodeSent,
                child: LoginTextField(
                  logoUrl:
                      'assets/icons/profile_screen/one_time_password_logo.png',
                  hintText: '******',
                  constraints: constraints,
                  controller: otpCodeController,
                ),
              ),
              SizedBox(height: 50.0),
              Visibility(
                visible: !isCodeSent,
                child: GradientButton(
                  title: 'ផ្ញើលេខកូដ',
                  constraints: constraints,
                  onPressed: () {
                    setState(() => isCodeSent = true);
                    print(phoneController.text);
                    verifyNumber();
                  },
                ),
              ),
              Visibility(
                visible: isCodeSent,
                child: GradientButton(
                  title: 'ចូល',
                  constraints: constraints,
                  onPressed: () {
                    setState(() => isCodeSent = false);
                    print(otpCodeController.text);
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Profile()));
                  },
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  void verifyNumber() {}
}

class PolicyAgreement extends StatelessWidget {
  const PolicyAgreement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Policy Button click...'),
      child: Column(
        children: [
          Text(
            'តាមរយ:ការប្រើកម្មវិធីនេះ អ្នកយល់ព្រមទទួលយក',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              height: 1.67,
              fontFamily: 'Nokora',
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            'លក្ខខណ្ឌ និងគោលនយោបាយឯកជនភាព',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              height: 1.67,
              fontFamily: 'Nokora',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class SignInRequest extends StatelessWidget {
  const SignInRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'មានគណនីរួច? ',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            height: 3,
            fontFamily: 'Nokora',
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: () => print('Sign in button click...'),
          child: Text(
            'ចូលតាមគណនីផ្សេងទៀត',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              height: 3,
              fontFamily: 'Nokora',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class SignUpRequest extends StatelessWidget {
  const SignUpRequest({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ត្រូវការគណនី? ',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            height: 3,
            fontFamily: 'Nokora',
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: () => print('Register button click...'),
          child: Text(
            'ចុះឈ្មោះឥឡូវនេះ',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              height: 3,
              fontFamily: 'Nokora',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
