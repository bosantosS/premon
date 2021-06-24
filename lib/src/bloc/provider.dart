// Custom InheretedWidget
import 'package:flutter/material.dart';
import 'package:pre_mon/src/bloc/login_bloc.dart';
export 'package:pre_mon/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {
  
  final loginBloc = LoginBloc();

  Provider({Key key, Widget child})
  : super(key: key,child:child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  // Estado del loginBloc
  static LoginBloc of (BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }


}