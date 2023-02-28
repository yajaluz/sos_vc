import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sos_vc/app/ui/auth/login.dart';
import 'package:sos_vc/app/ui/initial/resume.dart';
import 'package:sos_vc/app/ui/profile/my-favorites.dart';
import 'package:sos_vc/app/ui/profile/my-order.dart';
import 'package:sos_vc/app/ui/profile/my-profile.dart';
import 'package:sos_vc/app/ui/profile/my-region.dart';
import 'package:sos_vc/app/ui/layout.dart';
import 'package:sos_vc/app/data/model/registration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos_vc/app/ui/register/signup.dart';

class IndexPageAux extends StatefulWidget {
  static String tag = '/index';

  const IndexPageAux({Key? key}) : super(key: key);

  @override
  IndexPage createState() => IndexPage();
}

late BuildContext _context;

class IndexPage extends State<IndexPageAux> {
  late int activeIndex = 0;
  String name = '', email = '';
  late Registration reg;
  User? user = FirebaseAuth.instance.currentUser;

  final urlImages = [
    'https://www12.senado.leg.br/noticias/materias/2023/02/23/senadores-se-manifestam-por-tragedia-no-litoral-norte-de-sao-paulo/52705241903_0b08e268d9_k.jpg/mural/imagem_materia',
    'https://static.poder360.com.br/2023/02/Fortes-chuvas-em-SP-848x477.png',
    'https://s2.glbimg.com/-N8PSY_RrPvow6ntv6b_N_46Ev0=/0x0:900x493/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2023/J/l/cB3sqkQFiTuQmEVxC2lg/sem-titulo.jpg'
  ];

  @override
  void initState() {
    super.initState();
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
                          child: user!.photoURL!.isEmpty
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
                  leading: const Icon(Icons.home),
                  title: const Text('Início'),
                  onTap: () => Get.toNamed(IndexPageAux.tag),
                ),
                ListTile(
                  leading: const Icon(Icons.map_rounded),
                  title: const Text('Minha região'),
                  onTap: () => Get.toNamed(MyFavoritePageAux.tag),
                ),
                ListTile(
                  leading: const Icon(Icons.list_alt),
                  title: const Text("Meus pedidos"),
                  onTap: () => Get.toNamed(MyOrderPageAux.tag),
                ),
                ListTile(
                  leading: const Icon(Icons.favorite),
                  title: const Text("Favoritos"),
                  onTap: () => Get.toNamed(MyFavoritePageAux.tag),
                ),
                ListTile(
                  dense: true,
                  title: const Text('Sair'),
                  leading: const Icon(Icons.exit_to_app),
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
          title: const Text('SOS VC'),
          actions: const <Widget>[
            IconButton(
              onPressed: null,
              icon: Icon(Icons.search),
              tooltip: 'Search',
            )
          ],
        ),
        body: ListView(children: <Widget>[
          Center(
            child: Column(children: [
              ResumePage(
                cidade: 'Salvador-BA',
                temperaturaAtual: 28,
                tempMax: 30,
                tempMin: 26,
                descricao: 'Ensolarado',
                numeroIcone: 1,
              ),
            ]),
          ),
          SizedBox(height: 20),
          Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: 250,
                  // initialPage: 0,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  pauseAutoPlayOnTouch: true,
                  pauseAutoPlayOnManualNavigate: true,
                  // onPageChanged: (index, reason) => setState(() {
                  // if (index == urlImages.length - 1) {
                  // activeIndex = 0;
                  // } else {
                  // activeIndex++;
                  // }
                  // }),
                ),
                itemCount: urlImages.length,
                itemBuilder: (context, index, realIndex) {
                  activeIndex = index;
                  final _urlImages = urlImages[index];
                  return buildImage(_urlImages, index);
                },
              ),
              const SizedBox(height: 20),
              buildIndicator(),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget buildImage(String urlImages, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.network(urlImages, fit: BoxFit.cover),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
        effect: const WormEffect(
            dotWidth: 20,
            dotHeight: 20,
            activeDotColor: Color.fromARGB(255, 181, 161, 230),
            dotColor: Color.fromARGB(31, 137, 137, 137)),
      );

  getUser() async {
    if (user != null) {
      setState(() {
        email = user!.email!;
        name = user!.displayName!;
      });

      // DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
      // .collection('users')
      // .doc(user!.uid)
      // .get();

      // var teste = docSnapshot.data();
    }
  }

  // Future<Registration?> getNameByEmail(String email) async {
  // final docUser = FirebaseFirestore.instance
  // .collection('users')
  // .where('email', isEqualTo: email)
  // .limit(1);

  // final snapshot = await docUser.get();

  // if (snapshot.docs.isNotEmpty) {
  // return Registration.fromJson(snapshot.docs.first.data());
  // }
  // return null;
  // }

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
