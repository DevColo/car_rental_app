import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mighty_car_rental/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/custom_appbar.dart';
import '../components/button.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({
    Key? key,
    required this.vehicle,
  }) : super(key: key);

  final Map<String, dynamic> vehicle;

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController startDateController;
  late TextEditingController startTimeController;
  late TextEditingController endDateController;
  late TextEditingController endTimeController;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? token;

  @override
  void initState() {
    super.initState();
    getToken();
    startDateController = TextEditingController();
    startTimeController = TextEditingController();
    endDateController = TextEditingController();
    endTimeController = TextEditingController();
  }

  Future<void> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
  }

  void _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now()
          .add(Duration(days: 365)), // Allow booking up to one year in advance
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        controller.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        controller.text = "${picked.hour}:${picked.minute}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: '${widget.vehicle['vehicle_name']}',
        icon: const FaIcon(Icons.arrow_back_ios),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Start Date:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: startDateController,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate(context, startDateController);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select a date';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Start Time:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: startTimeController,
                      decoration: InputDecoration(
                        labelText: 'Time',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () {
                            _selectTime(context, startTimeController);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select a time';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'End Date:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: endDateController,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate(context, endDateController);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select a date';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'End Time:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: endTimeController,
                      decoration: InputDecoration(
                        labelText: 'Time',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () {
                            _selectTime(context, endTimeController);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select a time';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              Container(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
                  child: Button(
                    width: double.infinity,
                    title: 'Make Appointment',
                    onPressed: () async {
                      // convert date/day/time into string
                      final startDate = startDateController.text;
                      final startTime = startTimeController.text;
                      final endDate = endDateController.text;
                      final endTime = endTimeController.text;

                      try {
                        var response = await Dio().post(
                          //'https://weahtaylor2023-liberia.com/api/book',
                          'http://127.0.0.1/api/book',
                          data: {
                            'start_date': startDate,
                            'start_time': startTime,
                            'end_date': endDate,
                            'end_time': endTime,
                            'vehicle_id': widget.vehicle['id'],
                          },
                          options: Options(
                            headers: {'Authorization': 'Bearer $token'},
                          ),
                        );

                        if (response.statusCode == 200 && response.data != '') {
                          // Show success message
                          Fluttertoast.showToast(
                              msg:
                                  "You have successfully sent a booking request!");
                          // Exit to the previous screen
                          Navigator.pop(context);
                        } else {
                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: ${response.data}'),
                            ),
                          );
                        }
                      } catch (error) {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Oops! Booking was not done, please fill all fields and try again!'),
                            //content: Text('Error: $error'),
                          ),
                        );
                      }
                    },
                    disable: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
