import 'package:flutter/material.dart';
import 'package:rincondelpan/pages/busqueda.dart';

class DetallesDelPanPage extends StatelessWidget {
  const DetallesDelPanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 234, 176),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 78, 30, 5)),
          iconSize: 40,
          onPressed: () {
            // Volver a la pantalla anterior
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
          const Center(
            child: Text(
              "Nombre del Pan",
              style: TextStyle(
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
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                        child: const Icon(Icons.image), // Placeholder de imagen
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Columna con los datos
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Precio: \$XX.XX",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Sabor: XX ",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Stock: XX ",
                          style: TextStyle(fontSize: 16),
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
