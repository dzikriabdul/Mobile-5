
import 'package:flutter/material.dart';
import 'package:tugas5/detailpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhoneShop',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> phones = [

      {
        'name' : 'Iphone 18 pro max',
        'image' : 'https://images.unsplash.com/photo-1678685888221-cda773a3dcdb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D',
        'description' : 'hp terbaru dari seri iphone',
        'stock' : '15 unit',
        'harga' : 'Rp 39.000.000'
      },
      {
        'name' : 'realme c85',
        'image' : 'https://images.unsplash.com/photo-1784820625053-8cac86d48045?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D',
        'description' : 'terbaik di kelas nya',
        'stock' : '30 unit',
        'harga' : 'Rp 3.500.000'
      },
      {
        'name' : 'Iphone 10',
        'image' : 'https://images.unsplash.com/photo-1555375771-14b2a63968a9?q=80&w=715&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D',
        'description' : 'Second Murah',
        'stock' : '20 unit',
        'harga' : 'Rp 5.000.000'
      },
      {
        'name' : 'Lenovo Legion',
        'image' : 'https://images.unsplash.com/photo-1588620353536-ded12e518f45?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D',
        'description' : 'Laptop Gaming Terbaru',
        'stock' : '5 unit',
        'harga' : 'Rp 15.000.000'
      },
      {
        'name' : 'samsung',
        'image' : 'https://images.unsplash.com/photo-1773414422164-eefdc240da58?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D',
        'description' : 'hp flagship terbaru',
        'stock' : '17 unit',
        'harga' : '7.500.000'
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: Align(
          child: Text('Dzikri Cell'),
        ),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        leading: Icon(Icons.shopping_bag_sharp),
        actions: [
          Icon(Icons.shopping_bag_sharp)
        ],
        
      ),
      body: ListView.builder(
        itemCount: phones.length,
        itemBuilder: (context, index) {
          final phone = phones[index];

          return Card(
            margin: EdgeInsets.symmetric(vertical: 10 , horizontal: 15),
            color: Colors.grey,
            child: ListTile(
              leading: ClipRect(
                child: Image.network(
                  phone['image']!,
                  width: 60,
                  height: 65,
                  fit: BoxFit.cover,

                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      child: Icon(Icons.smartphone),
                    );
                  }
                ),
              ),

              title: Text(
                phone['name']!,
                style: TextStyle(fontWeight: .bold, fontSize: 20),
              ),

              subtitle: Text(
                phone['description']!,
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.chevron_right,fontWeight: .bold,), // agar icons ada di kanan
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      name: phone['name']!,
                      image: phone['image']!,
                      description: phone['description']!,
                      stock: phone['stock']!,
                      harga: phone['harga']!,

                    ),
                  )
                );
              },
            ),
          );
        },
      ),
    );
  }
}