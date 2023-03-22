import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  int _currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(59, 92, 222, 1.0),
        centerTitle: true,
        title: const Text('Edit Information',style: TextStyle(color: Colors.black),),
        leading: const Icon(Icons.menu,color: Colors.black,),
        actions: const [
          Icon(Icons.notifications_none_outlined,color: Colors.black,)
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 25,
                backgroundColor: Color.fromRGBO(59, 92, 222, 1.0),
                child: Icon(
                  Icons.done,
                  size: 40,
                )),
            SizedBox(height: 50,),
            Text('Your Information Updated Successfully',
                style: TextStyle(color: Colors.black54, fontSize: 18)),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        color: const Color.fromRGBO(59, 92, 222, 1.0),

        child: SalomonBottomBar(

          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home,size: 35,),
              title: const Text(""),
              selectedColor: Colors.black,
            ),



          ],
        ),
      ),
    );
  }
}
