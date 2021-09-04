import 'package:flutter/material.dart';
import 'package:flutter_app_t1/Widgets/destination_carcusel.dart';
import 'package:flutter_app_t1/Widgets/hotel_carcusel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex=0;

  List <IconData> icons=[
    FontAwesomeIcons.plane,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.walking,
    FontAwesomeIcons.biking,
  ];

  //create a widget for icons
  Widget _buildIcon(int index){
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedIndex=index;
        });
        print(selectedIndex);
      },
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: selectedIndex==index? Theme.of(context).accentColor:Color(0xFFE7EBEE),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(
          icons[index],
          size: 25.0,
          color: selectedIndex==index? Theme.of(context).primaryColor : Color(0xFFB4C1C4),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(left: 20.0,right: 120.0),
              child: Text('What do you like to find ?',style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),),
            ),
            SizedBox(height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: icons.asMap().entries.map(
                  (MapEntry map) => _buildIcon(map.key),
              ).toList(),
            ),
            SizedBox(height: 20.0,),
            DestinationCarcusel(),
            HotelCarousel(),
          ],
        ),
      ),
    );
  }
}

