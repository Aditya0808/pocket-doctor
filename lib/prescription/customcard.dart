import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

class CustomCard extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;

  const CustomCard({Key key, this.snapshot, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var docId = snapshot.docs[index].id;

    TextEditingController doctorController =
        TextEditingController(text: snapshot.docs[index]['doctor']);
    TextEditingController descriptionController =
        TextEditingController(text: snapshot.docs[index]['description']);
    TextEditingController prescriptionController =
        TextEditingController(text: snapshot.docs[index]['prescription']);
    TextEditingController idController =
        TextEditingController(text: snapshot.docs[index]['id']);
    TextEditingController patientController =
        TextEditingController(text: snapshot.docs[index]['patient']);
    var timeToDate = new DateTime.fromMillisecondsSinceEpoch(
        snapshot.docs[index]['timestamp'].seconds * 1000);
    var dateFormatted = new DateFormat('EEEE , MMM d , y').format(timeToDate);
    final String user = FirebaseAuth.instance.currentUser.email;

    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.lightBlueAccent,
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      snapshot.docs[index]['id'],
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: GoogleFonts.montserrat(
                        color: Theme.of(context).primaryColor,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withAlpha(100), blurRadius: 10.0),
                  ],
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/steth.jpg'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(FontAwesomeIcons.edit),
                  iconSize: 25,
                  color: Colors.green.shade900,
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.all(10),
                            content: Column(
                              children: [
                                Text(
                                  'Update Record',
                                  style: TextStyle(fontFamily: 'Tinos'),
                                ),
                                Expanded(
                                  child: TextField(
                                    autofocus: true,
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                        labelText: "Doctor's Name    ",
                                        labelStyle: GoogleFonts.montserrat(
                                          fontSize: 19,
                                        ),
                                        prefixText:
                                            "                         "),
                                    controller: doctorController,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    autofocus: true,
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                        labelText: 'Record Id  ',
                                        labelStyle: TextStyle(
                                          fontSize: 19,
                                        ),
                                        prefixText:
                                            "                         "),
                                    controller: idController,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    autofocus: true,
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                        labelText: "Patient's Name",
                                        labelStyle: TextStyle(
                                          fontSize: 19,
                                        ),
                                        prefixText:
                                            "                         "),
                                    controller: descriptionController,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    autofocus: true,
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                        labelText: 'Description  ',
                                        labelStyle: TextStyle(
                                          fontSize: 19,
                                        ),
                                        prefixText:
                                            "                         "),
                                    controller: descriptionController,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    autofocus: true,
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                        labelText: 'Prescription  ',
                                        labelStyle: GoogleFonts.montserrat(
                                          fontSize: 19,
                                        ),
                                        prefixText:
                                            "                         "),
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
                                  prescriptionController.clear();
                                  idController.clear();
                                  patientController.clear();

                                  Navigator.pop(context);
                                },
                              ),
                              MaterialButton(
                                //color : Colors.grey,
                                child: Text('Update'),
                                onPressed: () {
                                  if (doctorController.text.isNotEmpty &&
                                      descriptionController.text.isNotEmpty &&
                                      prescriptionController.text.isNotEmpty &&
                                      idController.text.isNotEmpty &&
                                      patientController.text.isNotEmpty) {
                                    FirebaseFirestore.instance
                                        .collection(user)
                                        .doc(docId)
                                        .update({
                                      "doctor": doctorController.text,
                                      "description": descriptionController.text,
                                      "id": idController.text,
                                      "patient": patientController.text,
                                      "prescription":
                                          prescriptionController.text,
                                      "timestamp": new DateTime.now(),
                                    }).then((response) {
                                      // print(response.id);
                                      Navigator.pop(context);
                                      patientController.clear();
                                      descriptionController.clear();
                                      prescriptionController.clear();
                                      idController.clear();
                                      patientController.clear();
                                    }).catchError((error) => print('Error'));
                                  }
                                },
                              ),
                            ],
                          );
                        });
                  },
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(FontAwesomeIcons.trashAlt),
                  iconSize: 25,
                  color: Colors.red,
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection(user)
                        .doc(docId)
                        .delete();
                  },
                ),
                SizedBox(width: 40),
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "See details",
                    style: GoogleFonts.montserrat(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ShowDetails(context, index)));
                  },
                ),
                SizedBox(width: 10),
                MaterialButton(
                    child: Text(
                      'Share',
                      style: GoogleFonts.montserrat(
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Sharing(context, index);
                    }),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    dateFormatted,
                    style: GoogleFonts.montserrat(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void Sharing(BuildContext context, int index) {
    final user = FirebaseAuth.instance.currentUser;

    final RenderBox box = context.findRenderObject();
    final String text = '''Medical Record of ${user.displayName}
         \n\n Doctor's Name : ${snapshot.docs[index]['doctor']}
          \n\n Record ID : ${snapshot.docs[index]['id']} 
        
           \n\n Patient's Name : ${snapshot.docs[index]['patient']} 
              \n\n Description : ${snapshot.docs[index]['description']} 
           \n\n Prescription : ${snapshot.docs[index]['prescription']} ''';
    Share.share(
      text,
      subject: 'Medical Record of ${user.displayName} ',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  Widget ShowDetails(BuildContext context, int index) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0492c2),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Record Details',
          style: GoogleFonts.montserrat(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              Center(
                child: CircleAvatar(
                  radius: 100,
                  child: Image.asset('assets/steth.jpg'),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Doctor's Name  ",
                                  style: GoogleFonts.montserrat(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  child: Text(
                                    snapshot.docs[index]['doctor'],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: Colors.blue.shade900),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Record ID              ',
                                  style: GoogleFonts.montserrat(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  child: Text(
                                    snapshot.docs[index]['id'],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: Colors.blue.shade900),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Patient's Name  ",
                                  style: GoogleFonts.montserrat(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  child: Text(
                                    snapshot.docs[index]['patient'],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: Colors.blue.shade900),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Description          ',
                                  style: GoogleFonts.montserrat(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  child: Text(
                                    snapshot.docs[index]['description'],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: Colors.blue.shade900),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Prescription        ',
                                  style: GoogleFonts.montserrat(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  child: Text(
                                    snapshot.docs[index]['prescription'],
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        color: Colors.blue.shade900),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
