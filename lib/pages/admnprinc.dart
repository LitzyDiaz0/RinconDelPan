import 'package:flutter/material.dart';
import './login.dart';
import './puntoventa.dart';
import './adminusers.dart';
import './inventario.dart';
import './ventas_dia.dart';

class AdminPage extends StatelessWidget {
  final String rol; // Aceptar el rol

  const AdminPage({super.key, required this.rol});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo que ocupa toda la pantalla
          Positioned.fill(
            child: Image.asset(
              'assets/img/fondo2.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          // Título principal
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(5),
              color: Colors.white,
              child: const Text(
                'El Rincón del Pan',
                style: TextStyle(
                  fontSize: 48,
                  fontFamily: 'Italianno',
                  color: Color.fromRGBO(144, 73, 10, 1),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Texto "Administrador"
          Positioned(
            top: 220,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(5.0),
              color: const Color.fromARGB(200, 250, 132, 105),
              child: const Text(
                'Administrador',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Amethysta',
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Contenedor de botones
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Botón 1
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 209, 209, 209)
                                .withOpacity(0.9),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          //Lógica para Punto de Venta
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PuntoDeVentaPage(
                                rol: '',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Punto de Venta',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Amethysta',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  // Botón 2
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 209, 209, 209)
                                .withOpacity(0.9),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Lógica para Ver Inventario
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const InventarioPage(), // Asegúrate de que LoginPage esté importado
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Ver Inventario',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Amethysta',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  // Botón 3
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 209, 209, 209)
                                .withOpacity(0.9),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Lógica para Ver Ventas del Día
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Ventas(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Ver Ventas del Día',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Amethysta',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  // Botón 4
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 209, 209, 209)
                                .withOpacity(0.9),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Lógica para Administrar Empleados
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AdministrarUsuariosPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Administrar Empleados',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Amethysta',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  // Botón 5
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 209, 209, 209)
                                .withOpacity(0.9),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          // Lógica para cambiar usuario
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Cambiar de usuario',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Amethysta',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
