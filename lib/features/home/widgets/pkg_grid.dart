import 'package:flutter/material.dart';
import '../../../data/models/package_model.dart';
import 'pkg_card.dart';

class PkgGrid extends StatelessWidget {
  const PkgGrid({required this.packages, super.key});
  final List<PackageModel> packages;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width < 768 ? 1 : (width < 1024 ? 2 : 3);

    final featured = packages.where((p) => p.isFeatured).toList();
    final standard = packages.where((p) => !p.isFeatured).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...featured.map(
          (p) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: PkgCard(pkg: p),
          ),
        ),
        ...List.generate(
          (standard.length / columns).ceil(),
          (row) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(columns, (col) {
                final i = row * columns + col;
                if (i >= standard.length) return const Spacer();
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: col == 0 ? 0 : 8),
                    child: PkgCard(pkg: standard[i]),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
