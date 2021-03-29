import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:foody/ui/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:foody/widgets/common_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

Future<Map<String, dynamic>> fetchAlbum() async {
  final response =
      await http.get(Uri.https('jsonplaceholder.typicode.com', 'albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return json.decode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class DoctorState extends StatefulWidget {
  @override
  _DoctorState createState() => _DoctorState();
}

class _DoctorState extends State<DoctorState> {
  final double _borderRadius = 24;
  final _formKey = GlobalKey<FormState>();
  String _tes;
  var items = [
    PlaceInfo('Marcellus Michael Herman K.', Color(0xffE9ECEB),
        Color(0xffA9A9A9), 4.4, 'Jl. Dr. Cipto, Semarang', '087700154863'),
    PlaceInfo('Muhammad Sulthan Mazaya', Color(0xffA9A9A9), Color(0xffE9ECEB),
        3.7, 'Jl. Garut, Garut', '0890184984921'),
    PlaceInfo('Daniel J.R. Silitonga', Color(0xffE9ECEB), Color(0xffA9A9A9),
        4.5, 'Jl. Medan, Medan', '081888222990'),
  ];

  @override
  void initState() {
    super.initState();
    // start fetching
    fetchAlbum().then((data) {
      setState(() {
        _tes = data['title'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Pasien'),
        backgroundColor: Colors.lightBlue,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Hi 1!', // Disini jg boleh kalo mau
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text(_tes), // Dummy
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Us'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Help'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Contact Us'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_borderRadius),
                      gradient: LinearGradient(colors: [
                        items[index].startColor,
                        items[index].endColor
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                          color: items[index].endColor,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: CustomPaint(
                      size: Size(150, 150),
                      painter: CustomCardShapePainter(
                          _borderRadius, Color(0xffFFFFFF), Color(0xffF2F3F4)),
                    ),
                  ),
                  Positioned.fill(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                items[index].rating.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Avenir',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              RatingBar(rating: items[index].rating),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                items[index].name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Avenir',
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                items[index].category,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Avenir',
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.black,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Flexible(
                                    child: Text(
                                      items[index].location,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Avenir',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            // borderSide: BorderSide(color: Colors.transparent),
                            icon: const Icon(Icons.perm_media_outlined),
                            tooltip: 'Check Pasien',
                            onPressed: () {
                              _DoctorState createState() => _DoctorState();
                              File _image;

                              Future getImage() async {
                                var image = await ImagePicker.pickImage(
                                    source: ImageSource.gallery);

                                setState(() {
                                  _image = image;
                                });
                              }

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                "Medical Check-Up",
                                                style:
                                                    TextStyle(fontSize: 20.0),
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.close),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          'Nama Pasien : ${items[index].name}',
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Keluhan : ", // Naruh Keluhan
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Contact : ${items[index].category}",
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 0, right: 0),
                                          child:
                                              new Image.asset('sample1.jpg')),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Hasil Diagonsa : ", // Naruh Diagnosa
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          "Confidence Rate : ", // Naruh Confidence Rate
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            10.0, 10.0, 10.0, 0),
                                        child: RaisedButton(
                                          color: Colors.blue,
                                          child: Text(
                                            "Close",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            /* showDialog(
                                context: context,
                                builder: (BuildContext context) => _buildPopupDialog(context),
                              ); */
                          ),
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PlaceInfo {
  final String name;
  final String category;
  final String location;
  final double rating;
  final Color startColor;
  final Color endColor;

  PlaceInfo(this.name, this.startColor, this.endColor, this.rating,
      this.location, this.category);
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

Widget _buildPopupDialog(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  return new AlertDialog();
}

/* void _showSimpleDialog(context) {
  _HomePageState createState() => _HomePageState();
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Call Doctor",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Full Name",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
              style: new TextStyle(
                  fontSize: 14.0, height: 1.0, color: Colors.black),
              decoration: new InputDecoration(
                hintText: "Input Full Name",
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(3.0)),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 15.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Contact",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
              style: new TextStyle(
                  fontSize: 14.0, height: 1.0, color: Colors.black),
              decoration: new InputDecoration(
                hintText: "Input Contact",
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(3.0)),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 15.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Keluhan",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: new TextStyle(
                  fontSize: 14.0, height: 1.0, color: Colors.black),
              decoration: new InputDecoration(
                hintText: "Input Keluhan",
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(3.0)),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 15.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Input Picture",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Center(
              child: _image == null ? Text('No image selected.') : Image.file(_image),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: FloatingActionButton(
              onPressed: getImage,
              tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
              ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
            child: RaisedButton(
              color: Colors.blue,
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {

              },
            ),
          )
        ],
      );
    },
  );
} */
