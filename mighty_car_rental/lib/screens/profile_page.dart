import "package:flutter/material.dart";
import "package:mighty_car_rental/main.dart";
import "package:mighty_car_rental/models/auth_model.dart";
import "package:mighty_car_rental/utils/config.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../providers/dio_provider.dart";

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> user = {};

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    user = Provider.of<AuthModel>(context, listen: false).getUser;
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            width: double.infinity,
            color: Config.primaryColor,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 110,
                ),
                // CircleAvatar(
                //   radius: 65.0,
                //   backgroundImage:,
                //   backgroundColor: Colors.white,
                // ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  user['first_name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  user['last_name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Text(
                  user['phone'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  user['email'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            color: Colors.grey[200],
            child: Center(
              child: Card(
                margin: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                child: Container(
                  width: 300,
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        // const Text(
                        //   'Profile',
                        //   style: TextStyle(
                        //     fontSize: 17,
                        //     fontWeight: FontWeight.w800,
                        //   ),
                        // ),
                        Divider(
                          color: Colors.grey[300],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Icon(
                        //       Icons.person,
                        //       color: Colors.blueAccent[400],
                        //       size: 35,
                        //     ),
                        //     const SizedBox(
                        //       width: 20,
                        //     ),
                        //     TextButton(
                        //       onPressed: () {},
                        //       child: const Text(
                        //         "Profile",
                        //         style: TextStyle(
                        //           color: Config.primaryColor,
                        //           fontSize: 15,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Config.spaceSmall,
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Icon(
                        //       Icons.history,
                        //       color: Colors.yellowAccent[400],
                        //       size: 35,
                        //     ),
                        //     const SizedBox(
                        //       width: 20,
                        //     ),
                        //     TextButton(
                        //       onPressed: () {},
                        //       child: const Text(
                        //         "History",
                        //         style: TextStyle(
                        //           color: Config.primaryColor,
                        //           fontSize: 15,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Config.spaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              color: Colors.lightGreen[400],
                              size: 35,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            TextButton(
                              onPressed: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                final token = prefs.getString('token') ?? '';

                                if (token.isNotEmpty && token != '') {
                                  //logout here
                                  final response =
                                      await DioProvider().logout(token);

                                  if (response == 200) {
                                    //if successfully delete access token
                                    //then delete token saved at Shared Preference as well
                                    await prefs.remove('token');
                                    setState(() {
                                      //redirect to login page
                                      MyApp.navigatorKey.currentState!
                                          .pushReplacementNamed('/');
                                    });
                                  }
                                }
                              },
                              child: const Text(
                                "Logout",
                                style: TextStyle(
                                  color: Config.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
