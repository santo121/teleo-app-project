import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MycustomerWidget extends StatefulWidget {
  MycustomerWidget({Key key,this.name,this.phoneNumber}) : super(key: key);
  final String phoneNumber,name;

  @override
  _MycustomerWidgetState createState() => _MycustomerWidgetState();
}

class _MycustomerWidgetState extends State<MycustomerWidget> { 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Padding(
          padding: const EdgeInsets.only(top: 0,bottom: 0),
          child: ListTile(
            onTap: (){
              customLaunch('tel:+91 ${widget.phoneNumber}');
            },
            leading: Icon(Icons.phone),
            title:Text(widget.name!=null?widget.name:""),
            trailing:Icon(Icons.forward),
          ),
        ),
        Divider(),
      ],
    );
    
  }

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    }
  }
}