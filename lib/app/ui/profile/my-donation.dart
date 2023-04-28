import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sos_vc/app/ui/auth/login.dart';
import 'package:sos_vc/app/ui/initial/index.dart';
import 'package:sos_vc/app/ui/profile/important.dart';
import 'package:sos_vc/app/ui/profile/my-order.dart';
import 'package:sos_vc/app/ui/profile/my-profile.dart';
import 'package:sos_vc/app/ui/profile/my-region.dart';

class MyFavoritePageAux extends StatefulWidget {
  static String tag = '/my-favorites';

  const MyFavoritePageAux({Key? key}) : super(key: key);

  @override
  FavoritePage createState() => FavoritePage();
}

class FavoritePage extends State<MyFavoritePageAux> {
  late BuildContext _context;
  String email = '', name = '';
  User? user = FirebaseAuth.instance.currentUser;
  var ongs = ['SOS_VC', 'Mão amiga', 'Salve os seus', 'Solidários servidores'];

  late String? controllerOngs = ongs.first;
  final controllerValue = TextEditingController();

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
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
                  leading: Icon(Icons.list_alt),
                  title: Text("Meus pedidos"),
                  onTap: () => Get.toNamed(MyOrderPageAux.tag),
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
          title: const Text('Meus favoritos'),
          actions: const <Widget>[
            IconButton(
              onPressed: null,
              icon: Icon(Icons.search),
              tooltip: 'Search',
            )
          ],
        ),
        body: ListView(children: <Widget>[
          Center(child: Text('Escolha a instituição')),
          DropdownButton(
              focusColor: Colors.lightBlueAccent,
              items: ongs.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (String? novoItemSelecionado) {
                setState(() {
                  controllerOngs = novoItemSelecionado!;
                });
              },
              value: controllerOngs),
          SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: controllerValue,
            textInputAction: TextInputAction.next,
            // inputFormatters: [
            //   FilteringTextInputFormatter.digitsOnly,
            //   CpfInputFormatter()
            //   InputForma
            // ],
            decoration: const InputDecoration(
              hintText: 'R\$',
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
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              // child:
              child: TextButton(
                  child: const Text(
                    'Doar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => {}),
              decoration: BoxDecoration(
                color: Color(0xFF7540EE),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ]),
      ),
    );
  }

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
