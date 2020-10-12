import 'package:flutter/material.dart';
import 'package:sms/sms.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'SMS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String messageE;
  DateTime dateReceive;
  DateTime dateSent;
  String contact;

  @override
  void initState() {
    SmsReceiver receiver = SmsReceiver();
    receiver.onSmsReceived.listen((SmsMessage message) {
      setState(() {
        messageE = message.body;
        dateReceive = message.date;
        contact = message.sender;
        dateSent = message.dateSent;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: messageE != null
              ? Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Icon(Icons.phone, color: Colors.green),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('$contact'),
                        Text(
                            'Date: ${dateReceive?.day}-${dateReceive?.month}-${dateReceive?.year}')
                      ],
                    ),
                    subtitle: Text('$messageE'),
                    contentPadding: EdgeInsets.all(10),
                  ),
                )
              : Text(
                  'En attente de message...')), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
