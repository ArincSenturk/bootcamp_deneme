import 'package:deneme_bootcamp/login_screen.dart';
import 'package:deneme_bootcamp/signup_screen.dart';
import 'package:deneme_bootcamp/user_profile.dart';
import 'package:deneme_bootcamp/vet_signup.screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});


  @override
  _SplashScreenState createState() => _SplashScreenState();
}
 class _SplashScreenState extends State<SplashScreen>{
@override
void initState() {
    // TODO: implement initState
    super.initState();
    initializeFirebase();
  }
  Future<void>initializeFirebase() async{
    await Firebase.initializeApp();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return MyHomePage(title: "title");
    },));
  }
  @override
  Widget build(BuildContext context){
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center( 
        child: Column(
          children: [
            ElevatedButton(onPressed:() {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return RegisterPage();
              })));
            }, child: Text("kayıt"),  ),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return LoginScreen();
              })));
            }, child: Text("giriş"),),
             ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return VetRegisterPage();
              })));
            }, child: Text("Vet kayıt"),),
            ElevatedButton(onPressed:() {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return UserProfile();
              })));
            }, child: Text("Profil"),  ),
          ],
        ),
        
      ),
      
      ); 
  }

}