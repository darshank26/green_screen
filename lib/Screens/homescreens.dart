import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_screen/utils/constants.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var backgroundcolor = kgreencolor;

  void initState() {
    super.initState();

    // Execute code when the app is first initialized
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Show a SnackBar after the first frame is rendered
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(

          content: Text('Long Press to open the menu',
            style: TextStyle(color: Colors.black,fontSize: 16), // Text color

          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.white, // Background color

        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {



    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);



    return GestureDetector(
      onLongPress: () {
        _showAlertDialog(context);
      },
      child: Scaffold(backgroundColor: backgroundcolor,
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

                  Navigator.pop(context);

                  _showColorDialog(context);

                },
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('1. Change Color',style: TextStyle(fontSize: 18),),
                ),
              ),
              GestureDetector(
                onTap: () {

                  launcPP();

                },
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('2. Privacy Policy',style: TextStyle(fontSize: 18)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  launchPlay();
                },
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('3. More Apps',style: TextStyle(fontSize: 18)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  launchMoreApps();
                },
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('4. Rate Us',style: TextStyle(fontSize: 18)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  launchShare();
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

  void launcPP() async {

    final Uri url = Uri.parse('https://darshankomu.com/apps/GreenScreen/privacypolicy.html');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void launchPlay() async {
    LaunchReview.launch(
      androidAppId: androidAppIdValue,
      iOSAppId: iOSAppIdValue,);
  }


  void launchMoreApps() async {
    const url = 'https://play.google.com/store/apps/developer?id=Darshan+Komu';  // Replace with your desired URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchShare() {
    Share.share('Download  Green Screen App ${androidAppShareLink}');

  }

  void updateBackgroundColor(Color newColor) {
    setState(() {
      // Set the background color based on a condition or user interaction

      backgroundcolor = newColor;


    });
  }


  void _showColorDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RadioAlertDialog(updateBackgroundColor as Function(Color p1));
      },
    );


  }


}
class RadioAlertDialog extends StatefulWidget {

  final Function(Color) onUpdateBackgroundColor;

  RadioAlertDialog(this.onUpdateBackgroundColor);

  @override
  _RadioAlertDialogState createState() => _RadioAlertDialogState();
}

class _RadioAlertDialogState extends State<RadioAlertDialog> {



  int selectedValue = 0; // -1 means no radio button is selected

  List<String> radioOptions = ['Green', 'Red', 'Blue', 'White', 'Black'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select  Color'),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: radioOptions.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedValue = index;


                  if(selectedValue == 0)
                    {
                      widget.onUpdateBackgroundColor(kgreencolor) ;
                      Navigator.pop(context);
                    }

                 else  if(selectedValue == 1)
                  {
                    widget.onUpdateBackgroundColor(Colors.red) ;
                    Navigator.pop(context);

                  }

                 else  if(selectedValue == 2)
                  {
                    widget.onUpdateBackgroundColor(Colors.blue) ;
                    Navigator.pop(context);

                  }

                 else if(selectedValue == 3)
                  {
                    widget.onUpdateBackgroundColor(Colors.white) ;
                    Navigator.pop(context);

                  }

                  else if(selectedValue == 4)
                  {
                    widget.onUpdateBackgroundColor(Colors.black) ;
                    Navigator.pop(context);

                  }

                });
              },
              child: ListTile(
                title: Text(radioOptions[index]),
                leading: Radio(
                  value: index,
                  groupValue: selectedValue,
                  onChanged: (int? value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Handle the selected option
            print('Selected option: $selectedValue');
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}