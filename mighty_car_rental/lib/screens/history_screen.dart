import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mighty_car_rental/models/auth_model.dart';
import 'package:mighty_car_rental/providers/dio_provider.dart';
import 'package:mighty_car_rental/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getwidget/getwidget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  Map<String, dynamic> user = {};
  List<dynamic> pendingList = [];
  List<dynamic> approvedList = [];
  List<dynamic> deniedList = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    loadBookingList();
  }

  Future<void> loadBookingList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isNotEmpty && token != '') {
      final response = await DioProvider().getBooking(token);

      if (response != null) {
        setState(() {
          if (json.decode(response)['pending'] != null) {
            pendingList = json.decode(response)['pending'];
          }
          if (json.decode(response)['approved'] != null) {
            approvedList = json.decode(response)['approved'];
          }
          if (json.decode(response)['denied'] != null) {
            deniedList = json.decode(response)['denied'];
          }
        });
      } else {
        setState(() {
          pendingList = [];
          approvedList = [];
          deniedList = [];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    user = Provider.of<AuthModel>(context, listen: false).getUser;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 18),
            GFTabBar(
              unselectedLabelColor: Colors.grey,
              tabBarColor: const Color.fromARGB(255, 243, 243, 243),
              indicatorColor: Colors.blue,
              labelColor: Colors.blue,
              length: 2,
              controller: tabController,
              tabs: const [
                Tab(
                  icon: Icon(
                    Icons.hourglass_empty,
                    color: Colors.green,
                  ),
                  child: Text('Pending', selectionColor: Colors.green),
                ),
                Tab(
                  icon: Icon(
                    Icons.check,
                    color: Colors.blue,
                  ),
                  child: Text('Approved', selectionColor: Colors.blue),
                ),
                Tab(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  child: Text('Denied', selectionColor: Colors.red),
                ),
              ],
            ),
            GFTabBarView(
              controller: tabController,
              children: [
                Container(
                  color: const Color.fromARGB(255, 243, 243, 243),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    child: SafeArea(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 12,
                          horizontalMargin: 5,
                          headingRowColor:
                              const MaterialStatePropertyAll(Colors.green),
                          headingRowHeight: 45,
                          showBottomBorder: true,
                          dataRowMaxHeight: 45,
                          dataRowMinHeight: 45,
                          columns: const <DataColumn>[
                            DataColumn(
                              label: SizedBox(
                                //width: 60,
                                child: Text(
                                  'VEHICLE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 40,
                                child: Text(
                                  'DAYS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 50,
                                child: Text(
                                  '\$ PRICE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                // width: 60,
                                child: Text(
                                  'FROM',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 60,
                                child: Text(
                                  'TO',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                          rows: pendingList.isEmpty
                              ? const <DataRow>[
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      DataCell(Text('No Data Found')),
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                    ],
                                  ),
                                ]
                              : List.generate(
                                  pendingList.length,
                                  (index) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(pendingList[index]
                                            ['vehicle_name'])),
                                        DataCell(
                                            Text(pendingList[index]['days'])),
                                        DataCell(
                                            Text(pendingList[index]['price'])),
                                        DataCell(
                                            Text(pendingList[index]['from'])),
                                        DataCell(
                                            Text(pendingList[index]['to'])),
                                      ],
                                    );
                                  },
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: const Color.fromARGB(255, 243, 243, 243),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    child: SafeArea(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 12,
                          horizontalMargin: 5,
                          headingRowColor:
                              const MaterialStatePropertyAll(Colors.blue),
                          headingRowHeight: 45,
                          showBottomBorder: true,
                          dataRowMaxHeight: 45,
                          dataRowMinHeight: 45,
                          columns: const <DataColumn>[
                            DataColumn(
                              label: SizedBox(
                                //width: 60,
                                child: Text(
                                  'VEHICLE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 40,
                                child: Text(
                                  'DAYS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 50,
                                child: Text(
                                  '\$ PRICE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                // width: 60,
                                child: Text(
                                  'FROM',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 60,
                                child: Text(
                                  'TO',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                          rows: approvedList.isEmpty
                              ? const <DataRow>[
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      DataCell(Text('No Data Found')),
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                    ],
                                  ),
                                ]
                              : List.generate(
                                  approvedList.length,
                                  (index) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(pendingList[index]
                                            ['vehicle_name'])),
                                        DataCell(
                                            Text(pendingList[index]['days'])),
                                        DataCell(
                                            Text(pendingList[index]['price'])),
                                        DataCell(
                                            Text(pendingList[index]['from'])),
                                        DataCell(
                                            Text(pendingList[index]['to'])),
                                      ],
                                    );
                                  },
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: const Color.fromARGB(255, 243, 243, 243),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    child: SafeArea(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 12,
                          horizontalMargin: 5,
                          headingRowColor:
                              const MaterialStatePropertyAll(Colors.red),
                          headingRowHeight: 45,
                          showBottomBorder: true,
                          dataRowMaxHeight: 45,
                          dataRowMinHeight: 45,
                          columns: const <DataColumn>[
                            DataColumn(
                              label: SizedBox(
                                //width: 60,
                                child: Text(
                                  'VEHICLE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 40,
                                child: Text(
                                  'DAYS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 50,
                                child: Text(
                                  '\$ PRICE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                // width: 60,
                                child: Text(
                                  'FROM',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: 60,
                                child: Text(
                                  'TO',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                          rows: deniedList.isEmpty
                              ? const <DataRow>[
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      DataCell(Text('No Data Found')),
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                    ],
                                  ),
                                ]
                              : List.generate(
                                  deniedList.length,
                                  (index) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(pendingList[index]
                                            ['vehicle_name'])),
                                        DataCell(
                                            Text(pendingList[index]['days'])),
                                        DataCell(
                                            Text(pendingList[index]['price'])),
                                        DataCell(
                                            Text(pendingList[index]['from'])),
                                        DataCell(
                                            Text(pendingList[index]['to'])),
                                      ],
                                    );
                                  },
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
