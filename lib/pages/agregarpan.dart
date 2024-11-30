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
            // Logo arriba del texto
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
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
            const Text(
              'Agregar Pan',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Aleo',
                color: Color.fromRGBO(96, 60, 30, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Aquí se implementará la lógica para abrir la galería/cámara
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    255, 240, 240, 240), // Fondo gris claro
                foregroundColor: Colors.black, // Color del texto e ícono
                side: const BorderSide(
                  color: Colors.black, // Borde negro
                  width: 1.5,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              icon: const Icon(Icons.image, size: 24), // Ícono de imagen
              label: const Text(
                'Elegir Imagen',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Aleo',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField('Nombre del pan:', fontSize: 14),
                      const SizedBox(height: 16),
                      _buildTextField('Sabor:', fontSize: 10),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              'Precio:',
                              keyboardType: TextInputType.number,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField(
                              'Stock:',
                              keyboardType: TextInputType.number,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Acción de agregar pan
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 50),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: const Text(
                            'Agregar Pan',
                            style: TextStyle(
                                fontSize: 18, fontFamily: 'Amethysta'),
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

  Widget _buildTextField(
    String label, {
    TextInputType keyboardType = TextInputType.text,
    double fontSize = 16,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        keyboardType: keyboardType,
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }
}
