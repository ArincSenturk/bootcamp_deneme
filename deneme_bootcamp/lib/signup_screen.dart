import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt Ol'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:8.0),
                      child: Text("Bilgilerim",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    DecoratedBox(
                      decoration: BoxDecoration(color: Color.fromARGB(218, 177, 78, 195),borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            border: InputBorder.none
                            ),
                          
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    // Parola kısmı
                    DecoratedBox(decoration: BoxDecoration(color: Color.fromARGB(218, 177, 78, 195),borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                         padding: const EdgeInsets.only(left:20.0),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Parola',
                            border: InputBorder.none
                            ),
                          obscureText: true,
                          
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    //Parola  tekrar Kısmı
                    DecoratedBox(
                      decoration: BoxDecoration(color: Color.fromARGB(218, 177, 78, 195),borderRadius: BorderRadius.circular(12)) ,
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: 'Parola Tekrar',
                            border: InputBorder.none
                            ),
                          obscureText: true,
                          
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // Kayıt ol butonu
                    SizedBox(width: 345,height: 50,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.deepPurple,
                         shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                          )
                          ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()&& _passwordController.text ==_confirmPasswordController.text) {
                            _register();
                          } else {var snackBar = SnackBar(content: Text('E-mail veya Parola Hatalı !'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);}
                        },
                        child: Text('Kayıt Ol', style: TextStyle(fontSize: 24),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _register() async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Kullanıcının Firestore'daki döküman yolunu oluşturun
    String uid = userCredential.user!.uid;
    DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);

    // Firestore dökümanını oluşturun
    await userDocRef.set({
      'email': userCredential.user!.email,
      'isUser': 'true', // Kullanıcının adını veya diğer bilgileri buraya ekleyebilirsiniz
    });

    } catch (e) {
      // Kayıt işlemi başarısız oldu.
      // Hata mesajını ekrana veya konsola yazdırabilirsiniz.
      print(e.toString());
    }
  }
}

