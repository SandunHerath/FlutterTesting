import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_t1/Models/hotel_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HotelCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Exclusive Hotels',
                style: TextStyle(fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing:1.5
                ),),
              GestureDetector(
                onTap: ()=> print('See All'),
                child: Text('See All',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),),
              ),
            ],
          ),
        ),
        Container(
          height: 320.0,

          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hotels.length,
            itemBuilder:(BuildContext context,int index){
             Hotel hotel=hotels[index];

              return Container(
                margin: EdgeInsets.all(10.0),
                width: 240.0,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[

                    Positioned(
                      bottom: 15.0,
                      child: Container(
                        height: 130.0,
                        width: 240.0,

                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,

                            children: <Widget>[
                              SizedBox(height: 20.0,),
                              Text(
                                hotel.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22.0,
                                    letterSpacing: 1.2),
                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                hotel.address,
                                style: TextStyle(
                                  color: Colors.grey

                                ),

                              ),
                              SizedBox(height: 10.0,),
                              Text(
                                '${hotel.price} /night',
                                style: TextStyle(
                                    color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,

                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color:Colors.black26,
                            offset: Offset(0.0,2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image(
                              height: 180.0,
                              width: 240.0,
                              image: AssetImage(hotel.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
