//import 'dart:convert';
//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mighty_car_rental/main.dart';
import 'package:mighty_car_rental/models/auth_model.dart';
import 'package:mighty_car_rental/providers/dio_provider.dart';

import 'package:mighty_car_rental/utils/config.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
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
              controller: firstNameController,
              validator: (value) =>
                  value == "" ? "First name is required" : null,
              keyboardType: TextInputType.name,
              cursorColor: Config.primaryColor,
              decoration: InputDecoration(
                labelText: 'First Name',
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
              controller: lastNameController,
              validator: (value) =>
                  value == "" ? "Last name is required" : null,
              keyboardType: TextInputType.name,
              cursorColor: Config.primaryColor,
              decoration: InputDecoration(
                labelText: 'Last Name',
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
              controller: phoneController,
              validator: (value) =>
                  value == "" ? "Phone number is required" : null,
              keyboardType: TextInputType.phone,
              cursorColor: Config.primaryColor,
              decoration: InputDecoration(
                labelText: 'Phone',
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
              //validator: (value) => value == "" ? "Email is required" : null,
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
                      final userRegistration = await DioProvider().registerUser(
                          firstNameController.text,
                          lastNameController.text,
                          phoneController.text,
                          emailController.text,
                          passwordController.text);

                      //if register success, proceed to login
                      if (userRegistration) {
                        Fluttertoast.showToast(
                            msg: "You have successfully registered!");
                        MyApp.navigatorKey.currentState!.pushNamed('login');
                      } else {
                        Fluttertoast.showToast(
                            msg: userRegistration['error'].toString());
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
                    "Create account",
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
