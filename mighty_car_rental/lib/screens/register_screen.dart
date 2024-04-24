import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mighty_car_rental/components/register_form.dart';
import 'package:mighty_car_rental/screens/login_screen.dart';
//import 'package:mighty_car_rental/utils/config.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RegisterTitle(),
                RegisterDescription(),
                SizedBox(height: 15),
                RegisterForm(),
                SizedBox(height: 15),
                LoginRedirect(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// login title
class RegisterTitle extends StatelessWidget {
  const RegisterTitle({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 300,
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: const <TextSpan>[
              TextSpan(
                text: 'Create Account',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat-SemiBold',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// register Description
class RegisterDescription extends StatelessWidget {
  const RegisterDescription({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: const <TextSpan>[
              TextSpan(
                text: 'Signup to explore our car rental services.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 120, 120, 120),
                  fontWeight: FontWeight.w400,
                  //fontFamily: 'OoohBaby',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Forgot Password button
class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: 'Forgot password ?',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Navigate to the login screen when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()),
                    );
                  },
                style: const TextStyle(
                  fontSize: 13,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Login Redirect button
class LoginRedirect extends StatelessWidget {
  const LoginRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              const TextSpan(
                text: "You already have an account ? ",
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
              ),
              TextSpan(
                text: 'Log in',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // Navigate to the login screen when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 53, 149, 246),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
