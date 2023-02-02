import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sos_vc/app/ui/initial/index.dart';
import 'package:sos_vc/app/ui/register/reset-password.dart';

class FingerFaceIDPage extends State<ResetPasswordPage> {
  static String tag = '/finger-faceID';

  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  initState() {
    super.initState();
    authenticate();
  }

  authenticate() async {
    if (await _isBiometricAvailable()) {
      await _getListBiometricTypes();
      await _authenticateUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResetPasswordPage().build(context);
  }

  Future<bool> _isBiometricAvailable() async {
    try {
      bool isAvailable = await _localAuth.canCheckBiometrics;
      return isAvailable;
    } catch (e) {
      return false;
    }
  }

  Future<void> _getListBiometricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _localAuth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _authenticateUser() async {
    bool isAutheticated = false;

    try {
      isAutheticated = await _localAuth.authenticate(
        localizedReason: "Use a biometria registrada para prosseguir",
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: false,
          useErrorDialogs: true,
        ),
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (isAutheticated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => IndexPageAux(),
        ),
      );
    }
  }
}
