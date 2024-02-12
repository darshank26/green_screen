import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_screen/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    return GestureDetector(
      onLongPress: () {
        _showAlertDialog(context);
      },
      child: Scaffold(backgroundColor: kgreencolor,
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Green Screen',style: TextStyle(fontSize: 24)),

          content: Container(
            height: 180,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              GestureDetector(
                onTap: () {

                },
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('1. Change Color',style: TextStyle(fontSize: 18),),
                ),
              ),
              GestureDetector(
                onTap: () {

                },
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('2. Privacy Policy',style: TextStyle(fontSize: 18)),
                ),
              ),
              GestureDetector(
                onTap: () {

                },
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('3. More Apps',style: TextStyle(fontSize: 18)),
                ),
              ),
              GestureDetector(
                onTap: () {

                },
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('4. Rate Us',style: TextStyle(fontSize: 18)),
                ),
              ),
              GestureDetector(
                onTap: () {

                },
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('5. Share',style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),),
          actions: [

            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),

            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
