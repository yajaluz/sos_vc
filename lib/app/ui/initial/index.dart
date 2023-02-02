import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sos_vc/app/ui/initial/resume.dart';
import 'package:sos_vc/app/ui/layout.dart';

class IndexPageAux extends StatefulWidget {
  static String tag = '/index';

  const IndexPageAux({Key? key}) : super(key: key);

  @override
  IndexPage createState() => IndexPage();
}

class IndexPage extends State<IndexPageAux> {
  // const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          backgroundColor: Color.fromARGB(255, 110, 73, 197),
          child: Column(
            children: <Widget>[
              const UserAccountsDrawerHeader(
                // currentAccountPicture: Image.network('../../../../assets/weather/default.png'),
                accountName: Text('Dear'),
                accountEmail: Text(''),
              ),
              ListTile(
                title: const Text('Teste1'),
                onTap: () => print('object'),
              ),
              ListTile(
                title: const Text('Teste2'),
                onTap: () => print('object'),
              ),
              // ListTile(title: Text('Teste1)',)
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFF7540EE),
          leading: IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
              // if (scaffoldKey.currentState!.isDrawerOpen) {
              //   scaffoldKey.currentState!.closeDrawer();
              //   //close drawer, if drawer is open
              // } else {
              //   scaffoldKey.currentState!.openDrawer();
              //   //open drawer, if drawer is closed
              // }
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
        body: Center(
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
      ),
    );
    // );
    // );
  }
}
