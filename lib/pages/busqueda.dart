import 'package:flutter/material.dart';

class BusquedaPage extends StatefulWidget {
  const BusquedaPage({super.key});

  @override
  _BusquedaPageState createState() => _BusquedaPageState();
}

class _BusquedaPageState extends State<BusquedaPage> {
  String searchQuery = "";
  int? selectedIndex; // Índice de la fila seleccionada

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
            Navigator.pop(context); // Volver a la pantalla anterior
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
          // Input de búsqueda con ícono integrado
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
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
                    // Acción al presionar la lupa
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 45),
          // Título de resultados encontrados
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
          // Lista de resultados simulados
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Cambia este valor según tus resultados
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Actualiza el índice seleccionado
                    setState(() {
                      selectedIndex = index;
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
                      color: selectedIndex == index
                          ? const Color.fromARGB(255, 255, 238,
                              192) // Color amarillo si está seleccionado
                          : Colors
                              .white, // Color blanco si no está seleccionado
                    ),
                    child: Row(
                      children: [
                        // Imagen del pan
                        Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey[300], // Placeholder de imagen
                          child: const Icon(Icons.image),
                        ),
                        const SizedBox(width: 20),
                        // Nombre y precio del pan
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Nombre del Pan",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Amethysta'),
                              ),
                              Text(
                                "\$Precio",
                                style: TextStyle(
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
            ),
          ),
        ],
      ),
    );
  }
}
