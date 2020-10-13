// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   static const String _title = "Centered Button";

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: _title,
//       home: Center(child: Text("Hello World")),
//       // child: Text("Hello World"),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'dart:convert';

void main() => runApp(GenApp());

class GenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData.dark(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _nameController = TextEditingController();
  var result;

  predictGen(String name) async {
    var url = "https://api.genderize.io/?name=$name";
    var res = await http.get(url);
    var body = jsonDecode(res.body);

    result = "Gender: ${body['gender']}, Probability: ${body['probability']}";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gender Predictor"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Enter Your name to predict it's gender",
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Your Name",
                ),
              ),
            ),
            RaisedButton(
              onPressed: () => predictGen(_nameController.text),
              // onPressed: _nameController.text.length > 0 ? () =>predictGen(_nameController.text) : null,
              child: Text("Predict"),
            ),
            if (result != null) Text(result)
          ],
        ),
      ),
    );
  }
}
