import 'package:carousel_slider/carousel_slider.dart';
import 'package:conocithon_geeks/bloodbanks/blood_banks_pages_init.dart';
import 'package:conocithon_geeks/bloodbanks/oxygen_banks.dart';
import 'package:conocithon_geeks/bmi/bmi_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'app_themes/themes.dart';
import 'google_login_package/google_signin.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool light;
  List categories = [
    "Thiruvottiyur",
    "Ambattur",
    "Mylapore",
    "Tondiarpet",
    "Alandur",
    "Perambur",
    "Maduravoyal",
    "Aminjikarai",
    "Mambalam",
    "Egmore",
    "Ayanavaram",
    "Shollinganallur",
    "Guindy",
    "Velacherry",
    "Purasaiwakkam"
  ];
  customDivider(String title) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[700],
              height: 10,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[700],
              ),
              borderRadius: BorderRadius.circular(13),
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: GoogleFonts.nunito(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[700],
              height: 10,
            ),
          ),
        ],
      ),
    );
  }

  List topImageCarousel = [
    "assets/news1.jpg",
    "assets/news2.jpg",
    "assets/news3.jpg",
    "assets/news4.jpg",
    "assets/news5.jpg",
  ];

  Product_Carousel(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          height: 230.0,
          child: new CarouselSlider.builder(
            itemCount: topImageCarousel.length,
            options: CarouselOptions(
              pageSnapping: true,
              height: 200,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
              viewportFraction: 0.8,
            ),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SafeArea(
                                child: SizedBox.fromSize(
                                  child: WebView(
                                    initialUrl:
                                        "https://www.hindustantimes.com/india-news/india-crosses-landmark-of-900-million-covid-vaccinations-says-health-minister-101633163053518.html",
                                    javascriptMode: JavascriptMode.unrestricted,
                                  ),
                                ),
                              )));
                },
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage(
                          topImageCarousel[index],
                        ),
                        fit: BoxFit.cover,
                      )),
                ),
              );
            },
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     for (int i = 0; i < 5; i++)
        //       Container(
        //         width: 8,
        //         height: 8,
        //         margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        //         decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             color: i == _ImageCarouselIndex
        //                 ? Color.fromRGBO(0, 0, 0, 0.9)
        //                 : Color.fromRGBO(0, 0, 0, 0.4)),
        //       ),
        //   ],
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color color = Color(0xFF0492c2);
    final user = FirebaseAuth.instance.currentUser;
    final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    themeProvider.isDarkMode ? light = false : light = true;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'PocketDoc',
              style:
                  GoogleFonts.montserrat(color: Theme.of(context).primaryColor),
            ),
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            backgroundColor: color,
            elevation: 10),
        drawer: new Drawer(
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: ClipOval(child: Image.network(user.photoURL)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        "Welcome !!!",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.montserrat(
                          color: Theme.of(context).primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Center(
                                child: Text(
                                  user.displayName,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
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
              Container(
                height: MediaQuery.of(context).size.height * 0.74,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        _launchURL("https://www.cowin.gov.in/");
                      },
                      child: ListTile(
                        title: Text(
                          'Book Covid Vaccine Slots',
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                        leading: Icon(
                          Icons.control_point,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        trailing: Icon(Icons.arrow_right,
                            color: Theme.of(context).secondaryHeaderColor,
                            size: 32),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Divider(
                        color: Theme.of(context).secondaryHeaderColor,
                        thickness: 1,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BloodBankDatsets()));
                      },
                      child: ListTile(
                        title: Text(
                          'Search Blood Banks',
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                        leading: Icon(
                          Icons.local_hospital,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        trailing: Icon(Icons.arrow_right,
                            color: Theme.of(context).secondaryHeaderColor,
                            size: 32),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Divider(
                        color: Theme.of(context).secondaryHeaderColor,
                        thickness: 1,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OxygenBankDatsets()));
                      },
                      child: ListTile(
                        title: Text(
                          'Search Oxygen Banks',
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                        leading: Icon(
                          Icons.local_hospital,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        trailing: Icon(Icons.arrow_right,
                            color: Theme.of(context).secondaryHeaderColor,
                            size: 32),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Divider(
                        color: Theme.of(context).secondaryHeaderColor,
                        thickness: 1,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BmiCalculator()));
                      },
                      child: ListTile(
                        title: Text(
                          'Check your BMI',
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                        leading: Icon(Icons.check_box,
                            color: Theme.of(context).secondaryHeaderColor),
                        trailing: Icon(Icons.arrow_right,
                            color: Theme.of(context).secondaryHeaderColor,
                            size: 32),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Divider(
                        color: Theme.of(context).secondaryHeaderColor,
                        thickness: 1,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          final provider = Provider.of<ThemeProvider>(context,
                              listen: false);
                          provider.toggleTheme(light);
                          light = !light;
                        });
                      },
                      child: ListTile(
                        title: Text(
                          'Change Theme',
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                        leading: light == true
                            ? Icon(Icons.wb_sunny_outlined,
                                color: Theme.of(context).secondaryHeaderColor)
                            : Icon(Icons.wb_incandescent_outlined,
                                color: Theme.of(context).secondaryHeaderColor),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Divider(
                        color: Theme.of(context).secondaryHeaderColor,
                        thickness: 1,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.logout();
                      },
                      child: ListTile(
                        title: Text(
                          'Logout',
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                        trailing: Icon(Icons.arrow_right,
                            color: Theme.of(context).secondaryHeaderColor,
                            size: 32),
                        leading: Icon(
                          Icons.logout,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Divider(
                        color: Theme.of(context).secondaryHeaderColor,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                  width: size.width,
                  height: 30,
                ),
                customDivider("News of the Day"),
                Product_Carousel(context),
                Container(
                  color: Theme.of(context).primaryColor,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 15,
                    ),
                    child: Text(
                      'Hospitals',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.nunito(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 200.0),
                    child: Divider(
                      thickness: 2,
                      color: Color(0xFF0492c2),
                    ),
                  ),
                ),
                Container(
                    width: size.width,
                    color: Theme.of(context).primaryColor,
                    child: CategoryScroll()),
                Container(
                  color: Theme.of(context).primaryColor,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 15,
                    ),
                    child: Text(
                      'Workout',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.nunito(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 200.0),
                    child: Divider(
                      thickness: 2,
                      color: Color(0xFF0492c2),
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SingleRentScroll(size, "Splits Training",
                          "https://play.google.com/store/apps/details?id=splits.splitstraining.dothesplits.splitsin30days"),
                      SingleRentScroll(size, 'Nike Training Club',
                          "https://play.google.com/store/apps/details?id=com.nike.ntc"),
                      SingleRentScroll(size, 'SixPacks in 30 days',
                          "https://play.google.com/store/apps/details?id=sixpack.sixpackabs.absworkout"),
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 15,
                    ),
                    child: Text(
                      'Health Blogs',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.nunito(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 200.0),
                    child: Divider(
                      thickness: 2,
                      color: Color(0xFF0492c2),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SafeArea(
                                  child: SizedBox.fromSize(
                                    child: WebView(
                                      initialUrl:
                                          "https://www.nerdfitness.com/blog/",
                                      javascriptMode:
                                          JavascriptMode.unrestricted,
                                    ),
                                  ),
                                )));
                  },
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(
                          'Tap Here ...',
                          style: GoogleFonts.nunito(
                            color: Colors.green,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget SingleRentScroll(Size size, String title, String navigate) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          _launchURL(navigate);
        },
        child: Container(
          height: 320,
          width: 200,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  offset: Offset(0, 25),
                  blurRadius: 25,
                  spreadRadius: -10)
            ],
            // border: Border.all(color: Theme.of(context).secondaryHeaderColor),
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: new BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/workout.jpg"),
                    ),
                    color: Theme.of(context).primaryColor,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(5.0),
                        topRight: const Radius.circular(5.0))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8.0),
                child: Text(
                  title,
                  style: GoogleFonts.nunito(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 100, bottom: 8),
                child: Divider(
                  color: Colors.blueGrey,
                  thickness: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.nunito(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: "WorkOut",
                          style: GoogleFonts.nunito(
                              color: Theme.of(context).secondaryHeaderColor,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String place) async {
    var url = place;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget CategoryScroll() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        height: 150,
        width: 500,
        child: ListView.builder(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 4,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HospitalList(city: " ")));
                      },
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context).secondaryHeaderColor,
                                blurRadius: 0.1),
                          ],
                          color: Theme.of(context).primaryColor,
                          // border: Border.all(
                          //   color: Theme.of(context).secondaryHeaderColor,
                          // ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        width: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Image.asset("assets/location.jpg",
                                  width: 100, height: 50),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 8, left: 5, right: 5),
                              child: Center(
                                child: Text(
                                  categories[index],
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.mukta(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget SingleCategory(Size size, String image, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).secondaryHeaderColor,
                  blurRadius: 0.1),
            ],
            color: Theme.of(context).primaryColor,
            // border: Border.all(
            //   color: Theme.of(context).secondaryHeaderColor,
            // ),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          width: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child:
                    Image.asset("assets/location.jpg", width: 100, height: 50),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, left: 5, right: 5),
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.mukta(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 12,
                    ),
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

class HospitalList extends StatefulWidget {
  final String city;

  const HospitalList({Key key, this.city}) : super(key: key);
  @override
  _HospitalListState createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0492c2),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          widget.city + " Hospitals",
          style: GoogleFonts.montserrat(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: thiruvotti.length,
          itemBuilder: (context, index) {
            return MaterialButton(
              onPressed: () {
                _launchURL(thiruvotti[index]['Link']);
              },
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context)
                                .secondaryHeaderColor
                                .withAlpha(100),
                            blurRadius: 10.0),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 160,
                                child: Text(
                                  thiruvotti[index]['Name'],
                                  style: GoogleFonts.montserrat(
                                      color: Color(0xFF0492c2),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                thiruvotti[index]['Pincode'].toString(),
                                style: GoogleFonts.montserrat(
                                    fontSize: 17, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                thiruvotti[index]['Hospital number'].toString(),
                                style: GoogleFonts.montserrat(
                                    fontSize: 17,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/location.jpg"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          }),
    );
  }

  _launchURL(String place) async {
    var url = place;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

List thiruvotti = [
  {
    "Name": "Saraswathi Clinic",
    "Address":
        "No.756, 757\/386, Thiruvottiyur High Rd, Gangai Nagar, Periyar Nagar, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "096000 14740",
    "Link": "https:\/\/goo.gl\/maps\/JUT51BKMFWY2vg6t6"
  },
  {
    "Name": "Sugam hospital",
    "Address":
        "349, Thiruvottiyur High Rd, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "044 4050 6070",
    "Link":
        "https:\/\/www.google.com\/maps\/place\/Sugam+Hospital\/@13.1650058,80.3012123,17z\/data=!3m1!4b1!4m5!3m4!1s0x3a525c7cb4b167e9:0x6ee9ae5b31fb6af1!8m2!3d13.1650006!4d80.303401"
  },
  {
    "Name": "Ayush hospital",
    "Address":
        "No.307,T.H.Road, Near Sugam Hospital, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "99405 84754",
    "Link":
        "https:\/\/www.google.com\/maps\/place\/AYUSH+HOSPITAL+TIRUVOTTIYUR\/@13.1641272,80.3011513,17z\/data=!3m1!4b1!4m5!3m4!1s0x3a526fdcb8e5a037:0xfb91f094c60bf4a!8m2!3d13.164122!4d80.30334"
  },
  {
    "Name": "Tanishk Nakshatra hospitals",
    "Address":
        "170, Thiruvottiyur High Rd, opp. to Shanmugam Park, Tirumalai Avenue, Rajakadai, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "044 4353 1223",
    "Link":
        "https:\/\/www.google.com\/maps\/place\/Tanishq+Nakshatra+Hospitals\/@13.1561444,80.2989507,17z\/data=!3m1!4b1!4m5!3m4!1s0x3a526fc1982f0fcd:0x9cf4cd7578d61a20!8m2!3d13.1561392!4d80.3011394"
  },
  {
    "Name": "Aakash Hospital",
    "Address":
        "Bus Depot, 393\/1, Thiruvottiyur High Rd, near Thiruvotriyur, Kamalanagar, Periyar Nagar, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "044 4930 4242",
    "Link":
        "https:\/\/www.google.com\/maps\/place\/Aakash+Hospital\/@13.1695117,80.3020719,17z\/data=!3m1!4b1!4m5!3m4!1s0x3a526fdeab7b62c9:0x828e57126bd21b32!8m2!3d13.1695065!4d80.3042606"
  },
  {
    "Name": "Susi hospital",
    "Address":
        "Susi hospital 665,soundarapandiyanar nagar, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "044 4867 4544",
    "Link":
        "https:\/\/www.google.com\/maps\/place\/susi+hospital\/@13.1701046,80.3043899,17z\/data=!3m1!4b1!4m5!3m4!1s0x3a526fd96dc1a6b9:0x42e0bfa309ec8553!8m2!3d13.1700994!4d80.3065786"
  },
  {
    "Name": "Karthik Hospital",
    "Address":
        "Thiruvottiyur High Road, Periyar Nagar, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "044 2573 0335",
    "Link":
        "https:\/\/www.google.com\/maps\/place\/Karthik+Hospital\/@13.166573,80.3021454,17z\/data=!3m1!4b1!4m5!3m4!1s0x3a526fdc797351f9:0x460141c921fa0e21!8m2!3d13.166573!4d80.3043341"
  },
  {
    "Name": "Suman Hospital & Endo Surgical Center",
    "Address":
        "No.40, Sattangadu High Rd, Thangal, Rajakadai, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "044 2599 2424",
    "Link":
        "https:\/\/www.google.com\/maps\/place\/Suman+Hospital+%26+Endo+Surgical+Center\/@13.1503146,80.2961513,17z\/data=!3m1!4b1!4m5!3m4!1s0x3a526f955d2b8119:0x60a398dcf8c977a5!8m2!3d13.1503146!4d80.29834"
  },
  {
    "Name": "SSS Hospital",
    "Address":
        "Thiruvottiyur High Rd, Sathiyamoorthy Nagar, Rajakadai, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "044 2599 5234",
    "Link":
        "https:\/\/www.google.com\/maps?q=sss+hospital&um=1&ie=UTF-8&sa=X&ved=2ahUKEwjBg6nYyZ_zAhXLUn0KHX78BVsQ_AUoAXoECAMQAw"
  },
  {
    "Name": "Annai Hospital",
    "Address":
        "67\/1, Thiruvottiyur High Rd, Thangal, Vasantha Nagar, Rajakadai, Tiruchanankuppam, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "044 4556 5599",
    "Link":
        "https:\/\/www.google.com\/maps\/place\/Annai+Hospital\/@13.1485275,80.2961725,17z\/data=!3m1!4b1!4m5!3m4!1s0x3a526f95832b8fe7:0xf9ba6909557db179!8m2!3d13.1485223!4d80.2983612"
  },
  {
    "Name": "Vandana Hospital",
    "Address":
        "96, Village St, Near tollgate bus stand, Indira Gandhi Nagar, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "044 2599 4248",
    "Link":
        "https:\/\/www.google.com\/maps\/place\/Vandana+Hospital\/@13.146102,80.2913304,17z\/data=!3m1!4b1!4m5!3m4!1s0x3a526f9400be92cf:0x2657c9acd26b627f!8m2!3d13.146102!4d80.2935191"
  },
  {
    "Name": "Saraswathi Hospital",
    "Address": "no :250, Theradi, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "096000 66625",
    "Link":
        "https:\/\/www.google.com\/maps?q=saraswathi+hospital+tiruvottiyur&gs_lcp=Cgdnd3Mtd2l6EAEYADINCC4QxwEQrwEQChCTAjICCCYyAggmOgcIABBHELADOgcIABCwAxBDOhMILhDHARCvARDIAxCwAxBDEJMCOhAILhDHARCvARDIAxCwAxBDOg4ILhCABBDHARCvARCTAjoLCC4QgAQQxwEQrwE6DAguEMcBEK8BEAoQQzoHCAAQyQMQQzoECAAQQzoECAAQCjoKCC4QxwEQrwEQCjoGCAAQFhAeSgUIOBIBMUoECEEYAFDDC1joHGD1K2gBcAJ4AIABvAKIAf4GkgEHMC4yLjEuMZgBAKABAcgBD8ABAQ&um=1&ie=UTF-8&sa=X&ved=2ahUKEwjZk6XJy5_zAhVmgUsFHTEZBGUQ_AUoAXoECAIQAw"
  },
  {
    "Name": "SS Hospital",
    "Address":
        "10 & 11, Jeevanlal Nagar Ajax, Tiruvottiyur, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "044 2573 1608",
    "Link":
        "https:\/\/www.google.com\/maps\/place\/SS+Hospital\/@13.1738362,80.3012173,17z\/data=!3m1!4b1!4m5!3m4!1s0x3a526fdf4eaaaaab:0x8cd6de1f9b9b9ebe!8m2!3d13.173831!4d80.303406"
  },
  {
    "Name": "Annai Hospital",
    "Address":
        "Poongavanapuram Rd, Sbi Colony, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "090031 33815",
    "Link":
        "https:\/\/www.google.com\/maps\/place\/Annai+Hospital\/@13.1527116,80.3001334,17z\/data=!4m13!1m7!3m6!1s0x3a526fc08e079e45:0xd80ad8e9da22fdb8!2sPoongavanapuram+Rd,+Rajakadai,+Tiruvottiyur,+Chennai,+Tamil+Nadu+600019!3b1!8m2!3d13.1527116!4d80.3023221!3m4!1s0x3a526fc08629ff59:0x524f810a0367ad04!8m2!3d13.1524461!4d80.3020175"
  },
  {
    "Name": "Kalpana Subramanium Hospital",
    "Address":
        "855, T H Road, Tiruvottiyur, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "044 2573 3646",
    "Link": "https:\/\/goo.gl\/maps\/r4yi3HfVSSRpo8Sh9"
  },
  {
    "Name": "Goutham hospital",
    "Address":
        "No.762\/446, T.H.Road, Thiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "098401 38735",
    "Link":
        "https:\/\/www.google.com\/maps\/place\/Goutham+clinic\/@13.166265,80.3016003,17z\/data=!3m1!4b1!4m5!3m4!1s0x3a526fe9ad94a5ff:0x3ab2cee3072a009d!8m2!3d13.166265!4d80.303789"
  },
  {
    "Name": "Leela Speciality Hospital",
    "Address":
        "57, Eluthukaran St, Kaladipet, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "098942 23017",
    "Link": "https:\/\/goo.gl\/maps\/GnjukN1L8aCFv3WP6"
  },
  {
    "Name": "Rohit Hospital",
    "Address":
        "1029, Thiruvottiyur High Rd, Thyagarajapuram, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "044 2599 5858",
    "Link": "https:\/\/goo.gl\/maps\/qcGS9qcjonxGuz1Y9"
  },
  {
    "Name": "Saraswathi Clinic",
    "Address":
        "No.756, 757\/386, Thiruvottiyur High Rd, Gangai Nagar, Periyar Nagar, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "096000 14740",
    "Link": "https:\/\/goo.gl\/maps\/qvdECCh23x2AcYMPA"
  },
  {
    "Name": "Dr Muthuram Umapathy BHMS Homoeopathy Hospital",
    "Address":
        "731-735, Thiruvottiyur High Rd, Periyar Nagar, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "090031 26656",
    "Link": "https:\/\/goo.gl\/maps\/3S5zcAcXXBipn1Jz5"
  },
  {
    "Name": "New leela speciality hospital",
    "Address":
        "31, 59, Thiruvottiyur High Rd, Thangal, Rajakadai, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "094447 79017",
    "Link": "https:\/\/g.page\/new-leela-speciality-hospital?share"
  },
  {
    "Name": "Apollo Hospitals",
    "Address":
        "645, Thiruvottiyur High Rd, Rajakadai, Tiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "044 2591 3333",
    "Link": "https:\/\/goo.gl\/maps\/JLPZP83DUdFvD7Fz6"
  },
  {
    "Name": "Smile Rich Dental Clinic",
    "Address":
        "1, Sattangadu High Road,thiruvottiyur high road,Rajakadai,, Thiruvottiyur, Chennai, Tamil Nadu 600019",
    "Pincode": 600019,
    "Hospital number": "098408 08082",
    "Link": "https:\/\/goo.gl\/maps\/QfuScZFeLMbrzC1B7"
  }
];
