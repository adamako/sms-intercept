import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class SmsReceiver extends StatefulWidget {
  @override
  _SmsReceiverState createState() => _SmsReceiverState();
}

class _SmsReceiverState extends State<SmsReceiver> {
  final Telephony telephony = Telephony.instance;
  String messageE;
  DateTime dateReceive;
  String dateSent;
  String contact;
  @override
  void initState() {
    telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          setState(() {
            messageE = message.body;
            dateReceive = DateTime.fromMillisecondsSinceEpoch(message.date);
            dateSent = message.dateSent.toString();
            contact = message.address;
          });
        },
        listenInBackground: false);
    print(dateReceive?.toUtc());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
            : Text('En attente de message...'));
  }
}
