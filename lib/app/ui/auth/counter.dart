import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sos_vc/app/controller/counter.dart';
import 'package:sos_vc/app/ui/layout.dart';

class Counter extends StatelessWidget {
  static String tag = '/counter';
  final CounterController ctrl = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Layout.render(
        content: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Você clicou este número de vezes'),
              GetX<CounterController>(builder: (counter) {
                return Text(
                  '${counter.val.string}',
                  style: TextStyle(
                    fontSize: 48,
                  ),
                );
              })
            ],
          ),
        ),
        fab: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FloatingActionButton(
                heroTag: 'ok',
                onPressed: () => ctrl.increment(),
                child: Icon(Icons.add),
              ),
              FloatingActionButton(
                heroTag: 'okok',
                onPressed: () => ctrl.decrement(),
                child: Icon(Icons.remove),
              ),
            ]));
  }
}
