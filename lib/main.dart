import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medkare_admin/firebase_options.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor Duty Scheduler',
      theme: ThemeData(primaryColor: Color.fromARGB(235, 231, 99, 11)),
      home: AdminScreen(),
    );
  }
}

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Map<String, dynamic>> _doctorSchedule = [];
  final _doctorNameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedDuty = "Morning";

  @override
  void initState() {
    super.initState();
    _loadDoctorSchedule();
  }

  void _loadDoctorSchedule() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('schedule').get();
    _doctorSchedule =
        List<Map<String, dynamic>>.from(snapshot.docs.map((doc) => doc.data()));

    setState(() {});
  }

  void _addDoctorSchedule() async {
    Map<String, dynamic> newRow = {
      'doctor_name': _doctorNameController.text,
      'date': DateFormat('yyyy-MM-dd').format(_selectedDate),
      'duty': _selectedDuty,
      'approved': false,
      'reserved': false
    };

    await FirebaseFirestore.instance.collection('schedule').doc().set(newRow);

    _loadDoctorSchedule();
    _doctorNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE65100),
        title: Text(
          'Doctor Duty Scheduler - Admin',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              cursorColor: Colors.black,
              controller: _doctorNameController,
              decoration: InputDecoration(
                labelText: 'Doctor Name',
                labelStyle: TextStyle(color: Color(0xFFE65100)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE65100)),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text(
                  'Select Date:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10.0),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      builder: ((context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                  primary: Color(0xFFE65100),
                                  onPrimary: Colors.white,
                                  onSurface: Colors.black),
                              textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.red))),
                          child: child!,
                        );
                      }),
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text(DateFormat('yyyy-MM-dd').format(_selectedDate)),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: _selectedDuty,
              onChanged: (newValue) {
                setState(() {
                  _selectedDuty = newValue!;
                });
              },
              items: ['Morning', 'Afternoon', 'Night']
                  .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE65100)),
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 16.0),
            Container(
              child: MaterialButton(
                onPressed: _addDoctorSchedule,
                child: Text(
                  'Add Schedule',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              color: Color(0xFFE65100),
            ),
            SizedBox(height: 25.0),
            Text(
              'Doctor Schedule:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _doctorSchedule.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _doctorSchedule[index]['doctor_name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Date: ${_doctorSchedule[index]['date']} - ${_doctorSchedule[index]['duty']}',
                    ),
                    trailing: _doctorSchedule[index]['approved']
                        ? const Text('Booked', style: TextStyle(color: Colors.green))
                        : _doctorSchedule[index]['reserved']
                            ? const Text('Reserved', style: TextStyle(color: Colors.amber),)
                            : const Text('Available'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
