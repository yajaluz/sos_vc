import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sos_vc/app/ui/auth/login.dart';
import 'package:sos_vc/app/ui/initial/index.dart';
import 'package:sos_vc/app/ui/profile/my-donation.dart';
import 'package:sos_vc/app/ui/profile/my-order.dart';
import 'package:sos_vc/app/ui/profile/my-profile.dart';
import 'package:sos_vc/app/ui/profile/my-region.dart';

class ConfirmPageAux extends StatefulWidget {
  static String tag = '/important';

  const ConfirmPageAux({Key? key}) : super(key: key);

  @override
  ConfirmPage createState() => ConfirmPage();
}

class ConfirmPage extends State<ConfirmPageAux> {
  late BuildContext _context;
  String email = '', name = '';
  User? user = FirebaseAuth.instance.currentUser;

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
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'Sua solicitação foi enviada para os nossos colaboradores.\n Mas não se preocupe! Faremos que a sua experiência seja a melhor e mais rápida possível.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 200,
              height: 250,
              alignment: Alignment(0.0, 1.60),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/DrawKitVectorIllustrationSocialWork&Charity.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
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
