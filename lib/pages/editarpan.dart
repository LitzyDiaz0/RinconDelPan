import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rincondelpan/models/producto.dart';
import 'inventario.dart';
import '../database/db_helper.dart';

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

// Instancia del logger

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

  Future<void> _selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _guardarProducto() async {
    if (_nombreController.text.isEmpty ||
        _saborController.text.isEmpty ||
        _precioController.text.isEmpty ||
        _stockController.text.isEmpty ||
        _imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Todos los campos son obligatorios"),
        backgroundColor: Colors.red,
      ));
      return;
    }

    _producto.nombre = _nombreController.text;
    _producto.sabor = _saborController.text;
    _producto.precio = double.parse(_precioController.text);
    _producto.stock = int.parse(_stockController.text);
    _producto.imagen = _imageFile!.path;

    final dbHelper = DatabaseHelper();
    await dbHelper.actualizarProducto(_producto);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Producto actualizado exitosamente"),
      backgroundColor: Colors.green,
    ));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => const InventarioPage(
                rol: '',
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(100), // Altura personalizada del AppBar
        child: AppBar(
          backgroundColor:
              const Color.fromARGB(255, 255, 226, 163), // Color amarillo
          title: Row(
            mainAxisAlignment: MainAxisAlignment
                .center, // Centrar el contenido horizontalmente
            children: const [
              Text(
                "Editar Pan",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Aleo',
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 111, 63, 8),
                ),
              ),
              SizedBox(width: 16), // Espaciado entre texto y la imagen
              CircleAvatar(
                backgroundImage: AssetImage('assets/img/logo.png'),
                radius: 30, // Tamaño del logo
              ),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 92, 65, 7)),
            iconSize: 40,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: _selectImage,
                child: CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.grey[300],
                  backgroundImage:
                      _imageFile != null ? FileImage(_imageFile!) : null,
                  child: _imageFile == null
                      ? const Text(
                          "Imagen del pan",
                          style: TextStyle(color: Colors.grey),
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 100, child: Text("Nombre:")),
                    Expanded(
                      child: TextField(
                        controller: _nombreController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Nombre",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const SizedBox(width: 100, child: Text("Sabor:")),
                    Expanded(
                      child: TextField(
                        controller: _saborController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Sabor",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const SizedBox(width: 100, child: Text("Precio:")),
                    Expanded(
                      child: TextField(
                        controller: _precioController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Precio",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const SizedBox(width: 100, child: Text("Stock:")),
                    Expanded(
                      child: TextField(
                        controller: _stockController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Stock",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: _guardarProducto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  side: const BorderSide(color: Colors.black, width: 2),
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 90),
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
          ],
        ),
      ),
    );
  }
}
