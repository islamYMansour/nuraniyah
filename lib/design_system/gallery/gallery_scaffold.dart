import 'package:flutter/material.dart';

import '../design_system.dart';

/// Shared furniture for the gallery sections.
///
/// Gallery-only helpers. Nothing here is part of the component library — app
/// code must never import this file.
class GallerySection extends StatelessWidget {
  const GallerySection({
    super.key,
    required this.title,
    required this.children,
    this.description,
  });

  final String title;
  final String? description;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.x5),
      child: AppSection(
        title: title,
        description: description,
        children: children,
      ),
    );
  }
}

/// A labelled row of specimens, wrapping onto as many lines as it needs.
class GalleryRow extends StatelessWidget {
  const GalleryRow({
    super.key,
    required this.label,
    required this.children,
    this.crossAxisAlignment = WrapCrossAlignment.center,
  });

  final String label;
  final List<Widget> children;
  final WrapCrossAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: context.typography.labelSmall
              .copyWith(color: context.colors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        ),
      ],
    );
  }
}
