import 'package:flutter/material.dart';

class AgregarPanPage extends StatelessWidget {
  const AgregarPanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Agregar',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Agregar Pan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: const AssetImage('assets/pan.jpg'), // Cambia la ruta si necesitas cargar otra imagen
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildTextField('Nombre'),
                  const SizedBox(height: 16),
                  _buildTextField('Sabor'),
                  const SizedBox(height: 16),
                  _buildTextField('Precio', keyboardType: TextInputType.number),
                  const SizedBox(height: 16),
                  _buildTextField('Stock', keyboardType: TextInputType.number),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      // Acción de agregar pan
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.amber[200],
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text(
                      'Agregar Pan',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}