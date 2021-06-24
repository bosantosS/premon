import 'dart:async';

import 'package:pre_mon/src/bloc/validators.dart';

class LoginBloc with Validator{

  final _emailCtrl = StreamController<String>.broadcast();
  final _passwordCtrl = StreamController<String>.broadcast();
  
  // Insertar valores al stream
  Function(String) get changeEmail => _emailCtrl.sink.add;
  Function(String) get changePassword => _passwordCtrl.sink.add;

  // Recuperar los datos del stream
  Stream<String> get emailStream => _emailCtrl.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordCtrl.stream.transform(validarPassword);

  dispose(){
    _emailCtrl?.close();
    _passwordCtrl?.close();
  }
}