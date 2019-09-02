import  'package:flutter_socket_io/socket_io_manager.dart';
import  'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Node server demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Client')),
        body: BodyWidget(),
      ),
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  BodyWidgetState createState() {
    return new BodyWidgetState();
  }
}

class BodyWidgetState extends State<BodyWidget> {
  String serverResponse = 'Server response';

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Send request to server'),
                onPressed: () {
                  _makeGetRequest();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(serverResponse),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _makeGetRequest() async {
    print('Making request');
    var url = "https://api.tls.ai:5443";
    // var url = "https://10.200.10.201:5443";
    // var url = "http://192.168.2.71:3000";
    // var url = "http://localhost:3000";

    SocketIO socket = SocketIOManager().createSocketIO(url, "/");
    socket.init();
    socket.subscribe("NEW_DETECTION", onNewDetection); 
    socket.connect();
  }

  void onNewDetection(dynamic message) { 
	  print("New Detection: " + message); 
  }
}
