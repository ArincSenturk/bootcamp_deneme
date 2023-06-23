import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';


class VetRegisterPage extends StatefulWidget {
  @override
  _VetRegisterPageState createState() => _VetRegisterPageState();
}

class _VetRegisterPageState extends State<VetRegisterPage> {
  late File _selectedImage;
   late File _secondSelectedImage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _namesurnameController = TextEditingController();
  TextEditingController _universityController = TextEditingController();
  TextEditingController _speciesController = TextEditingController();
  bool _checkValue1 = false;
  bool _checkValue2 = false;

    Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }
  Future<void> _pickSecondImage() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _secondSelectedImage = File(pickedImage.path);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
     
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
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
                    ),SizedBox(height: 10,),
                    DecoratedBox(
                      decoration: BoxDecoration(color: Color.fromARGB(218, 177, 78, 195),borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: TextFormField(
                          controller: _namesurnameController,
                          decoration: InputDecoration(
                            labelText: 'Ad Soyad',
                            border: InputBorder.none
                            ),
                          
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    DecoratedBox(
                      decoration: BoxDecoration(color: Color.fromARGB(218, 177, 78, 195),borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: TextFormField(
                          controller: _universityController,
                          decoration: InputDecoration(
                            labelText: 'Üniversiteniz',
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
                    SizedBox(height: 10,),
                    DecoratedBox(
                      decoration: BoxDecoration(color: Color.fromARGB(218, 177, 78, 195),borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: TextFormField(
                          controller: _speciesController,
                          decoration: InputDecoration(
                            labelText: 'Baktığınız Türler? örnek: Kedi,Balık,Sincap...',
                            border: InputBorder.none
                            ),
                          
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
              onPressed: _pickImage,
              child: Text('E-devlet Mezuniyet Belgesi Yükle'),),
              SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _pickSecondImage,
                      child: Text('Profil Resmi Yükle'),
                    ), SizedBox(height: 10,),
                    Row(
                      children: [
                        Checkbox(
                          value: _checkValue1,
                          onChanged: (value) {
                            setState(() {
                              _checkValue1 = value!;
                            });
                          },
                        ),
                        Text('Tedavi İçin Evlere Giderim'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _checkValue2,
                          onChanged: (value) {
                            setState(() {
                              _checkValue2 = value!;
                            });
                          },
                        ),
                        Text('Acil Hasta Bakarım'),
                      ],
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
    DocumentReference userDocRef = FirebaseFirestore.instance.collection('Vet').doc(uid);

    // Firestore dökümanını oluşturun
    await userDocRef.set({
      'email': userCredential.user!.email,
      'isVet': 'false', // Kullanıcının adını veya diğer bilgileri buraya ekleyebilirsiniz
       'name': _namesurnameController.text,
       'university': _universityController.text,
       'species': _speciesController.text,
    });
    // Resmi Firebase Storage'a yükle
      final storageRef = FirebaseStorage.instance.ref().child('users/$uid/profile_image.jpg');
      await storageRef.putFile(_selectedImage);

      // Profil resmi Firebase Storage'a yükle
      final secondStorageRef = FirebaseStorage.instance
          .ref()
          .child('profile_picture/$uid/profile_picture.jpg');
      await secondStorageRef.putFile(_secondSelectedImage);

      // Checkbox değerlerini Firestore'a yazdırma
      await userDocRef.update({
        'option1': _checkValue1,
        'option2': _checkValue2,
      });


      print('Kullanıcı kaydedildi, Firestore dökümanı oluşturuldu ve resim Firebase Storage\'a yüklendi.');

    } catch (e) {
      // Kayıt işlemi başarısız oldu.
      // Hata mesajını ekrana veya konsola yazdırabilirsiniz.
      print(e.toString());
    }
  }
}