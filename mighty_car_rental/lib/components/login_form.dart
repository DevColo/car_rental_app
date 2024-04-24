import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mighty_car_rental/main.dart';
import 'package:mighty_car_rental/models/auth_model.dart';
import 'package:mighty_car_rental/providers/dio_provider.dart';
import 'package:mighty_car_rental/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool obsecurePass = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              validator: (value) {
                if (value == "") {
                  return 'Please enter an email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value!)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              // validator: (value) => value == "" ? "Email is required" : null,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Config.primaryColor,
              decoration: InputDecoration(
                labelText: 'Email',
                alignLabelWithHint: true,
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 238, 238, 238)),
                ),
                fillColor: const Color.fromARGB(255, 239, 239, 239),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            Config.spaceSmall,
            TextFormField(
              controller: passwordController,
              validator: (value) => value == "" ? "Password is required" : null,
              keyboardType: TextInputType.visiblePassword,
              cursorColor: Config.primaryColor,
              obscureText: obsecurePass,
              decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                alignLabelWithHint: true,
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 238, 238, 238)),
                ),
                fillColor: const Color.fromARGB(255, 239, 239, 239),
                filled: true,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obsecurePass = !obsecurePass;
                    });
                  },
                  icon: obsecurePass
                      ? const Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.black38,
                        )
                      : const Icon(
                          Icons.visibility_outlined,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            Config.spaceSmall,
            Consumer<AuthModel>(
              builder: (context, auth, child) {
                return ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      //loginForm here
                      final token = await DioProvider().getToken(
                          emailController.text, passwordController.text);

                      if (token) {
                        //auth.loginSuccess(); //update login status
                        //rediret to main page

                        //grab user data here
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        final tokenValue = prefs.getString('token') ?? '';

                        if (tokenValue.isNotEmpty && tokenValue != '') {
                          //get user data
                          final response =
                              await DioProvider().getUser(tokenValue);
                          if (response != null) {
                            setState(() {
                              //json decode
                              Map<String, dynamic> allVehicles = {};
                              final user = json.decode(response);

                              //check if any all_vehicles today
                              for (var vehicles in user['vehicles']) {
                                allVehicles = vehicles;
                              }

                              auth.loginSuccess(user, allVehicles);
                              MyApp.navigatorKey.currentState!
                                  .pushNamed('main');
                            });
                          }
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                "Your email or password is incorrect, try again !",
                            backgroundColor:
                                const Color.fromARGB(255, 144, 144, 144),
                            textColor: Colors.red,
                            gravity: ToastGravity.CENTER,
                            webBgColor:
                                "linear-gradient(to right, Color.fromARGB(255, 144, 144, 144,Color.fromARGB(255, 226, 226, 226))");
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 53, 149, 246)),
                    fixedSize: MaterialStateProperty.all(const Size(500, 45)),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  child: const Text(
                    "Log in",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
