import 'package:flutter/material.dart';
import 'package:pre_mon/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);
  final primaryColor = const Color(0xff1a1a2e);
  final secundaryColor = const Color(0xff16213e);
  final terciaryColor = const Color(0xff0f3460);
  final cuaternaryColor = const Color(0xffe94560);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _createBackground(context),
        _createLoginForm(context),
      ],
    ));
  }

  Widget _createBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final Widget back = Container(
      height: size.height * 0.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(colors: <Color>[
            primaryColor,
            secundaryColor,
          ])),
    );

    final Widget iconBOSS = Container(
      padding: EdgeInsets.only(top: 80.0),
      child: Column(
        children: [
          FadeInImage(
            placeholder: AssetImage('assets/load.gif'),
            image: AssetImage('assets/BOSS.png'),
          ),
          SizedBox(
            height: 10.0,
            width: double.infinity,
          ),
          Text(
            "BOSSARY",
            style: TextStyle(color: cuaternaryColor, fontSize: 25.0),
          ),
        ],
      ),
    );

    // final Widget bubble = Container(
    //   width: 100.0,
    //   height: 100.0,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(100.0),
    //     color: terciaryColor,
    //   ),
    // );

    return Stack(
      children: <Widget>[
        back,
        iconBOSS,
        //Positioned(bottom: 200.0, right: 30.0, child: bubble),
        //Positioned(bottom: 90.0, left: 30.0, child: bubble)
      ],
    );
  }

  Widget _createLoginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Provider.of(context); // Unica instancia de Provider

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 256.0,
            ),
          ),
          Container(
            width: size.width * 0.8,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
                color: terciaryColor,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: primaryColor,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0),
                ]),
            child: Column(
              children: [
                Text(
                  'Ingreso...',
                  style: TextStyle(fontSize: 20.0, color: cuaternaryColor),
                ),
                SizedBox(
                  height: 30.0,
                ),
                _createEmail(bloc),
                SizedBox(
                  height: 30.0,
                ),
                _createPassword(bloc),
                SizedBox(
                  height: 30.0,
                ),
                _createButton(),
              ],
            ),
          ),
          Text(
            'Olvido su contrasenia?...',
            style: TextStyle(color: cuaternaryColor),
          ),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: cuaternaryColor),
              hintText: 'prueba1@test.com',
              hintStyle: TextStyle(color: Colors.white),
              labelText: 'email',
              labelStyle: TextStyle(color: cuaternaryColor, fontSize: 20.0),
              counterText: snapshot.data,
              counterStyle: TextStyle(color: cuaternaryColor),
              errorText: snapshot.error,
            ),
            onChanged: (value) => {bloc.changeEmail(value)},
          ),
        );
      },
    );
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock, color: cuaternaryColor),
                  // hintText: 'prueba1@test.com',
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: 'password',
                  labelStyle:
                      TextStyle(color: cuaternaryColor, fontSize: 20.0),
                  counterText: snapshot.data,
                  counterStyle: TextStyle(color: cuaternaryColor),
                  errorText: snapshot.error
              ),
              onChanged: bloc.changePassword,
            ),
          );
        });
  }

  Widget _createButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 3.0,
      color: cuaternaryColor,
      textColor: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 120.0),
        child: Text('Ingresar'),
      ),
      onPressed: () {},
    );
  }
}
