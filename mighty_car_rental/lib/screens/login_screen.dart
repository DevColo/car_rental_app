import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mighty_car_rental/components/login_form.dart';
import 'package:mighty_car_rental/screens/register_screen.dart';
//import 'package:mighty_car_rental/utils/config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                LoginTitle(),
                LoginDescription(),
                SizedBox(height: 50),
                LoginForm(),
                SizedBox(height: 15),
                ForgotPassword(),
                SizedBox(height: 50),
                SignUp()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// login title
class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});
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
                text: 'Login',
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

// login Description
class LoginDescription extends StatelessWidget {
  const LoginDescription({super.key});
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
                text: 'Enjoy the best experience with luxury cars.',
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

// sign up button
class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterScreen()),
        );
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
        fixedSize: MaterialStateProperty.all(const Size(270, 45)),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 15.0)),
        // Add the border style and color here
        side: MaterialStateProperty.all(
          const BorderSide(
            color: Color.fromARGB(255, 53, 149, 246),
            width: 1.0,
          ),
        ),
      ),
      child: const Text(
        "Create new account",
        style: TextStyle(
          fontSize: 15,
          color: Color.fromARGB(255, 53, 149, 246),
        ),
      ),
    );
  }
}
