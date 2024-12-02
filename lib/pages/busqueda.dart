import 'package:flutter/material.dart';
import '../models/producto.dart'; // Importa el archivo donde tienes tu clase Producto y método buscarProductos
import 'puntoventa.dart';
import '../database/db_helper.dart';

class BusquedaPage extends StatefulWidget {
  const BusquedaPage({super.key});

  @override
  _BusquedaPageState createState() => _BusquedaPageState();
}

class _BusquedaPageState extends State<BusquedaPage> {
  final dbHelper = DatabaseHelper();
  String searchQuery = ""; // Texto de búsqueda
  List<Producto> productos = []; // Lista de productos encontrados

  // Método para buscar productos
  Future<void> buscarProductos(String query) async {
    // Reemplaza 'tu_instancia_de_base_de_datos' por la instancia de tu servicio o base de datos
    final resultados = await dbHelper.buscarProductos(query);
    setState(() {
      productos = resultados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco
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
          // Título "Buscar Pan"
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
          // Input de búsqueda
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                searchQuery = value;
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
          // Título de resultados
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Resultados encontrados:",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Aleo',
                    color: Color.fromARGB(255, 115, 41, 7)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Lista de resultados
          Expanded(
            child: productos.isNotEmpty
                ? ListView.builder(
                    itemCount: productos.length,
                    itemBuilder: (context, index) {
                      final producto = productos[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            // Puedes implementar alguna acción al seleccionar un producto
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              // Imagen del producto
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: NetworkImage(producto.imagen),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              // Nombre y precio del producto
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      producto.nombre,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Amethysta'),
                                    ),
                                    Text(
                                      "\$${producto.precio.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      "No se encontraron resultados",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
