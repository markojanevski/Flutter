import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clothing Store',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> clothes = [
    {
      'name': 'T-Shirt',
      'image': 'https://cdn.mainlinemenswear.co.uk/w_450,h_450/f_auto,q_auto/mainlinemenswear/shopimages/products/179398/Mainimage.jpg',
      'description': 'Comfortable cotton T-shirt',
      'price': '\$20',
    },
    {
      'name': 'Jeans',
      'image': 'https://th.bing.com/th/id/R.ac2ecbc5fb3d154b827ee8048f6a4872?rik=2%2fA84pb2uMTVmQ&riu=http%3a%2f%2fimages.hugoboss.com%2fis%2fimage%2fboss%2fhbna50327030_430_21&ehk=cpkH2mZgUKQnr1bBJ6sAPShvcXRMOLvNtX1jonzipYI%3d&risl=&pid=ImgRaw&r=0',
      'description': 'Stylish blue jeans',
      'price': '\$40',
    },
    {
      'name': 'Jacket',
      'image': 'https://images.stylight.net/image/upload/e_trim/t_web_product_330x440max_nobg/q_auto:eco,f_auto/tuajahoybwm0aewbny56.webp',
      'description': 'Warm winter jacket',
      'price': '\$60',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Индекс: 201219'), 
      ),
      body: ListView.builder(
        itemCount: clothes.length,
        itemBuilder: (context, index) {
          final item = clothes[index];
          return Card(
            child: ListTile(
              leading: Image.network(item['image']),
              title: Text(item['name']),
              subtitle: Text(item['price']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(item: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  DetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(item['image']),
            SizedBox(height: 16),
            Text(
              item['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(item['description']),
            SizedBox(height: 16),
            Text(
              item['price'],
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
