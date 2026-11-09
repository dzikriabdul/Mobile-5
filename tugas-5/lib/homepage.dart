import 'package:flutter/material.dart';
import 'detailpage.dart';
import 'phone.dart';
import 'phone_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedBrand = 'Semua';

  List<String> get _brands =>
      ['Semua', ...{for (final p in phones) p.brand}];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final list = _selectedBrand == 'Semua'
        ? phones
        : phones.where((p) => p.brand == _selectedBrand).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko HP',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 52,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: _brands.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) => ChoiceChip(
                label: Text(_brands[i]),
                selected: _brands[i] == _selectedBrand,
                onSelected: (_) => setState(() => _selectedBrand = _brands[i]),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.66,
              ),
              itemCount: list.length,
              itemBuilder: (context, i) {
                final p = list[i];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DetailPage(phone: p)),
                  ),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Hero(
                                tag: 'phone-${p.id}',
                                child: Image.asset(
                                  p.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => Container(
                                    color: Colors.grey.shade200,
                                    child: const Icon(Icons.smartphone,
                                        size: 48, color: Colors.grey),
                                  ),
                                ),
                              ),
                              if (p.stock == 0)
                                Container(
                                  color: Colors.black54,
                                  alignment: Alignment.center,
                                  child: const Text('HABIS',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5)),
                                ),
                              if (p.discountPercent > 0)
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text('-${p.discountPercent}%',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.brand,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600)),
                              Text(p.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(rupiah(p.price),
                                  style: TextStyle(
                                      color: cs.primary,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(Icons.star_rounded,
                                      size: 14, color: Colors.amber),
                                  Text(' ${p.rating}',
                                      style: const TextStyle(fontSize: 12)),
                                  const Spacer(),
                                  Text('Stok ${p.stock}',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: p.stock == 0
                                              ? Colors.red
                                              : Colors.grey.shade600)),
                                ],
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