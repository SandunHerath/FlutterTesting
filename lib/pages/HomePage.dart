import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instaApp/models/user.dart';
import 'package:instaApp/pages/CreateAccountPage.dart';
import 'package:instaApp/pages/NotificationsPage.dart';
import 'package:instaApp/pages/ProfilePage.dart';
import 'package:instaApp/pages/SearchPage.dart';
import 'package:instaApp/pages/TimeLinePage.dart';
import 'package:instaApp/pages/UploadPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final GoogleSignIn gSignIn =GoogleSignIn();
final userReferace = Firestore.instance.collection("users");

final DateTime timeStamp = DateTime.now();

User currentUser;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  bool isSignedIn = false;
  PageController pageController;
  int getPageIndex =0;

  void initState(){
    super.initState();
    pageController = PageController();


    gSignIn.onCurrentUserChanged.listen((gsignInAccount) {
      controlSignIn(gsignInAccount);
    },
    onError:(gError){
      print("Error Message :"+gError);
    });
    gSignIn.signInSilently(suppressErrors: false).then((gsignInAccount){
      controlSignIn(gsignInAccount);
    }).catchError((gError){
        print("Error Message :"+gError);
    });
  }

  controlSignIn(GoogleSignInAccount signInAccount) async{
    if(signInAccount !=null) {

     // await seveUserToFireStore();

      setState(() {
        isSignedIn=true;
      });
    }else{
      setState(() {
        isSignedIn=false;
      });
    }
  }
  seveUserToFireStore() async{
    final GoogleSignInAccount gCurrentUser = gSignIn.currentUser;
    print(gCurrentUser);
    DocumentSnapshot documentSnapshot=await userReferace.document(gCurrentUser.id).get();

    if(!documentSnapshot.exists) {

    final userName = await Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAccountPage()));

    userReferace.document(gCurrentUser.id).setData({
      "id":gCurrentUser,
      "profileName":gCurrentUser.displayName,
      "username" : userName,
      "url" : gCurrentUser.photoUrl,
      "email": gCurrentUser.email,
      "bio": "",
      "timeStamp" : timeStamp,
    });
    documentSnapshot =  await userReferace.document(gCurrentUser.id).get();
    }
  currentUser = User.fromDocument(documentSnapshot);
  }

  void dispose(){

    pageController.dispose();
    super.dispose();
  }

  loginUser(){
    gSignIn.signIn();
  }

  logoutUser(){
    gSignIn.signOut();
  }

  whenPageChanges( int pageIndex){
      setState(() {
        this.getPageIndex =pageIndex;
      });

  }
  onTapChangePage(int pageIndex){
   pageController.animateToPage(pageIndex, duration: Duration(microseconds: 400), curve: Curves.bounceInOut);

  }

//  buildHomeScreen(){
//        return RaisedButton.icon(
//        onPressed: logoutUser,
//        icon: Icon(Icons.close),
//        label: Text("Sign Out")
//    );
//  }

  Scaffold buildHomeScreen(){

  return Scaffold(
    body: PageView(
      children: <Widget>[
        TimeLinePage(),
        SearchPage(),
        UploadPage(),
        NotificationsPage(),
        ProfilePage(),

      ],
      controller: pageController,
        onPageChanged: whenPageChanges,
        physics: NeverScrollableScrollPhysics(),
    ),
    bottomNavigationBar: CupertinoTabBar(
      currentIndex: getPageIndex,
      onTap: onTapChangePage,
      activeColor: Colors.white,
      inactiveColor: Colors.blueGrey,
      backgroundColor: Theme.of(context).accentColor,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home)),
        BottomNavigationBarItem(icon: Icon(Icons.search)),
        BottomNavigationBarItem(icon: Icon(Icons.photo_camera,size: 37.0,)),
        BottomNavigationBarItem(icon: Icon(Icons.favorite)),
        BottomNavigationBarItem(icon: Icon(Icons.person)),

      ],
    ),
  );
  }

  Scaffold buildSignInScreen(){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Theme.of(context).accentColor,Theme.of(context).primaryColor],
          )
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
              Text(
                "Instergram Lite",
                style: TextStyle(fontSize: 90.0,color: Colors.white,fontFamily: 'Signatra'),
              ),
            GestureDetector(
              onTap: ()=>loginUser(),
              child: Container(
                width: 270.0,
                height: 65.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/google_signin_button.png"
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    if(isSignedIn){
      return buildHomeScreen();
    }else{
      return buildSignInScreen();
    }
    //return Text("Here goes Home Page");
  }
}
