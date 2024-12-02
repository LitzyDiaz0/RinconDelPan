import 'package:flutter/material.dart';
import 'package:logger/logger.dart'; // Importar el paquete de logger
import '../models/producto.dart';
import 'puntoventa.dart';
import '../database/db_helper.dart';
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
                  icon: const Icon(Icons.search, color: Colors.brown),
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
                      'No se encontraron productos',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: productos.length,
                    itemBuilder: (context, index) {
                      final producto = productos[index];
                      return Card(
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
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(producto.imagen),
                              width: 70, // Imagen más grande
                              height: 70, // Imagen más grande
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            producto.nombre,
                            style: const TextStyle(
                              fontFamily: 'Aleo', // Tipo de fuente Aleo
                              fontWeight: FontWeight.bold, // Negritas
                              fontSize:
                                  18, // Ajusta el tamaño del texto si es necesario
                            ),
                          ),
                          subtitle: Text(
                            'Precio: \$${producto.precio}',
                            style: const TextStyle(
                              fontFamily: 'Aleo',
                              fontSize: 16,
                            ),
                          ),
                          isThreeLine: true,
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
