import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rincondelpan/models/producto.dart';
import './busqueda.dart';

class DetallesDelPanPage extends StatelessWidget {
  final Producto producto; // Añadir esta propiedad

  const DetallesDelPanPage(
      {super.key,
      required this.producto}); // Asegúrate de pasar el producto al constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 234, 176),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 78, 30, 5)),
          iconSize: 40,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BusquedaPage(),
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Texto "Detalles del pan"
          const Text(
            'Detalles del pan',
            style: TextStyle(
              fontSize: 28,
              fontFamily: 'Aleo',
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 10),
          // Imagen centrada
          const Center(
            child: Image(
              image:
                  AssetImage("assets/img/logo.png"), // Reemplaza con tu imagen
              height: 150,
              width: 150,
            ),
          ),
          const SizedBox(height: 20),
          // Título Nombre del Pan
          Center(
            child: Text(
              producto.nombre, // Muestra el nombre del producto aquí
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                  fontFamily: "Aleo"),
            ),
          ),
          const SizedBox(height: 30),
          // Formulario con datos y la imagen alineada a la izquierda
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[100], // Fondo claro para el formulario
              ),
              child: Row(
                children: [
                  // Imagen alineada a la izquierda
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 110,
                        height: 110,
                        child: producto.imagen.isNotEmpty
                            ? Image.file(
                                File(producto.imagen),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons
                                .image), // Mostrar la imagen o un placeholder
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Columna con los datos
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Precio: \$${producto.precio}",
                          style:
                              const TextStyle(fontSize: 18, fontFamily: 'Aleo'),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Sabor: ${producto.sabor}",
                          style:
                              const TextStyle(fontSize: 18, fontFamily: 'Aleo'),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Stock: ${producto.stock}",
                          style:
                              const TextStyle(fontSize: 18, fontFamily: 'Aleo'),
                        ),
                      ],
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
