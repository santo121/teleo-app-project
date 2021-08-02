import 'package:flutter/material.dart';

import 'History/cancelled.dart';
import 'History/fullfilled.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
bool fullfilled = true,cancelled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        elevation: 0,
      ),
      body: Container(
        color: Colors.blue,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        fullfilled=true;
                        cancelled=false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text("F u l l f i l l e d",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),),
                      ),
                     fullfilled? Icon(Icons.arrow_forward,color: Colors.white,):Container()
                    ],),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        fullfilled=false;
                        cancelled=true;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text("C a n c e l l e d",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),),
                      ),
                      cancelled? Icon(Icons.arrow_forward,color: Colors.white,):Container()
                    ],),
                  )
                ],
              ),
            ),
            Expanded(
              child:fullfilled? FullfilledSection():CancelledSection(),
            )
          ],
        ),
      ),
    );
  }
}
