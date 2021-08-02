import 'package:flutter/material.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/Products/mainProductPage.dart';
import 'package:mallu_vendor/BottomNavBar/body%20for%20navbar/home%20page/firstLoadingPage.dart';
import 'body for navbar/Manage Page/ManagePageMain.dart';
import 'body for navbar/profile/profileMainPage.dart';
import 'package:flutter/services.dart';

class BottomNavBar extends StatefulWidget {
  final String vendorToken;
  final String vendorId;
  final int sections ;
  BottomNavBar({this.vendorToken, this.vendorId,@required this.sections});
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex ;
  final TextStyle optionStyle =  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  bool firstLoading = true;
  // DataConnectionStatus status;
  @override
  void initState(){
    super.initState();
    _selectedIndex =widget.sections!=null?widget.sections:0;
  }

  static List<Widget> _widgetOptions = <Widget>[
//    LoadingPage(),
//     Text(
//      'Index 0: Home',
//      style: optionStyle,
//    ),
    //  FirstLoadingPage(),
    FirstLoadingPage(),
    MainProductPage(),

    ManagePageMain(),
    ProfileMainPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('NO'),
                onPressed: () {
                  // SystemNavigator.pop();
                  Navigator.of(context).pop(false);
                },
              ),
              ElevatedButton(
                child: Text('YES'),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return  
    
    WillPopScope( onWillPop: _onBackPressed,
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.now_widgets),
                label: 'Products',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.paste_sharp),
                label: 'Manage',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
                backgroundColor: Colors.blue),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget pageSwitching() =>
      firstLoading ? FirstLoadingPage() : FirstLoadingPage();
}


