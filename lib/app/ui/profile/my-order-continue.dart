import 'dart:io';
import 'dart:math';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sos_vc/app/data/model/registration.dart';
import 'package:sos_vc/app/ui/auth/login.dart';
import 'package:sos_vc/app/ui/initial/index.dart';
import 'package:sos_vc/app/ui/profile/confirm.dart';
import 'package:sos_vc/app/ui/profile/important.dart';
import 'package:sos_vc/app/ui/profile/my-donation.dart';
import 'package:sos_vc/app/ui/profile/my-profile.dart';
import 'package:sos_vc/app/ui/profile/my-region.dart';
import 'package:sos_vc/app/data/model/card.dart' as card;
import 'package:sos_vc/app/data/model/order.dart' as order;

class MyOrderPageAuxContinue extends StatefulWidget {
  static String tag = '/my-order-continue';

  const MyOrderPageAuxContinue({Key? key}) : super(key: key);

  @override
  OrderPageContinue createState() => OrderPageContinue();
}

class OrderPageContinue extends State<MyOrderPageAuxContinue> {
  User? user = FirebaseAuth.instance.currentUser;
  String name = '', email = '', id = '';
  late BuildContext _context;
  late String? userId;
  static const int MAX = 10000;

//Form
  final _key = GlobalKey<FormState>();
  final _keyPass = GlobalKey<FormState>();
  final controllerName = TextEditingController();
  final controllerNameMother = TextEditingController();
  final controllerNameFather = TextEditingController();
  final controllerCPF = TextEditingController();
  final controllerRG = TextEditingController();
  final controllerBirthDate = TextEditingController();
  final controllerNatural = TextEditingController();

  var gender = ['Female', 'Male', 'Others'];
  var who = ['Para mim mesmo', 'Para familiar', 'Para amigo(a)'];
  var docs = ['Identidade', 'CPF', 'Outros'];
  var statusCivil = [
    'Solteiro(a)',
    'Casado(a)',
    'Viúvo(a)',
    'Divorciado(a)',
    'Separado(a)'
  ];

