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
  TextEditingController _namesurnameController = TextEditingController();
  List<Map<String, dynamic>> _pets = []; // Kullanıcının evcil hayvanlarını tutmak için liste

  List<String> _vaccines = [
    'Aşı 1',
    'Aşı 2',
    'Aşı 3',
    // Diğer aşılar...
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
    
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              
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
                    // Ad Soyad kısmı
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
                    // Parola kısmı
                    DecoratedBox(
                      
                      decoration: BoxDecoration(color: Color.fromARGB(218, 177, 78, 195),borderRadius: BorderRadius.circular(12)),
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
                      ListView.builder(
                    shrinkWrap: true,
                    itemCount: _pets.length,
                    itemBuilder: (context, index) {
                      final pet = _pets[index];
                      List<String>? vaccines = pet['vaccines'] != null
                          ? List<String>.from(pet['vaccines'])
                          : <String>[];
                      return Column(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(218, 177, 78, 195),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Evcil Hayvan Chip ID',
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    pet['chipId'] = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Aşı Bilgileri',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Column(
                            children: _vaccines.map((vaccine) {
                              return CheckboxListTile(
                                title: Text(vaccine),
                                value: vaccines.contains(vaccine),
                                onChanged: (value) {
                                  setState(() {
                                    if (value!) {
                                      vaccines.add(vaccine);
                                    } else {
                                      vaccines.remove(vaccine);
                                    }
                                    pet['vaccines'] = vaccines;
                                  });
                                },
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 10),
                        ],
                      );
                    },
                  ),

                  // Evcil Hayvan Ekle Butonu
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _pets.add({
                          'chipId': '',
                          'vaccines': [],
                        });
                      });
                    },
                    child: Text('Evcil Hayvan Ekle'),
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

    // Kullanıcının evcil hayvan bilgilerini oluşturun
      List<Map<String, dynamic>> pets = [];
      for (var pet in _pets) {
        String chipId = pet['chipId'];
        List<String>? vaccines = pet['vaccines'];
        DocumentReference petDocRef =
            FirebaseFirestore.instance.collection('pets').doc(chipId);

        await petDocRef.set({
          'chipId': chipId,
          'vaccines': vaccines,
        });

        pets.add({
          'chipId': chipId,
        });
      }
      

      // Firestore dökümanını oluşturun
      await userDocRef.set({
        'name' : _namesurnameController.text,
        'email': userCredential.user!.email,
        'isUser': true,
        'pets': pets,
      });
    } catch (e) {
      // Kayıt işlemi başarısız oldu.
      // Hata mesajını ekrana veya konsola yazdırabilirsiniz.
      print(e.toString());
    }
  }
}

