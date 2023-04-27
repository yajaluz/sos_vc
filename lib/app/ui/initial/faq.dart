import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:sos_vc/app/data/model/card.dart' as model;
import 'package:sos_vc/app/ui/layout.dart';

class FAQPageAux extends StatefulWidget {
  static String tag = '/faq';

  const FAQPageAux({Key? key}) : super(key: key);

  @override
  FAQPage createState() => FAQPage();
}

class FAQPage extends State<FAQPageAux> {
  List<model.Card> items = model.Card.generateItems(5);

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: const Color(0xFF7540EE),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
          title: const Text('FAQ'),
          actions: const <Widget>[
            IconButton(
              onPressed: null,
              icon: Icon(Icons.search),
              tooltip: 'Search',
            ),
            IconButton(onPressed: null, icon: Icon(Icons.notifications_none))
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 5),
            child: ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                setState(() => items[panelIndex].isExpanded = !isExpanded);
              },
              children: items.map<ExpansionPanel>((model.Card card) {
                return ExpansionPanel(
                    isExpanded: card.isExpanded,
                    // value: card.uid,
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
      ),
    );
  }
}
