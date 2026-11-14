import 'package:flutter/material.dart';
import 'package:tugas6/detailPage.dart';

class Homepage extends StatelessWidget {

  final List<Map<String ,String>> travelData;

  const Homepage({super.key, required this.travelData}); 
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'KATALOG WISATA MADEV',
            style: TextStyle(
              fontFamily: 'sans-serif-condensed', 
              fontSize: 22,
              fontWeight: FontWeight.w800, 
              letterSpacing: 1.5, 
              shadows: [
                Shadow(
                  offset: Offset(1.5, 1.5),
                  blurRadius: 3.0,
                  color: Colors.black38, 
                ),
              ],
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Color.fromARGB(255, 7, 44, 255), 
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                icon: Icon(Icons.view_agenda_sharp),
                text: 'List View',
              ),
              Tab(
                icon: Icon(Icons.grid_view_sharp),
                text: 'Grid View',
              )
            ],
          ),
        ),




        body: TabBarView(
          children: [ 
            buildListView(),
            buildGridView(),
          ]
        ),
      )
    );
    
  }

  Widget buildListView(){
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: travelData.length, 
      itemBuilder:(context, index) {
        final item = travelData[index];                                       
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),

          child: ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: ClipRect(
              child: Image.network(
                item['gambar']!,
                width: 80,
                fit: BoxFit.cover, 
                
              ),
            ),

            title: Text(
              item['nama']!
              
            ),
            subtitle: Text(
              item['lokasi']!
            ),

            trailing: Icon(Icons.chevron_right),

            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => detailpage(    
                    nama: item['nama']!, 
                    gambar: item['gambar']!, 
                    lokasi: item['lokasi']!,
                  ),
                  
                ),
              );
            },
          ),



        );
      },
    );
  }

  Widget buildGridView(){
    return GridView.builder(
      padding: EdgeInsets.all(16),
      itemCount: travelData.length,

      
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        mainAxisSpacing: 16,
        crossAxisSpacing: 16, 
        childAspectRatio: 1, 
      ), 

      itemBuilder: (context, index) {
        final item = travelData[index];

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),

          ),

          clipBehavior: Clip.antiAlias,                                 

          child :InkWell(                                      
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => detailpage(
                    nama: item['nama']!, 
                    gambar: item['gambar']!, 
                    lokasi: item['lokasi']!
                  ),
                )  
              );
            },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                item['gambar']!,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black87,
                      Colors.transparent
                    ]
                  )
                ),
              ),

              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['nama']!,
                    style: TextStyle(color: Colors.white),
                    ),
                    Text(item['lokasi']!,
                    style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              ),




            ],
          ),

          ),
        );
      },
    );
  }
}