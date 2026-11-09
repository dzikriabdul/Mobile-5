import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final String stock;
  final String harga;

  const DetailPage({
    super.key,
    required this.name,
    required this.image,
    required this.description,
    required this.stock,
    required this.harga
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
        ),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            ClipRect(
              child: Image.network(
                image,
                width: 400,
                height: 400,
                fit: BoxFit.cover,

                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    child: Icon(Icons.smartphone),
                  );
                },
              ),
            ),

            Text(
              name,
              style: TextStyle(
                fontWeight: .bold,
                fontSize: 25,
              ),
            ),

            Text(
              description,
            ),

            Text(
              stock,
            ),

            Text(
              harga,
            ),
            
            SizedBox(height: 20,),
            SizedBox(
              child: ElevatedButton.icon(
                onPressed: (){

                },
                icon: Icon(Icons.check),
                label: Text('Beli'),
              ),
            ),



            SizedBox(height: 20,),
            SizedBox(
              child: ElevatedButton.icon(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                icon: Icon(Icons.arrow_back),
                label: Text('kembali'),
              ),
            )


          ],
        ),
      ),
    );
  }
}