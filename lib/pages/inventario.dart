import 'package:flutter/material.dart';
import './editarpan.dart';
import '../database/db_helper.dart';
import './admnprinc.dart';
import './agregarpan.dart';
import '../models/producto.dart';

class InventarioPage extends StatefulWidget {
  const InventarioPage({super.key});

  @override
  State<InventarioPage> createState() => _InventarioPageState();
}

class _InventarioPageState extends State<InventarioPage> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> productos = [];

  @override
  void initState() {
    super.initState();
    _cargarProductos();
  }

  Future<void> _cargarProductos() async {
    final data = await dbHelper.obtenerProductos();
    setState(() {
      productos = data.map((producto) => producto.toMap()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 120,
            color: const Color.fromARGB(255, 255, 172, 147),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    iconSize: 40,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminPage(rol: ''),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
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
          const Text(
            'Inventario',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'Aleo',
              color: Color.fromRGBO(96, 60, 30, 1),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AgregarPanPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(color: Colors.black, width: 1),
                ),
              ),
              icon: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                padding: const EdgeInsets.all(2.0),
                child: const Icon(Icons.add, color: Colors.black),
              ),
              label: const Text(
                'Agregar Producto',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DataTable(
                      columnSpacing: 15,
                      columns: const [
                        DataColumn(label: Text('Nombre')),
                        DataColumn(label: Text('Sabor')),
                        DataColumn(label: Text('Precio')),
                        DataColumn(label: Text('Stock')),
                        DataColumn(label: Text('Acciones')),
                      ],
                      rows: productos
                          .map(
                            (producto) => DataRow(
                              cells: [
                                DataCell(Text(producto['nombre'])),
                                DataCell(Text(producto['sabor'])),
                                DataCell(Text(producto['precio'].toString())),
                                DataCell(Text(producto['stock'].toString())),
                                DataCell(
                                  Row(
                                    children: [
                                      // Botón de Editar con diseño personalizado
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditarPanPage(
                                                  producto: Producto(
                                                    id: producto['id_producto'],
                                                    nombre: producto['nombre'],
                                                    sabor: producto['sabor'],
                                                    precio: producto['precio'],
                                                    stock: producto['stock'],
                                                    imagen: '',
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      // Botón de Eliminar con diseño personalizado
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.pink,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            // Implementa la lógica para eliminar el producto aquí
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
