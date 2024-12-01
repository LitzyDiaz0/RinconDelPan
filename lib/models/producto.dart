class Producto {
  int? idProducto;
  String nombre;
  String sabor;
  double precio;
  int stock;
  String imagen;

  Producto({
    this.idProducto,
    required this.nombre,
    required this.sabor,
    required this.precio,
    required this.stock,
    required this.imagen, required id,
  });

  // Convertir el Producto a un Map para almacenarlo en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id_producto': idProducto,
      'nombre': nombre,
      'sabor': sabor,
      'precio': precio,
      'stock': stock,
      'imagen': imagen,
    };
  }

  // Crear un Producto desde un Map
  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      idProducto: map['id_producto'],
      nombre: map['nombre'],
      sabor: map['sabor'],
      precio: map['precio'],
      stock: map['stock'],
      imagen: map['imagen'], id: null,
    );
  }
}
