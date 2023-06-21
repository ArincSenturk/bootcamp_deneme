import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
             Padding(
               padding: const EdgeInsets.symmetric(vertical:20.0),
               child: Image.network(
                'https://hips.hearstapps.com/hmg-prod/images/man-with-dog-royalty-free-image-1582281437.jpg'
                ),
             ),
             // 1. buton
             SizedBox(height: 50, width: 200,
               child: ElevatedButton(
                style:ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return UserProfile();
                })));
                         }, child: Text("Evcil Hayvan Karnesi")),
             ),
             SizedBox(height: 20,),//Butonlar arası boşluk
            // 2. buton
            SizedBox(height: 50, width: 200,
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return UserProfile();
                })));
              }, child: Text("Geçmiş Randevularım")),
            ),
            SizedBox(height: 20,),//Butonlar arası boşluk
            // 3. buton
            SizedBox(height: 50, width: 200,
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return UserProfile();
                })));
              }, child: Text("Tahlillerim")),
            ),
            SizedBox(height: 20,),//Butonlar arası boşluk
            //4.buton
            SizedBox(height: 50, width: 200,
              child: ElevatedButton(
                style:ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return UserProfile();
                })));
              }, child: Text("Aşı takvimi")),
            ),
          ],
        ),
      ),
    );
  }
}
