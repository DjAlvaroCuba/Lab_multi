import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:universal_platform/universal_platform.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Detectar la plataforma y mostrar el login correspondiente
    if (UniversalPlatform.isAndroid) {
      return AndroidLogin();
    } else if (UniversalPlatform.isWeb) {
      return WebLogin();
    } else {
      return Scaffold(
        body: Center(child: Text('Esta plataforma no está soportada')),
      );
    }
  }
}

// Pantalla de login para Android
class AndroidLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Android Cuba '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100, // Ajusta el tamaño según lo que necesites
              height: 100, // Ajusta el tamaño según lo que necesites
              child: Image.asset('assets/images/logo.png'), // Ruta de la imagen
            ),
            Text('SIMPLE', style: TextStyle(fontSize: 30, color: Colors.blue ,fontFamily: 'SourceCodePro-Italic-VariableFont_wght'), ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                fillColor: Colors.blue[50],
                filled: true,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Passpharse',
                border: OutlineInputBorder(),
                fillColor: Colors.blue[50],
                filled: true,
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // No funcionalidad de login para este ejemplo
              },
              child: Text('Sign In',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255)),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 165)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        6), // Radio de borde de 0 para cuadrado
                  ),
                ),
                minimumSize: MaterialStateProperty.all(Size.fromHeight(50)),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Reset your passpharse?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 118, 110, 110),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WebLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Web Cubita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 50,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontFamily: 'AlexBrush-Regular',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    fillColor: const Color.fromARGB(255, 219, 224, 219),
                    filled: true,
                  ),
                  style: TextStyle(fontSize: 18, color: Colors.green),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    fillColor: const Color.fromARGB(255, 219, 224, 219),
                    filled: true,
                  ),
                  obscureText: true,
                  style: TextStyle(fontSize: 18, color: Colors.green),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // No funcionalidad de login para este ejemplo
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 15,
                      color: const Color.fromARGB(238, 248, 248, 248),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurple),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 180)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Radio de borde de 20
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size.fromHeight(60)),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Spacer(), // Espacio flexible para empujar el texto "Regístrate" hacia la parte inferior
                Text(
                  'Sign up here',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
