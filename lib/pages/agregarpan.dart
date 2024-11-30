import 'package:flutter/material.dart';
import './inventario.dart';

class AgregarPanPage extends StatelessWidget {
  const AgregarPanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco para toda la página
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 172, 147), // Barra rosa
        elevation: 4, // Sombra en la AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          iconSize: 40, // Icono blanco
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const InventarioPage(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Agregar Pan',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Aleo',
                color: Color.fromRGBO(96, 60, 30, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipOval(
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset(
                    'assets/img/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(
                      26.0), // Padding interno del contenedor
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 255, 255, 255), // Fondo blanco
                    borderRadius: BorderRadius.circular(20), // Borde redondeado
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2), // Sombra del contenedor
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField('Nombre del pan:'),
                      const SizedBox(height: 16),
                      _buildTextField('Sabor:'),
                      const SizedBox(height: 16),
                      _buildTextField('Precio:',
                          keyboardType: TextInputType.number),
                      const SizedBox(height: 16),
                      _buildTextField('Stock:',
                          keyboardType: TextInputType.number),
                      const SizedBox(height: 32),
                      Center(
                        // Centrado del botón
                        child: ElevatedButton(
                          onPressed: () {
                            // Acción de agregar pan
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black, // Color del texto
                            backgroundColor: const Color.fromARGB(
                                255, 255, 255, 255), // Fondo del botón
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 50), // Relleno
                            side: const BorderSide(
                              color: Colors.black, // Color del borde
                              width: 2, // Grosor del borde
                            ),
                          ),
                          child: const Text(
                            'Agregar Pan',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Amethysta'), // Estilo del texto
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 10.0), // Separación entre los campos
      padding: const EdgeInsets.symmetric(
          horizontal: 12.0), // Relleno horizontal para los campos
      decoration: BoxDecoration(
        color: Colors.white, // Fondo blanco del contenedor del campo
        borderRadius: BorderRadius.circular(8), // Bordes redondeados
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2), // Sombra del contenedor
          ),
        ],
      ),
      child: TextField(
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 10), // Tamaño del texto ajustado
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none, // Eliminar borde interno
          contentPadding: const EdgeInsets.symmetric(
              vertical: 8), // Ajuste de padding para que no estén tan grandes
        ),
      ),
    );
  }
}
