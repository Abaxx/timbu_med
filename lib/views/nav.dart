
import 'package:flutter/material.dart';
import 'package:timbu_med_hng/views/cart.dart';
import 'package:timbu_med_hng/views/checkout.dart';
import 'package:timbu_med_hng/views/details.dart';
import 'package:timbu_med_hng/views/favourite.dart';
import 'package:timbu_med_hng/views/home.dart';
import 'package:timbu_med_hng/views/person.dart';

class Nav extends StatefulWidget {
  const Nav({super.key,});

  //final String title;

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {

  final List _widgetOption = [Home(),Cart(),Checkout(),Favourite(),Profile()];
  int selectedIndex = 0;

  void onItemTapped(int index)
  {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: ThemeData(
          //canvasColor: Colors.black,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.deepPurple,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: Colors.black,),
              label: 'Home',),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag,color: Colors.black,),
              label: 'Cart',),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_view_month_sharp,color: Colors.black,),
              label: 'Checkout',),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline_sharp,color: Colors.black,),
              label: 'Favourite',),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,color: Colors.black,),
              label: 'Person',),
          ],
          currentIndex: selectedIndex,
          onTap: onItemTapped,
        ),
      ),
      body: Container(
        child: _widgetOption.elementAt(selectedIndex),
      ),
    );
  }
}
