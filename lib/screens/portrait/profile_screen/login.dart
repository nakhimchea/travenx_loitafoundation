import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/variable.dart';
import 'package:travenx_loitafoundation/screens/portrait/profile_screen/phone_login_screen.dart';
import 'package:travenx_loitafoundation/widgets/portrait/profile_screen/login_card_button.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/profile_screen/scaffold_background.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: CustomAppBar(),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          bottom: 20.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 67.0),
                child: Column(
                  children: [
                    LoginCardButton(
                      leadingUrl: 'assets/icons/profile_screen/phone_logo.png',
                      title: 'ចុះឈ្មោះគណនី លេខទូរសព្ទ',
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PhoneLoginScreen())),
                    ),
                    SizedBox(height: 18.0),
                    LoginCardButton(
                      leadingUrl:
                          'assets/icons/profile_screen/facebook_logo.png',
                      title: 'ចូលតាមគណនី ហ្វេសប៊ុក',
                    ),
                    SizedBox(height: 18.0),
                    LoginCardButton(
                        leadingUrl:
                            'assets/icons/profile_screen/google_logo.png',
                        title: 'ចូលតាមគណនី ',
                        trailing: 'Google'),
                  ],
                ),
              ),
              PolicyAgreement(),
              SignUpRequest(),
            ],
          ),
        ),
      ],
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
