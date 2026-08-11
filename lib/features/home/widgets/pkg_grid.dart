import 'package:flutter/material.dart';
import '../../../shared/models/portfolio_models.dart';
import 'pkg_card.dart';

class PkgGrid extends StatelessWidget {
  const PkgGrid({required this.packages, super.key});
  final List<OpenSourcePackage> packages;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width < 768 ? 1 : (width < 1024 ? 2 : 3);

    // Featured packages get the full-width spotlight treatment; the rest
    // sit in a uniform grid, each leading with a different real fact so
    // same-size cards don't all read identically.
    final featured = packages.where((p) => p.isFeatured).toList();
    final rest = packages.where((p) => !p.isFeatured).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final p in featured) ...[
          PkgSpotlightCard(pkg: p),
          const SizedBox(height: 10),
        ],
        ...List.generate(
          (rest.length / columns).ceil(),
          (row) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(columns, (col) {
                final i = row * columns + col;
                if (i >= rest.length) return const Spacer();
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: col == 0 ? 0 : 8),
                    child: PkgCard(pkg: rest[i], leadFactMode: i),
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
