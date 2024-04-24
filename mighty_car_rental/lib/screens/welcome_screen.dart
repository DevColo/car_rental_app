import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mighty_car_rental/screens/login_screen.dart';
import 'package:mighty_car_rental/screens/register_screen.dart';
import 'package:mighty_car_rental/src/images.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

final List<String> imageList = [
  welcomeCar10,
  welcomeCar8,
  welcomeCar4,
];
const spinkit = SpinKitSpinningLines(
  color: Color.fromARGB(255, 54, 129, 194),
);

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isLoading = true; // Initial state is loading

  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      // After 3 seconds, set loading to false
      if (mounted) {
        // Check if the widget is still mounted
        setState(() {
          _isLoading = false; // Update the state to render the main content
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if we're still in loading state
    if (_isLoading) {
      // If yes, show the loader
      return const Scaffold(
        body: Center(
          child: spinkit, // Your loading indicator defined earlier
        ),
      );
    }

    // render the main content
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                const WelcomeSilder(),
                //Image.asset(welcomeCar7,scale: 0.5, alignment: Alignment.center),
                const SizedBox(height: 20),
                const WelcomeTitle(),
                const SizedBox(height: 15),
                const WelcomeSubTitle(),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 53, 149, 246)),
                    fixedSize: MaterialStateProperty.all(const Size(300, 45)),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  child: const Text(
                    "Let's Get Started",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const SignUp(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Welcome main title
class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({super.key});

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
                text: 'Your Ultimate ',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat-SemiBold',
                ),
              ),
              TextSpan(
                text: 'Car Rental',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 53, 149, 246),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat-SemiBold',
                ),
              ),
              TextSpan(
                text: ' Experience',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat-SemiBold',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Welcome sub title
class WelcomeSubTitle extends StatelessWidget {
  const WelcomeSubTitle({super.key});

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
                text:
                    'Your journey of possibilities awaits. Drive your dreams anywhere, and at anytime.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 120, 120, 120),
                  fontWeight: FontWeight.w400,
                  //fontFamily: 'OoohBaby',
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
    return SizedBox(
      width: 300,
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              const TextSpan(
                text: "You don't have an account ? ",
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
              ),
              TextSpan(
                text: 'Sign up',
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

// Home screen slider
class WelcomeSilder extends StatefulWidget {
  const WelcomeSilder({super.key});

  @override
  State<WelcomeSilder> createState() => _WelcomeSilderState();
}

class _WelcomeSilderState extends State<WelcomeSilder> {
  @override
  Widget build(BuildContext context) {
    return GFCarousel(
      hasPagination: true,
      items: imageList.map(
        (url) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(1.0)),
              child: Image.asset(
                url,
                fit: BoxFit.scaleDown,
                //width: 2000,
                scale: 2,
              ),
            ),
          );
        },
      ).toList(),
      onPageChanged: (index) {
        setState(() {
          index;
        });
      },
    );
  }
}