  late String? controllerWho = who.first;
  late String? controllerGender = gender.first;
  late String? controllerMaritalStatus = statusCivil.first;
  late String? controllerDocs = docs.first;
  late Future<Registration?> registration;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    registration = GetRegistrationById(id);
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: const Color(0xFF7540EE)),
                  accountName: Text(name),
                  accountEmail: Text(email),
                  currentAccountPicture: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.white,
                      child: GestureDetector(
                          child: user!.photoURL == null
                              ? Text(name.characters.first)
                              : ClipOval(
                                  child: Image.file(
                                  File(user!.photoURL!),
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                )),
                          onTap: () => Get.toNamed(MyProfilePageAux.tag))),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: const Text('Início'),
                  onTap: () => Get.toNamed(IndexPageAux.tag),
                ),
                ListTile(
                  leading: Icon(Icons.map_rounded),
                  title: const Text('Minha região'),
                  onTap: () => Get.toNamed(MyRegionPageAux.tag),
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text("Doações"),
                  onTap: () => Get.toNamed(MyFavoritePageAux.tag),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Minha conta'),
                  onTap: () => Get.toNamed(MyProfilePageAux.tag),
                ),
                ListTile(
                  leading: Icon(Icons.notification_important),
                  title: Text("Informações importantes"),
                  onTap: () => Get.toNamed(ImportantPageAux.tag),
                ),
                ListTile(
                  dense: true,
                  title: const Text('Sair'),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () {
                    _context = context;
                    exit();
                  },
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFF7540EE),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
          title: const Text('Meus pedidos'),
          actions: const <Widget>[
            IconButton(
              onPressed: null,
              icon: Icon(Icons.search),
              tooltip: 'Search',
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20, left: 40, right: 40),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: <Widget>[
                      Text(
                        'Order Nº' + Random().nextInt(MAX).toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      Text('Para quem é este documento: '),
                      DropdownButton(
                          focusColor: Colors.lightBlueAccent,
                          items: who.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String? novoItemSelecionado) {
                            setState(() {
                              controllerWho = novoItemSelecionado!;
                            });
                          },
                          value: controllerWho),
                      SizedBox(height: 30),
                      Text('Documento a ser solicitado: '),
                      DropdownButton(
                          focusColor: Colors.lightBlueAccent,
                          items: docs.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String? novoItemSelecionado) {
                            setState(() {
                              controllerDocs = novoItemSelecionado!;
                            });
                          },
                          value: controllerDocs),
                      SizedBox(height: 30),
                      TextFormField(
                        autofocus: true,
                        enabled: false,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        initialValue: name.capitalize,
                        decoration: const InputDecoration(
                          hintText: 'Nome completo',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF787993),
                            fontStyle: FontStyle.italic,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDFDFE4),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF787993),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text('Gênero: '),
                      DropdownButton(
                          // enableFeedback: false,
                          focusColor: Colors.lightBlueAccent,
                          items: gender.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String? novoItemSelecionado) {
                            setState(() {
                              controllerGender = novoItemSelecionado!;
                            });
                          },
                          value: controllerGender),
                      SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        enabled: false,
                        controller: controllerCPF,
                        // initialValue: registration['cpf'].,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'CPF',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF787993),
                            fontStyle: FontStyle.italic,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDFDFE4),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF787993),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      DropdownButton(
                          focusColor: Colors.lightBlueAccent,
                          items: gender.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String? novoItemSelecionado) {
                            setState(() {
                              controllerGender = novoItemSelecionado!;
                            });
                          },
                          value: controllerGender),
                      SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controllerRG,
                        textInputAction: TextInputAction.next,
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.digitsOnly,
                        //   CpfInputFormatter()
                        //   InputForma
                        // ],
                        decoration: const InputDecoration(
                          hintText: 'RG',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF787993),
                            fontStyle: FontStyle.italic,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDFDFE4),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF787993),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: controllerNameMother,
                        autofocus: true,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'Nome da mãe',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF787993),
                            fontStyle: FontStyle.italic,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDFDFE4),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF787993),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value != null && !value.isEmpty) {
                            if (value.length < 6) {
                              return 'O campo deve ter mais que 3 caracteres';
                            } else {
                              return null;
                            }
                          } else {
                            return 'O campo Nome da mãe não pode ser vazio.';
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: controllerNameFather,
                        autofocus: true,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'Nome do pai (opcional)',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF787993),
                            fontStyle: FontStyle.italic,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDFDFE4),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF787993),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: controllerNatural,
                        autofocus: true,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'Naturalidade',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF787993),
                            fontStyle: FontStyle.italic,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDFDFE4),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF787993),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value != null && !value.isEmpty) {
                            if (value.length < 6) {
                              return 'O campo deve ter mais que 3 caracteres';
                            } else {
                              return null;
                            }
                          } else {
                            return 'O campo Naturalidade não pode ser vazio.';
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: controllerBirthDate,
                        autofocus: true,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'Data',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF787993),
                            fontStyle: FontStyle.italic,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDFDFE4),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF787993),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value != null && !value.isEmpty) {
                            return null;
                          } else {
                            return 'O campo Data de nascimento não pode ser vazio.';
                          }
                        },
                      ),
                      SizedBox(height: 30),
                      DropdownButton(
                          focusColor: Colors.lightBlueAccent,
                          items: statusCivil.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String? novoItemSelecionado) {
                            setState(() {
                              controllerMaritalStatus = novoItemSelecionado!;
                            });
                          },
                          value: controllerMaritalStatus),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          // child:
                          child: TextButton(
                              child: const Text(
                                'Solicitar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () =>
                                  {Get.toNamed(ConfirmPageAux.tag)}),
                          decoration: BoxDecoration(
                            color: Color(0xFF7540EE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stream<List<Registration>> GetRegistration() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Registration.fromJson(doc.data()))
          .toList());

  Future<Registration?> GetRegistrationById(String id) async {
    final doc = FirebaseFirestore.instance.collection('users').doc(id);
    final snap = await doc.get();

    if (snap.exists) {
      return Registration.fromJson(snap.data()!);
    }
  }

  Future createOrder({required order.Order order}) async {
    final docUser = FirebaseFirestore.instance.collection('orders').doc(userId);
    order.id = userId.toString();

    final info = order.toJson();
    await docUser.set(info);
  }

  getUser() async {
    if (user != null) {
      setState(() {
        email = user!.email!;
        name = user!.displayName!;
        id = user!.uid;
      });
    }
  }

  exit() async {
    await FirebaseAuth.instance.signOut().then(
          (value) => Navigator.pushReplacement(
            _context,
            MaterialPageRoute(
              builder: (context) => LoginWidget(),
            ),
          ),
        );
  }
}
