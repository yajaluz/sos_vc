import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sos_vc/app/data/model/adress.dart';
import 'package:sos_vc/app/ui/auth/login.dart';
import 'package:sos_vc/app/ui/initial/index.dart';
import 'package:sos_vc/app/ui/profile/important.dart';
import 'package:sos_vc/app/ui/profile/my-donation.dart';
import 'package:sos_vc/app/ui/profile/my-order.dart';
import 'package:sos_vc/app/ui/profile/my-region.dart';
import 'package:sos_vc/app/data/model/card.dart' as model;
import '../../data/model/registration.dart';

class MyProfilePageAux extends StatefulWidget {
  static String tag = '/my-profile';

  const MyProfilePageAux({Key? key}) : super(key: key);

  @override
  ProfilePage createState() => ProfilePage();
}

class ProfilePage extends State<MyProfilePageAux> {
  List<model.Card> items = model.Card.generateItems(5);
  String email = '', name = '', id = '';
  late Future<Registration?> reg;
  late BuildContext _context;
  User? user = FirebaseAuth.instance.currentUser;
  int activeIndexStep = 0;
  var tipoConta = ['Conta corrente', 'Conta poupança', 'Conta salário'];

//informacoes gerais
  final controllerName = TextEditingController();
  final controllerCPF = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPass = TextEditingController();
  final controllerConfirmPass = TextEditingController();
  final controllerQuantFamily = TextEditingController();

//endereco
  final controllerLogradouro = TextEditingController();
  final controllerPais = TextEditingController();
  final controllerNumero = TextEditingController();
  final controllerBairro = TextEditingController();
  final controllercidade = TextEditingController();
  final controllerEstado = TextEditingController();
  final controllerCEP = TextEditingController();

//conta bancaria
  final controllerBanco = TextEditingController();
  final controllerConta = TextEditingController();
  final controllerAgencia = TextEditingController();

  late String? controllerCount = tipoConta.first;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    getUser();
    // reg = GetRegistrationById(id);
  }

  List<Step> stepList() => [
        Step(
          state: activeIndexStep <= 0 ? StepState.editing : StepState.complete,
          isActive: activeIndexStep >= 0,
          title: Text('Geral'),
          content: Container(
            child: Column(
              children: [
                Center(
                  child: Text('Geral'),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: controllerName,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
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
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controllerCPF,
                  textInputAction: TextInputAction.next,
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.digitsOnly,
                  //   CpfInputFormatter()
                  // ],
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
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (!GetUtils.isCpf(value)) {
                        return 'Digite um CPF válido';
                      }
                    } else {
                      return "O campo CPF não pode ser vazio.";
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Email',
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
                    if (value != null && value.isNotEmpty) {
                      if (value.length < 5) {
                        return 'Email muito curto';
                      } else if (!value.contains('@', 0)) {
                        return 'Email no formato incorreto!';
                      } else {
                        return null;
                      }
                    } else {
                      return "O campo Email não pode ser vazio.";
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controllerQuantFamily,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Quantidade de familiares para cadastrar',
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
                    if (value != null && value.isNotEmpty) {
                      if (int.parse(value) < 0 || int.parse(value) > 10) {
                        return 'Digite uma quantidade entre 0 e 10';
                      } else {
                        setState(() {
                          items = model.Card.generateItems(
                              int.parse(controllerQuantFamily.toString()));
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 10),
                // !controllerQuantFamily.value.isNull
                //     ? ExpansionPanelList(
                //         expansionCallback: (panelIndex, isExpanded) {
                //           setState(
                //               () => items[panelIndex].isExpanded = !isExpanded);
                //         },
                //         children: items.map<ExpansionPanel>((model.Card card) {
                //           return ExpansionPanel(
                //               isExpanded: card.isExpanded,
                //               // value: card.uid,
                //               canTapOnHeader: true,
                //               headerBuilder: (context, isExpanded) {
                //                 return ListTile(
                //                   leading: CircleAvatar(
                //                     child: Text(card.uid.toString()),
                //                     backgroundColor: Color(0xFF7540EE),
                //                   ),
                //                   title: Text(card.title),
                //                 );
                //               },
                //               body: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Padding(
                //                     padding:
                //                         const EdgeInsets.only(bottom: 12.0),
                //                     child: Text(card.description),
                //                   )
                //                 ],
                //               ));
                //         }).toList(),
                //       )
                //     : SizedBox(height: 0),
              ],
            ),
          ),
        ),
        Step(
          state: activeIndexStep <= 1 ? StepState.editing : StepState.complete,
          isActive: activeIndexStep >= 1,
          title: Text('Endereço'),
          content: Container(
            child: Column(
              children: [
                Center(
                  child: Text('Endereço'),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: controllerLogradouro,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Logradouro',
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
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: controllerNumero,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Numero',
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
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: controllerBairro,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Bairro',
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
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: controllercidade,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Cidade',
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
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: controllerEstado,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Estado',
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
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: controllerPais,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'País',
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
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          state:
              StepState.complete, //activeIndexStep <= 2 ? StepState.editing :
          isActive: activeIndexStep >= 2,
          title: Text('Conta bancária'),
          content: Container(
            child: Column(
              children: [
                Center(
                  child: Text('Conta bancária'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: controllerBanco,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Banco',
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
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: controllerAgencia,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Agência',
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
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: controllerConta,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Conta',
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
                  ),
                ),
                SizedBox(height: 10),
                DropdownButton(
                    focusColor: Colors.lightBlueAccent,
                    items: tipoConta.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String? novoItemSelecionado) {
                      setState(() {
                        controllerCount = novoItemSelecionado!;
                      });
                    },
                    value: controllerCount),
              ],
            ),
          ),
        ),
      ];

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
                  leading: const Icon(Icons.person),
                  title: const Text('Minha conta'),
                  onTap: () => Get.toNamed(MyProfilePageAux.tag),
                ),
                ListTile(
                  leading: Icon(Icons.map_rounded),
                  title: const Text('Minha região'),
                  onTap: () => Get.toNamed(MyRegionPageAux.tag),
                ),
                ListTile(
                  leading: Icon(Icons.list_alt),
                  title: Text("Meus pedidos"),
                  onTap: () => Get.toNamed(MyOrderPageAux.tag),
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text("Doações"),
                  onTap: () => Get.toNamed(MyFavoritePageAux.tag),
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
          title: const Text('Minha conta'),
          actions: const <Widget>[
            IconButton(
              onPressed: null,
              icon: Icon(Icons.search),
              tooltip: 'Search',
            )
          ],
        ),
        body: Stepper(
          type: StepperType.horizontal,
          currentStep: activeIndexStep,
          steps: stepList(),
          onStepContinue: () {
            if (activeIndexStep < stepList().length - 1) {
              activeIndexStep += 1;
            }
            setState(() {});
          },
          onStepCancel: () {
            if (activeIndexStep == 0) {
              return;
            }

            activeIndexStep -= 1;

            setState(() {});
          },
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

  Future createOrder({required Adress order}) async {
    final docUser =
        FirebaseFirestore.instance.collection('orders').doc(user!.uid!);
    order.id = user!.uid.toString();

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
