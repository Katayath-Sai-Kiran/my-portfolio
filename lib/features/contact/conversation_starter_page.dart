import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/design/app_colors.dart';
import '../../core/design/app_typography.dart';
import '../../shared/widgets/nav_bar.dart';

class ConversationStarterPage extends StatelessWidget {
  const ConversationStarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = MediaQuery.sizeOf(context).width < 768;
    final hPad = isMobile ? 24.0 : 64.0;

    // Social links from footer
    final socialLinks = <_SocialLink>[
      _SocialLink(
        icon: Icons.code_outlined,
        label: 'GitHub',
        subtitle: 'Katayath-Sai-Kiran',
        url: 'https://github.com/Katayath-Sai-Kiran',
      ),
      _SocialLink(
        icon: Icons.work_outline,
        label: 'LinkedIn',
        subtitle: 'sai-kiran-katayath-6687941a5',
        url: 'https://www.linkedin.com/in/sai-kiran-katayath-6687941a5/',
      ),
      _SocialLink(
        icon: Icons.public_outlined,
        label: 'Pub.dev',
        subtitle: 'ksaikiran.dev/packages',
        url: 'https://pub.dev/publishers/ksaikiran.dev/packages',
      ),
      _SocialLink(
        icon: Icons.email_outlined,
        label: 'Email',
        subtitle: 'ksaikiran0407@gmail.com',
        url: 'mailto:ksaikiran0407@gmail.com',
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero section matching _ContactSection
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(hPad, 56 + 32, hPad, 48),
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: c.borderSubtle)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CONTACT',
                          style: AppTypography.monoSmall.copyWith(
                            color: c.textMuted,
                            fontSize: 10,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Let's build something.",
                          style: isMobile
                              ? AppTypography.headlineLarge
                              : AppTypography.displayMedium,
                        ),
                        const SizedBox(height: 32),
                        // Form
                        _ContactForm(c: c),
                        const SizedBox(height: 48),
                        // Social cards
                        _SocialCardsGrid(
                          links: socialLinks,
                          c: c,
                          isMobile: isMobile,
                        ),
                        const SizedBox(height: 32),
                        // Back link
                        Center(child: _BackLink(c: c)),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(top: 0, left: 0, right: 0, child: PortfolioNavBar()),
        ],
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm({required this.c});
  final PortfolioColors c;

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    // Simulate send
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _submitting = false);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Message sent!')));
    _nameCtrl.clear();
    _emailCtrl.clear();
    _messageCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    final width = MediaQuery.sizeOf(context).width;
    final maxWidth = width < 768 ? width - 48 : 600.0;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send a message',
              style: AppTypography.titleLarge.copyWith(color: c.textPrimary),
            ),
            const SizedBox(height: 16),
            _FormField(
              label: 'Name',
              controller: _nameCtrl,
              validator: (v) => v!.trim().isEmpty ? 'Required' : null,
              c: c,
            ),
            const SizedBox(height: 12),
            _FormField(
              label: 'Email',
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              validator: (v) => v!.trim().isEmpty || !v.contains('@')
                  ? 'Valid email required'
                  : null,
              c: c,
            ),
            const SizedBox(height: 12),
            _FormField(
              label: 'Message',
              controller: _messageCtrl,
              maxLines: 5,
              validator: (v) => v!.trim().isEmpty ? 'Required' : null,
              c: c,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _submitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: c.accent,
                  foregroundColor: c.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: _submitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Send',
                        style: AppTypography.labelLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.label,
    required this.controller,
    required this.c,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
  });
  final String label;
  final TextEditingController controller;
  final PortfolioColors c;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: AppTypography.bodyMedium.copyWith(color: c.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTypography.bodyMedium.copyWith(color: c.textMuted),
        filled: true,
        fillColor: c.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: c.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: c.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: c.accent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: c.textPrimary),
        ),
      ),
    );
  }
}

class _SocialCardsGrid extends StatelessWidget {
  const _SocialCardsGrid({
    required this.links,
    required this.c,
    required this.isMobile,
  });
  final List<_SocialLink> links;
  final PortfolioColors c;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    // final double cardWidth = isMobile ? double.infinity : 260;
    final crossAxisCount = isMobile ? 2 : 4;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 3,
      ),
      itemCount: links.length,
      itemBuilder: (context, index) {
        final link = links[index];
        return _SocialCard(link: link, c: c);
      },
    );
  }
}

class _SocialLink {
  const _SocialLink({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.url,
  });
  final IconData icon;
  final String label;
  final String subtitle;
  final String url;
}

class _SocialCard extends StatelessWidget {
  const _SocialCard({required this.link, required this.c});
  final _SocialLink link;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => launchUrl(
          Uri.parse(link.url),
          mode: LaunchMode.externalApplication,
        ),
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: c.border),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: c.accent.withAlpha(30),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(link.icon, size: 20, color: c.accent),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      link.label,
                      style: AppTypography.titleMedium.copyWith(
                        color: c.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      link.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: AppTypography.bodyMedium.copyWith(
                        color: c.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 14, color: c.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackLink extends StatelessWidget {
  const _BackLink({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/'),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back, size: 16, color: c.accent),
          const SizedBox(width: 8),
          Text(
            'Back to Home',
            style: AppTypography.labelLarge.copyWith(
              color: c.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
