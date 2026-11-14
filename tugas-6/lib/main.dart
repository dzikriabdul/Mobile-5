import 'package:flutter/material.dart';
import 'package:tugas6/homepage.dart';

void main() {
  runApp(const MyApp());
}

final List<Map<String, String>> travelData = [ // buat array pakai list
  {
    'nama' : 'Madrid',
    'gambar' : 'https://cdn.getyourguide.com/image/format=avif%2Cfit=cover%2Cgravity=auto%2Cquality=60/dam/Guzman_Lozano_Madrid_%282_de_2%29%20-%20Header%20Mobile.jpg',
    'lokasi' : 'Spanyol',
  },
  {
    'nama' : 'Como',
    'gambar' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPiBNply_BDd9N_MZ6vzdhuV8Lp9iRcNbHHRmDIT9vaw&s=10',
    'lokasi' : 'Italia',
  },
  {
    'nama' : 'Braga',
    'gambar' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFX2188yHYzVUw4SKoitwynsQLwyvXe1lt57TKSd9EJw&s=10',
    'lokasi' : 'Bandung city, Indonesia',
  },
  {
    'nama' : 'Labuan Bajo',
    'gambar' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGdJm380aOksYJFoYIEwGrN6eIT60B76Ytdj2zEhTikdXHosHYhTjS_z2q&s=10',
    'lokasi' : 'Flores, Indonesia',
  },
  {
    'nama' : 'Bangkok',
    'gambar' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjV5kXjlB4FailXwTzI5T9By5totVdPYi6RzHDzHEQeQ&s=10',
    'lokasi' : 'Thailand',
  },
  {
    'nama' : 'Kuala Lumpur',
    'gambar' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7zT1e-qjNCif4da48fJRQB0ssOInsXHfKN06ww6J5eA&s=10',
    'lokasi' : 'Malaysia',
  }
  
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KATALOG WISATA',
      debugShowCheckedModeBanner: false,
      home: Homepage(travelData: travelData),
      theme: ThemeData( // tema AppBar
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        )
      ),
    );
  }
}