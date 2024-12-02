import 'package:flutter/material.dart';
import 'package:logger/logger.dart'; // Importar el paquete de logger
import '../models/producto.dart';
import 'puntoventa.dart';
import '../database/db_helper.dart';
import './detallespan.dart';
import 'dart:io';

class BusquedaPage extends StatefulWidget {
  const BusquedaPage({super.key});

  @override
  _BusquedaPageState createState() => _BusquedaPageState();
}

class _BusquedaPageState extends State<BusquedaPage> {
  final dbHelper = DatabaseHelper();
  String searchQuery = ""; // Texto de búsqueda
  List<Producto> productos = []; // Lista de productos encontrados
  int? selectedIndex; // Índice del producto seleccionado

  // Instancia del logger
  final Logger logger = Logger();

  // Método para buscar productos
  Future<void> buscarProductos(String query) async {
    final resultados = await dbHelper.buscarProductos(query);

    setState(() {
      productos = resultados;
    });

    // Log para verificar los resultados
    logger.i(
        "Se encontraron ${resultados.length} productos para la búsqueda '$query'");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 207, 159),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 114, 43, 8)),
          iconSize: 40,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PuntoDeVentaPage(
                  rol: '',
                ),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              "Buscar Pan",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Aleo',
                color: Color.fromARGB(255, 115, 41, 7),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Buscar nombre del pan o precio",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search,
                      color: Color.fromARGB(255, 81, 49, 37)),
                  onPressed: () {
                    buscarProductos(searchQuery);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 45),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Resultados encontrados:",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Aleo',
                  color: Colors.brown,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: productos.isEmpty
                ? const Center(
                    child: Text(
                      'Presiona la lupa para buscar',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Aleo",
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 152, 48, 0),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: productos.length,
                    itemBuilder: (context, index) {
                      final producto = productos[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex =
                                index; // Cambia el índice seleccionado
                          });
                          // Al seleccionar un producto, navega a la página de detalles, pasando el producto
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetallesDelPanPage(
                                  producto: productos[index]),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          color: selectedIndex == index
                              ? const Color.fromARGB(255, 255, 235, 203)
                              : null, // Color amarillo si está seleccionado
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(producto.imagen),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              producto.nombre,
                              style: const TextStyle(
                                fontFamily: 'Aleo',
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 88, 35, 10),
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              '${producto.sabor}   \$${producto.precio}',
                              style: const TextStyle(
                                fontFamily: 'Aleo',
                                fontSize: 16,
                              ),
                            ),
                            isThreeLine: true,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
