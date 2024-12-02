import 'package:flutter/material.dart';
import './admnprinc.dart';
import './login.dart';
import './ventas_dia.dart';
import './busqueda.dart';
import './inventario.dart';

class PuntoDeVentaPage extends StatelessWidget {
  final String rol; // Agregamos el rol del usuario

  const PuntoDeVentaPage({super.key, required this.rol});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Contenido principal
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // AppBar con color café
              Container(
                height: 80,
                color: const Color.fromARGB(255, 135, 71, 15),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        iconSize: 40,
                        onPressed: () {
                          if (rol == 'empleado') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AdminPage(
                                  rol: '',
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Center(
                child: Text(
                  'El Rincón del Pan',
                  style: TextStyle(
                    fontSize: 45,
                    fontFamily: 'Italianno',
                    color: Color.fromRGBO(96, 60, 30, 1),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Nombre del pan a vender',
                    prefixIcon: const Icon(
                      Icons.bakery_dining,
                      color: Color.fromRGBO(144, 73, 10, 1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BusquedaPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      icon: const Icon(Icons.search, color: Colors.black),
                      label: const Text(
                        'Buscar Pan',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),

                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Ventas(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      icon: const Icon(Icons.receipt_long, color: Colors.black),
                      label: const Text(
                        'Ventas',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                    // Botón Inventario
                    ElevatedButton.icon(
                      onPressed: () {
                        if (rol == 'empleado') {
                          // Si es empleado, muestra un mensaje de error
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'No tienes permisos suficientes para administrar el inventario.',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255)),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 150, 90),
                              duration: Duration(
                                  seconds:
                                      3), // Tiempo que el mensaje estará visible
                            ),
                          );
                        } else {
                          // Si no es empleado, redirige a la página de administrador
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const InventarioPage(
                                rol: '',
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 10), // Botones más pequeños
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: Colors.black, // Borde negro
                            width: 1,
                          ),
                        ),
                      ),
                      icon: const Icon(
                        Icons.inventory, // Icono para inventario
                        color: Colors.black,
                      ),
                      label: const Text(
                        'Inventario',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12), // Texto más pequeño
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Tabla de productos
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 103, 52, 16)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
                          4: FlexColumnWidth(1),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                                color:
                                    const Color.fromARGB(255, 242, 216, 194)),
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Producto',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: 'Aleo'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '\$',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Pzas',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Aleo'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Total',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Aleo'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Stock',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Aleo'),
                                ),
                              ),
                            ],
                          ),
                          // Ejemplo de fila
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Pan Integral'),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('\$10'),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('3'),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                color: const Color.fromARGB(255, 218, 255, 220),
                                child: const Text('\$30'),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('50'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Botón Vender Panes
              Padding(
                padding: const EdgeInsets.only(right: 16.0, bottom: 20.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      // Lógica para vender panes
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 217, 121),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Text(
                        'Vender Panes\n\$00.00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Aleo',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
