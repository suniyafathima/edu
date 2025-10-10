import 'package:edu/view/book_screen/book_screen.dart';
import 'package:edu/view/home_screen/home_screen.dart';
import 'package:edu/view/user_screen/user_screen.dart';
import 'package:flutter/material.dart';

class Bottomnavigationsc extends StatefulWidget {
  final String token;
  const Bottomnavigationsc({super.key, required this.token});

  @override
  State<Bottomnavigationsc> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigationsc> {
 int index= 0;

  @override
  Widget build(BuildContext context) { 
    List screens=[
    HomeScreen(token:widget.token),
    BookScreen(),
    UserScreen(),

 ];
    return Scaffold(
     
    bottomNavigationBar: BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: index ,
      onTap: (value) {
          index=value;
        setState(() {
       
        });
       
      },
      items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined,color: Color(0xff9F54F8)),
        label:"",
        activeIcon: Icon(Icons.home_filled,color: Color(0xff9F54F8),) ),
      BottomNavigationBarItem(icon: Icon(Icons.book_outlined,color: Color(0xff9F54F8),),
      label:"",
       activeIcon: Icon(Icons.book_sharp,color: Color(0xff9F54F8),)
      ),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline,color: Color(0xff9F54F8)),
      label:"",
       activeIcon: Icon(Icons.person,color: Color(0xff9F54F8),)
      )  
        ]),
        
      body: screens[index],  
        );
  }
}