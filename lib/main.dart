import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'NFT Verification';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: MyApp._title,
      theme: ThemeData(
          brightness: Brightness.dark, primaryColor: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(MyApp._title),
          backgroundColor: Colors.deepPurple,
        ),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController contractAddressController = TextEditingController();
  TextEditingController tokenIDController = TextEditingController();
  String final_response = "";
  String token_id = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // ignore: prefer_const_constructors
              SizedBox(
                height: 20,
              ),
              // const Center(
              //   child: CircleAvatar(
              //     backgroundImage: AssetImage('12.png'),
              //     radius: 100,
              //   ),
              // ),
              const SizedBox(
                height: 100,
              ),
              TextFormField(
                controller: contractAddressController,
                decoration: const InputDecoration(
                  focusColor: Colors.deepPurple,
                  hintText: 'Enter Contract Address',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: tokenIDController,
                decoration: const InputDecoration(
                  hintText: 'Enter Token ID',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.deepPurple),
                    ),
                    onPressed: () async {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState!.validate()) {
                        // Process data.
                        final url = 'http://127.0.0.1:5000';
                        final response = await http.post(Uri.parse(url),
                            body: json.encode({
                              'contract_address':
                                  contractAddressController.text,
                              'token_id': tokenIDController.text
                            }));
                      }
                    },
                    child: const Text('post'),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.deepPurple),
                    ),
                    onPressed: () async {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState!.validate()) {
                        // Process data.
                        final url = 'http://127.0.0.1:5000';

                        //getting data from the python server script and assigning it to response
                        final response = await http.get(Uri.parse(url));

                        //converting the fetched data from json to key value pair that can be displayed on the screen
                        final decoded =
                            json.decode(response.body) as Map<String, dynamic>;

                        //changing the UI be reassigning the fetched data to final response
                        setState(() {
                          final_response = decoded['contract_address'];
                          //token_id = decoded['token_id'];
                        });
                        print("final_response");
                      }
                    },
                    child: const Text('get'),
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
