import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conocithon_geeks/prescription/customcard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class BoardApp extends StatefulWidget {
  @override
  _BoardAppState createState() => _BoardAppState();
}

class _BoardAppState extends State<BoardApp> {
  TextEditingController doctorController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController patientController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController prescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    var firestoreDb =
        FirebaseFirestore.instance.collection(user.email).snapshots(
              includeMetadataChanges: true,
            );
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF0492c2),
        title: Text(
          'Medical Records',
          style: GoogleFonts.montserrat(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          _showDialog(context);
        },
        child: Icon(FontAwesomeIcons.pen, color: Color(0xFF0492c2)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: firestoreDb,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return CustomCard(snapshot: snapshot.data, index: index);
                  });
            }
          },
        ),
      ),
    );
  }

  _showDialog(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(10),
            content: Column(
              children: [
                Text('Enter Record Details'),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    decoration: InputDecoration(hintText: "Doctor's Name : "),
                    controller: doctorController,
                  ),
                ),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    decoration: InputDecoration(hintText: "Record ID : "),
                    controller: idController,
                  ),
                ),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    decoration: InputDecoration(hintText: "Patient's Name: "),
                    controller: patientController,
                  ),
                ),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    decoration: InputDecoration(hintText: 'Description : '),
                    controller: descriptionController,
                  ),
                ),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    decoration: InputDecoration(hintText: 'Prescription : '),
                    controller: prescriptionController,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
            actions: [
              MaterialButton(
                child: Text('Cancel'),
                onPressed: () {
                  doctorController.clear();
                  descriptionController.clear();
                  patientController.clear();
                  idController.clear();
                  prescriptionController.clear();

                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                child: Text('Save'),
                onPressed: () {
                  if (doctorController.text.isNotEmpty &&
                      prescriptionController.text.isNotEmpty &&
                      idController.text.isNotEmpty &&
                      patientController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    FirebaseFirestore.instance.collection(user.email).add({
                      "doctor": doctorController.text,
                      "description": descriptionController.text,
                      "id": idController.text,
                      "patient": patientController.text,
                      "prescription": prescriptionController.text,
                      "timestamp": new DateTime.now(),
                    }).then((response) {
                      print(response.id);
                      Navigator.pop(context);
                      patientController.clear();
                      descriptionController.clear();
                      prescriptionController.clear();
                      idController.clear();
                      patientController.clear();
                    }).catchError((error) => print('Error'));
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        });
  }
}
