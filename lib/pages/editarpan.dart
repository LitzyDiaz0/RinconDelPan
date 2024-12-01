import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rincondelpan/models/producto.dart';
import 'inventario.dart';
import '../database/db_helper.dart';
import 'package:logger/logger.dart';

class EditarPanPage extends StatefulWidget {
  final Producto producto;

  const EditarPanPage({super.key, required this.producto});

  @override
  _EditarPanPageState createState() => _EditarPanPageState();
}

class _EditarPanPageState extends State<EditarPanPage> {
  late Producto _producto;
  final _nombreController = TextEditingController();
  final _saborController = TextEditingController();
  final _precioController = TextEditingController();
  final _stockController = TextEditingController();
  File? _imageFile;

  final Logger _logger = Logger(); // Instancia del logger

  @override
  void initState() {
    super.initState();
    _producto = widget.producto;
    _nombreController.text = _producto.nombre;
    _saborController.text = _producto.sabor;
    _precioController.text = _producto.precio.toString();
    _stockController.text = _producto.stock.toString();
    _imageFile = File(_producto.imagen); // Aquí debe ir la imagen correcta
  }

  // Función para seleccionar una nueva imagen
  Future<void> _selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _producto.imagen = _imageFile!.path;
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Función para guardar los cambios en el producto
  Future<void> _guardarProducto() async {
    // Validar que los campos no estén vacíos
    if (_nombreController.text.isEmpty ||
        _saborController.text.isEmpty ||
        _precioController.text.isEmpty ||
        _stockController.text.isEmpty ||
        _imageFile == null) {
      // Mostrar un mensaje de error si hay campos vacíos
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Todos los campos son obligatorios"),
        backgroundColor: Colors.red,
      ));
      return;
    }

    // Log: Ver los valores antes de la actualización
    _logger.i("Producto actualizado: ${_producto.toMap()}");

    // Crear el objeto Producto con los valores modificados
    _producto.nombre = _nombreController.text;
    _producto.sabor = _saborController.text;
    _producto.precio = double.parse(_precioController.text);
    _producto.stock = int.parse(_stockController.text);
    _producto.imagen = _imageFile!.path; // Actualizar la ruta de la imagen

    // Log: Ver el objeto Producto antes de la actualización
    _logger.i("Producto actualizado: ${_producto.toMap()}");

    // Llamar al método para actualizar el producto en la base de datos
    final dbHelper = DatabaseHelper();
    await dbHelper.actualizarProducto(_producto);

    // Mostrar un mensaje de éxito
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Producto actualizado exitosamente"),
      backgroundColor: Colors.green,
    ));

    // Volver a la página anterior
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) =>
            const InventarioPage(), // Asegúrate de que LoginPage esté importado
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "Editar Pan",
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Aleo',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Volver a la página anterior
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Contenedor para imagen seleccionable
            Center(
              child: GestureDetector(
                onTap:
                    _selectImage, // Llamar a la función para seleccionar imagen
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _imageFile != null
                      ? Image.file(
                          _imageFile!,
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Text(
                            "Imagen del pan",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Campos de entrada con padding horizontal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Nombre"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Ingrese el nombre del pan",
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Sabor"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _saborController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Ingrese el sabor del pan",
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Precio"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _precioController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Ingrese el precio del pan",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  const Text("Stock"),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _stockController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Ingrese el stock del pan",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Botón "Guardar"
            Center(
              child: ElevatedButton(
                onPressed: _guardarProducto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  side: const BorderSide(color: Colors.black, width: 2),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                child: const Text(
                  "Guardar",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
