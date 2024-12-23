import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../database/db_helper.dart';
import '../models/producto.dart';
import './admnprinc.dart';
import './login.dart';
import './ventas_dia.dart';
import './busqueda.dart';
import './inventario.dart';
import '../models/ventas.dart';

class PuntoDeVentaPage extends StatefulWidget {
  final String rol;

  const PuntoDeVentaPage({super.key, required this.rol});

  @override
  _PuntoDeVentaPageState createState() => _PuntoDeVentaPageState();
}

class _PuntoDeVentaPageState extends State<PuntoDeVentaPage> {
  final TextEditingController _searchController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Producto> _productosEncontrados = [];
  final List<Producto> _productosSeleccionados = [];

  void _buscarProductos(String query) async {
    if (query.isEmpty) {
      setState(() => _productosEncontrados = []);
      return;
    }

    final productos = await _dbHelper.buscarProductos(query);
    setState(() {
      _productosEncontrados = productos;
    });
  }

  void _seleccionarProducto(Producto producto) {
    setState(() {
      _productosSeleccionados.add(producto);
      _productosEncontrados = [];
      _searchController.clear();
    });
  }

  double _calcularTotal() {
    return _productosSeleccionados.fold(0, (sum, item) => sum + item.precio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                // AppBar
                Container(
                  height: 100,
                  color: const Color.fromARGB(255, 135, 71, 15),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        iconSize: 40,
                        onPressed: () {
                          if (widget.rol == 'empleado') {
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
                                builder: (context) => const AdminPage(rol: ''),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                // Logo encima del AppBar
                Positioned(
                  top: 10, // Ajusta esta posición según sea necesario
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Image.asset(
                      'assets/img/logo.png', // Ruta de la imagen
                      height: 85, // Ajusta el tamaño según sea necesario
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 50),
            // Título
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
            // Campo de búsqueda
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    onChanged: _buscarProductos,
                    decoration: InputDecoration(
                      labelText: 'Nombre o "\$" del pan a vender',
                      prefixIcon: const Icon(
                        Icons.bakery_dining,
                        color: Color.fromRGBO(144, 73, 10, 1),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  if (_productosEncontrados.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 246, 225),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: const Color.fromARGB(255, 94, 65, 29)),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: _productosEncontrados.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey.shade300,
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          final producto = _productosEncontrados[index];
                          return ListTile(
                            title: Text(
                                '${producto.nombre}  ${producto.sabor}  \$${producto.precio}'),
                            onTap: () => _seleccionarProducto(producto),
                          );
                        },
                      ),
                    ),
                ],
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
                      if (widget.rol == 'empleado') {
                        // Si es empleado, muestra un mensaje de error
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'No tienes permisos suficientes para administrar el inventario.',
                              style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255)),
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
                          vertical: 8, horizontal: 10), // Botones más pequeños
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
            const SizedBox(height: 15),
            // Tabla de productos seleccionados
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromARGB(255, 103, 52, 16)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(2),
                    4: FlexColumnWidth(1),
                  },
                  children: [
                    const TableRow(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 242, 216, 194)),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Producto',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Sabor',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Precio',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Pan',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Text('',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    for (var producto in _productosSeleccionados)
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(producto.nombre),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(producto.sabor),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('\$${producto.precio}'),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(
                                File(producto.imagen),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 217, 140, 32),
                              ),
                              onPressed: () {
                                setState(() {
                                  _productosSeleccionados.remove(producto);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 30.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_productosSeleccionados.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('No hay productos seleccionados')),
                      );
                      return;
                    }

                    // Calcular cantidad de productos
                    final cantidad = _productosSeleccionados.length;
                    final total = _calcularTotal();

                    // Crear una nueva venta
                    final nuevaVenta = Venta(cantidad: cantidad, total: total);

                    // Guardar en la base de datos
                    await _dbHelper.agregarVenta(nuevaVenta);
                    var logger = Logger();

                    // Usar el logger para imprimir la información
                    logger.i(
                        'venta:${nuevaVenta.idVenta}, ${nuevaVenta.cantidad}, ${nuevaVenta.total}');

                    // Limpiar la lista de productos seleccionados
                    setState(() {
                      _productosSeleccionados.clear();
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Venta registrada con éxito')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 217, 121),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.black),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Text(
                      'Vender Panes\n\$${_calcularTotal().toStringAsFixed(2)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
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
      ),
    );
  }
}
