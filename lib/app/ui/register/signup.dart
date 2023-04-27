import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sos_vc/app/data/model/registration.dart';
import 'package:sos_vc/app/ui/auth/login.dart';
import 'package:sos_vc/app/ui/layout.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:sos_vc/main.dart';

class SignUpAux extends StatefulWidget {
  static String tag = '/signup';

  const SignUpAux({Key? key}) : super(key: key);

  @override
  SignUpPage createState() => SignUpPage();
}

class SignUpPage extends State<SignUpAux> {
  final _key = GlobalKey<FormState>();
  final _keyPass = GlobalKey<FormState>();
  final controllerName = TextEditingController();
  final controllerCPF = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPass = TextEditingController();
  final controllerConfirmPass = TextEditingController();

  UploadTask? upload;
  File? file;
  PlatformFile? pickedFile;
  bool value = true;
  late BuildContext _context;
  late String? userId;
  late FirebaseAuth auth;
  var gender = ['Female', 'Male', 'Others'];
  final defaultImage =
      "https://icon-library.com/images/default-user-icon/default-user-icon-13.jpg";

  late String? controllerGender = gender.first;

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Layout.render(
      content: Container(
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
                GestureDetector(
                  onTap: () {
                    selectFile();
                  },
                  child: Container(
                    width: 200,
                    height: 250,
                    // alignment: Alignment(0.0, 1.60),
                    // decoration: new BoxDecoration(
                    // image: DecorationImage(
                    // //image: AssetImage('assets/default.png'),
                    // fit: BoxFit.fitWidth,
                    // ),
                    // ),
                    child: Wrap(children: [
                      Center(
                        child: pickedFile == null
                            ? CircleAvatar(
                                radius: 100,
                                child: ClipOval(
                                  child: FadeInImage.assetNetwork(
                                    image: defaultImage,
                                    placeholder: 'assets/default.png',
                                    fit: BoxFit.fitWidth,
                                    width: 250,
                                    height: 250,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                radius: 100,
                                child: ClipOval(
                                  child: Image.file(
                                    File(pickedFile!.path!),
                                    fit: BoxFit.cover,
                                    width: 250,
                                    height: 250,
                                  ),
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                      ),
                      Center(
                        child: Container(
                          height: 56,
                          width: 56,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xFF7540EE).withOpacity(.2),
                              border: Border.all(
                                width: 4.0,
                                color: const Color(0xFFFFFFFF),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(56))),
                          child: const SizedBox.expand(
                            child: Icon(
                              FontAwesomeIcons.plus,
                              color: Color(0xFF7540EE),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
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
                  validator: (value) {
                    if (value != null && !value.isEmpty) {
                      if (value.length < 6) {
                        return 'O campo deve ter mais que 3 caracteres';
                      } else {
                        return null;
                      }
                    } else {
                      return 'O campo Nome não pode ser vazio. Digite-o! Queremos te conhecer!';
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controllerCPF,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter()
                  ],
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
                    if (value != null && !value.isEmpty) {
                      if (!GetUtils.isCpf(value)) {
                        return 'Digite um CPF válido';
                      }
                    } else {
                      return "O campo CPF não pode ser vazio.";
                    }
                  },
                ),
                SizedBox(height: 10),
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
                    if (value != null && !value.isEmpty) {
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
                  key: _keyPass,
                  controller: controllerPass,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Senha',
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
                        return 'A senha deve ter pelo menos 6 caracteres.';
                      }
                      if (value != controllerConfirmPass.text) {
                        return 'As senhas digitadas devem ser iguais';
                      }

                      return null;
                    } else {
                      return 'O campo de Senha não pode ser vazio.';
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  // key: _keyPass,
                  controller: controllerConfirmPass,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: 'Confirmar senha',
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
                        return 'A senha deve ter pelo menos 6 caracteres.';
                      }
                      if (value != controllerPass.text) {
                        return 'As senhas digitadas devem ser iguais';
                      }
                      return null;
                    } else {
                      return 'O campo de Senha não pode ser vazio.';
                    }
                  },
                ),
                SizedBox(height: 40),
                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Color(0xFF7540EE).withOpacity(.2),
                    border: Border.all(
                      width: 4.0,
                      color: const Color(0xFFFFFFFF),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(56)),
                  ),
                  child: SizedBox.expand(
                    child: TextButton(
                      child: const Text(
                        'Cadastrar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7540EE),
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        final reg = new Registration(
                            name: controllerName.text,
                            email: controllerEmail.text,
                            CPF: controllerCPF.text,
                            pass: controllerPass.text,
                            firtAccess: 1,
                            gender: controllerGender!);

                        // var v = _key.currentState!.validate();
                        if (_key.currentState != null &&
                            _key.currentState!.validate()) {
                          auth = FirebaseAuth.instance;

                          _key.currentState?.save();
                          _context = context;

                          //storage image
                          uploadTasks();

                          signUp();

                          userId = auth.currentUser!.uid;

                          //salva infos e credenciais
                          createRegistration(reg: reg);

                          // Get.toNamed(LoginWidget.tag);
                        } else {
                          Center(
                              child: Text(
                                  'Cadastro não pode ser salvo =(\nCorrija os campos notificados!'));
                          print(
                              'Cadastro não pode ser salvo =(\nCorrija os campos notificados!');
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: TextButton(
                    child: const Text(
                      'Cancelar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF7540EE),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    onPressed: () => Get.toNamed(LoginWidget.tag),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadTasks() async {
    if (pickedFile == null) return;

    final fileName = basename(pickedFile!.name!);
    final destination = 'files/${fileName}';
    final fileImage = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(destination);

    ref.putFile(fileImage);
  }

  Future createRegistration({required Registration reg}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(userId);
    reg.id = userId.toString();

    final info = reg.toJson();
    await docUser.set(info);
  }

  Future signUp() async {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));

    // configura o button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );

    try {
      await auth
          .createUserWithEmailAndPassword(
              email: controllerEmail.text.trim(),
              password: controllerPass.text.trim())
          .then((value) {
        value.user!.updateDisplayName(controllerName.text.trim());
        value.user!.updatePhotoURL(pickedFile!.path!);

        Navigator.push(_context,
            MaterialPageRoute(builder: ((context) => const LoginWidget())));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        var msg1 = 'Uma conta já esxiste com esse email';
        AlertDialog alerta = AlertDialog(
          title: Text("Erro"),
          content: Text(msg1),
          actions: [
            okButton,
          ],
        );
        print(msg1);
      }
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
