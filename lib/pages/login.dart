import 'package:flutter/material.dart';
import './admnprinc.dart';
import './puntoventa.dart';
import '../database/db_helper.dart';
import './registro.dart';
import 'package:logger/logger.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  bool _obscurePassword = true; // Para ocultar/mostrar la contraseña

  // Función de login
  Future<void> _login() async {
    String usuario = usuarioController.text.trim();
    String contrasena = contrasenaController.text.trim();

    if (usuario.isEmpty || contrasena.isEmpty) {
      _mostrarMensaje('Por favor, ingresa usuario y contraseña.');
      return;
    }

    // Buscar el usuario en la base de datos
    var usuarioDb = await DatabaseHelper().obtenerUsuario(usuario, contrasena);

    if (usuarioDb == null || usuarioDb.contrasena != contrasena) {
      _mostrarMensaje('Usuario o contraseña incorrectos.');
      var logger = Logger();

      // Usar el logger para imprimir la información
      logger.i(
          'Usuario encontrado: ${usuarioDb?.usuario},contasena:${usuarioDb?.rol}');
    } else {
      if (!mounted) return;

      if (usuarioDb.rol.trim() == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AdminPage(rol: usuarioDb.contrasena), // Pasa el rol
          ),
        );
      } else if (usuarioDb.rol.trim() == 'empleado') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PuntoDeVentaPage(rol: usuarioDb.rol), // Pasa el rol
          ),
        );
      } else {
        _mostrarMensaje('Rol no válido.');
      }
    }
  }

  // Mostrar un mensaje en la pantalla (puede ser un snackbar o un alert)
  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con imagen
          Positioned.fill(
            child: Image.asset(
              'assets/img/fondo.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Contenedor blanco en la parte superior
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: const Text(
                'El Rincón del pan',
                style: TextStyle(
                  fontSize: 48,
                  fontFamily: 'Italianno',
                  color: Color.fromRGBO(144, 73, 10, 1),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Caja de login con fondo blanco
          Positioned(
            top: 250,
            left: 25,
            right: 25,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: const Border(
                  top: BorderSide(
                      color: Color.fromRGBO(144, 73, 10, 1), width: 10),
                  left: BorderSide(
                      color: Color.fromRGBO(144, 73, 10, 1), width: 10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Aleo',
                        color: Color.fromRGBO(107, 58, 19, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: usuarioController,
                      decoration: const InputDecoration(
                        labelText: 'Usuario:',
                        labelStyle: TextStyle(fontFamily: 'Amethysta'),
                      ),
                    ),
                    const SizedBox(height: 35),
                    TextField(
                      controller: contrasenaController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Contraseña:',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _login, // Llamar la función de login
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        textStyle: const TextStyle(fontSize: 18),
                        backgroundColor: const Color.fromARGB(
                            255, 255, 255, 255), // Fondo blanco del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'Aceptar',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistroPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      icon: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        padding: const EdgeInsets.all(2.0),
                        child: const Icon(Icons.add, color: Colors.black),
                      ),
                      label: const Text(
                        'Agregar Empleado',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
