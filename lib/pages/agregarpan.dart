import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:logger/logger.dart';
import './inventario.dart';
import '../database/db_helper.dart'; // Asegúrate de importar tu DBHelper
import '../models/producto.dart'; // Asegúrate de importar el modelo Producto

class AgregarPanPage extends StatefulWidget {
  const AgregarPanPage({super.key});

  @override
  State<AgregarPanPage> createState() => _AgregarPanPageState();
}

class _AgregarPanPageState extends State<AgregarPanPage> {
  final _nombreController = TextEditingController();
  final _saborController = TextEditingController();
  final _precioController = TextEditingController();
  final _stockController = TextEditingController();
  File? _selectedImage;

  final dbHelper = DatabaseHelper();

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _agregarProducto() async {
    final String nombre = _nombreController.text;
    final String sabor = _saborController.text;
    final double? precio = double.tryParse(_precioController.text);
    final int? stock = int.tryParse(_stockController.text);

    if (nombre.isEmpty ||
        sabor.isEmpty ||
        precio == null ||
        stock == null ||
        _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    // Crear el producto
    final Producto nuevoProducto = Producto(
      nombre: nombre,
      sabor: sabor,
      precio: precio,
      stock: stock,
      imagen: _selectedImage!.path,
    );

    // Insertar en la base de datos
    await dbHelper.insertarProducto(nuevoProducto);

    var logger = Logger();

    // Usar el logger para imprimir la información
    logger.i(
        'Producto registrado: ${nuevoProducto.nombre}, ${nuevoProducto.sabor}, ${nuevoProducto.precio},  ${nuevoProducto.stock},${nuevoProducto.imagen} ');

    // Mostrar confirmación y regresar al inventario
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Producto agregado exitosamente')),
    );

    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const InventarioPage()),
    );
  }

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
                  child: _selectedImage == null
                      ? Image.asset(
                          'assets/img/logo.png',
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _pickImage,
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
                      _buildTextField(
                        'Nombre del pan:',
                        controller: _nombreController,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        'Sabor:',
                        controller: _saborController,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              'Precio:',
                              controller: _precioController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField(
                              'Stock:',
                              controller: _stockController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: ElevatedButton(
                          onPressed: _agregarProducto,
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
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
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
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }
}
