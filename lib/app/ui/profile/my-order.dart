import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sos_vc/app/ui/auth/login.dart';
import 'package:sos_vc/app/ui/initial/index.dart';
import 'package:sos_vc/app/ui/profile/important.dart';
import 'package:sos_vc/app/ui/profile/my-donation.dart';
import 'package:sos_vc/app/ui/profile/my-profile.dart';
import 'package:sos_vc/app/ui/profile/my-region.dart';
import 'package:sos_vc/app/data/model/card.dart' as model;

class MyOrderPageAux extends StatefulWidget {
  static String tag = '/my-order';

  const MyOrderPageAux({Key? key}) : super(key: key);

  @override
  OrderPage createState() => OrderPage();
}

class OrderPage extends State<MyOrderPageAux> {
  var name = '', email = '';
  late BuildContext _context;
  User? user = FirebaseAuth.instance.currentUser;
  late String? userId;
  late FirebaseAuth auth;
  int quant = 1;
  late List<model.Card> items; // = model.Card.generateItems(quant);

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    items = model.Card.generateItems(quant);
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
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                quant > 0
                    ? 'Você tem o total de $quant solicitação(s) ativa(s)'
                    : 'Você não tem nenhuma solicitação ativa',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              // child:
              child: TextButton(
                  child: const Text(
                    'Fazer pedido',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      // backgroundColor: Color(0xFF7540EE),
                    ),
                  ),
                  onPressed: () => {} //Get.toNamed(LoginWidget.tag),
                  ),
              // ),
              decoration: BoxDecoration(
                color: Color(0xFF7540EE),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 5),
              child: ExpansionPanelList(
                expansionCallback: (panelIndex, isExpanded) {
                  setState(() => items[panelIndex].isExpanded = !isExpanded);
                },
                children: items.map<ExpansionPanel>((model.Card card) {
                  return ExpansionPanel(
                      isExpanded: card.isExpanded,
                      canTapOnHeader: true,
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(card.uid.toString()),
                            backgroundColor: Color(0xFF7540EE),
                          ),
                          title: Text(card.title),
                        );
                      },
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Text(card.description),
                          )
                        ],
                      ));
                }).toList(),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  // Future createRegistration({required String order}) async {
  //   final docUser = FirebaseFirestore.instance.collection('orders').doc(userId);
  //   // reg.id = userId.toString();

  //   final info = 'quantidade:' + order; //reg.toJson();
  //   await docUser.set(info);
  // }

  getUser() async {
    if (user != null) {
      setState(() {
        email = user!.email!;
        name = user!.displayName!;
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
