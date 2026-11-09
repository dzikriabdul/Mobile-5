import 'package:flutter/material.dart';
import 'phone.dart';

class DetailPage extends StatefulWidget {
  final Phone phone;
  const DetailPage({super.key, required this.phone});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _colorIndex = 0;
  int _storageIndex = 0;
  int _qty = 1;
  bool _favorite = false;

  Phone get p => widget.phone;

  Widget _imageFallback() => Container(
        color: Colors.grey.shade200,
        alignment: Alignment.center,
        child: Icon(Icons.smartphone, size: 96, color: Colors.grey.shade500),
      );

  Widget _stockBadge(ColorScheme cs) {
    late final String label;
    late final Color color;
    if (p.stock == 0) {
      label = 'Stok habis';
      color = Colors.red;
    } else if (p.stock <= 5) {
      label = 'Sisa ${p.stock} unit';
      color = Colors.orange;
    } else {
      label = 'Stok tersedia (${p.stock})';
      color = Colors.green;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: TextStyle(
              color: color, fontWeight: FontWeight.w600, fontSize: 12)),
    );
  }

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(top: 22, bottom: 10),
        child: Text(text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      );

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final selectedColor = p.colors[_colorIndex];
    final outOfStock = p.stock == 0;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 360,
            pinned: true,
            actions: [
              IconButton(
                icon: Icon(
                  _favorite ? Icons.favorite : Icons.favorite_border,
                  color: _favorite ? Colors.red : null,
                ),
                onPressed: () => setState(() => _favorite = !_favorite),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'phone-${p.id}',
                    child: Image.network(
                      p.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (c, child, progress) => progress == null
                          ? child
                          : const Center(child: CircularProgressIndicator()),
                      errorBuilder: (c, e, s) => _imageFallback(),
                    ),
                  ),
                  // gradasi tipis agar tombol back tetap terbaca
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                        colors: [Color(0x66000000), Colors.transparent],
                      ),
                    ),
                  ),
                  if (p.discountPercent > 0)
                    Positioned(
                      left: 16,
                      bottom: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('-${p.discountPercent}%',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Chip(
                        label: Text(p.brand),
                        visualDensity: VisualDensity.compact,
                        backgroundColor: cs.primaryContainer,
                      ),
                      const SizedBox(width: 8),
                      _stockBadge(cs),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(p.name,
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text('${p.rating}',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(width: 12),
                      Text('${p.sold} terjual',
                          style: TextStyle(color: Colors.grey.shade600)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(rupiah(p.price),
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: cs.primary)),
                      const SizedBox(width: 10),
                      if (p.oldPrice != null)
                        Text(rupiah(p.oldPrice!),
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey.shade500)),
                    ],
                  ),

                  _sectionTitle('Warna: ${selectedColor.name}'),
                  Row(
                    children: [
                      for (var i = 0; i < p.colors.length; i++)
                        GestureDetector(
                          onTap: () => setState(() => _colorIndex = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: i == _colorIndex
                                    ? cs.primary
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: p.colors[i].color,
                            ),
                          ),
                        ),
                    ],
                  ),

                  _sectionTitle('Penyimpanan'),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (var i = 0; i < p.storages.length; i++)
                        ChoiceChip(
                          label: Text(p.storages[i]),
                          selected: i == _storageIndex,
                          onSelected: (_) =>
                              setState(() => _storageIndex = i),
                        ),
                    ],
                  ),

                  _sectionTitle('Deskripsi'),
                  Text(p.description,
                      style: const TextStyle(height: 1.5, fontSize: 14.5)),

                  _sectionTitle('Spesifikasi'),
                  Card(
                    elevation: 0,
                    color: cs.surfaceContainerHighest.withAlpha(110),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        children: [
                          for (final e in p.specs.entries)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 90,
                                    child: Text(e.key,
                                        style: TextStyle(
                                            color: Colors.grey.shade600)),
                                  ),
                                  Expanded(
                                    child: Text(e.value,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 12),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: const [
              BoxShadow(color: Color(0x22000000), blurRadius: 12),
            ],
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: outOfStock || _qty <= 1
                          ? null
                          : () => setState(() => _qty--),
                    ),
                    Text('$_qty',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: outOfStock || _qty >= p.stock
                          ? null
                          : () => setState(() => _qty++),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: Text(outOfStock
                      ? 'Stok habis'
                      : 'Beli • ${rupiah(p.price * _qty)}'),
                  onPressed: outOfStock
                      ? null
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '$_qty x ${p.brand} ${p.name} '
                                  '(${selectedColor.name}, '
                                  '${p.storages[_storageIndex]}) '
                                  'masuk keranjang'),
                            ),
                          );
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}