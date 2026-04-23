import 'package:flutter/material.dart';

class TypographyDemoScreen extends StatelessWidget {
  const TypographyDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Typography Demo',
          style: t.titleLarge,
        ), // 👈 titleLarge in AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── TITLES SECTION ───────────────────────────────────
            _SectionHeader(label: '── TITLES ──', color: color.primary),
            const SizedBox(height: 12),

            _StyleRow(
              tag: 'titleLarge',
              description: 'Screen title, card header',
              child: Text('My Profile', style: t.titleLarge),
            ),
            _StyleRow(
              tag: 'titleMedium',
              description: 'Section header, dialog title',
              child: Text('Personal Info', style: t.titleMedium),
            ),
            _StyleRow(
              tag: 'titleSmall',
              description: 'Sub-section, list group label',
              child: Text('Contact Details', style: t.titleSmall),
            ),

            const SizedBox(height: 32),

            // ─── BODY SECTION ─────────────────────────────────────
            _SectionHeader(label: '── BODY ──', color: color.primary),
            const SizedBox(height: 12),

            _StyleRow(
              tag: 'bodyLarge',
              description: 'Primary readable text',
              child: Text(
                'Flutter is an open source framework by Google.',
                style: t.bodyLarge,
              ),
            ),
            _StyleRow(
              tag: 'bodyMedium',
              description: 'Secondary text, descriptions',
              child: Text(
                'Build apps for mobile, web and desktop.',
                style: t.bodyMedium,
              ),
            ),
            _StyleRow(
              tag: 'bodySmall',
              description: 'Hint text, helper text, timestamps',
              child: Text('Last updated 2 minutes ago', style: t.bodySmall),
            ),

            const SizedBox(height: 32),

            // ─── LABELS SECTION ───────────────────────────────────
            _SectionHeader(label: '── LABELS ──', color: color.primary),
            const SizedBox(height: 12),

            _StyleRow(
              tag: 'labelLarge',
              description: 'Button text, tab label',
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: color.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Submit',
                  style: t.labelLarge?.copyWith(color: color.onPrimary),
                ),
              ),
            ),
            _StyleRow(
              tag: 'labelMedium',
              description: 'Chip text, badge, tag',
              child: Chip(label: Text('Flutter', style: t.labelMedium)),
            ),
            _StyleRow(
              tag: 'labelSmall',
              description: 'Tiny caption, image caption',
              child: Text('*Required field', style: t.labelSmall),
            ),

            const SizedBox(height: 40),

            // ─── REAL WORLD CARD EXAMPLE ──────────────────────────
            _SectionHeader(
              label: '── REAL CARD EXAMPLE ──',
              color: color.secondary,
            ),
            const SizedBox(height: 12),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Arshad\'s Profile',
                      style: t.titleLarge,
                    ), // card title
                    const SizedBox(height: 4),
                    Text('Flutter Developer', style: t.titleSmall), // sub title
                    const Divider(height: 24),
                    Text(
                      'Passionate about building beautiful mobile apps '
                      'with clean and maintainable code.',
                      style: t.bodyLarge, // main text
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Peshawar, Pakistan',
                      style: t.bodyMedium, // secondary text
                    ),
                    const SizedBox(height: 4),
                    Text('Joined April 2024', style: t.bodySmall), // small info
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Chip(label: Text('Dart', style: t.labelMedium)),
                        const SizedBox(width: 8),
                        Chip(label: Text('Flutter', style: t.labelMedium)),
                        const SizedBox(width: 8),
                        Chip(label: Text('Firebase', style: t.labelMedium)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '*Public profile',
                      style: t.labelSmall,
                    ), // tiny caption
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Helpers ──────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String label;
  final Color color;
  const _SectionHeader({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(
        context,
      ).textTheme.labelMedium?.copyWith(color: color, letterSpacing: 1.2),
    );
  }
}

class _StyleRow extends StatelessWidget {
  final String tag;
  final String description;
  final Widget child;
  const _StyleRow({
    required this.tag,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: tag + description
          SizedBox(
            width: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(tag, style: t.labelSmall),
                ),
                const SizedBox(height: 4),
                Text(description, style: t.bodySmall),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Right: actual styled text
          Expanded(child: child),
        ],
      ),
    );
  }
}
