import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../../responsive/responsive.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionTitle({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final isSmallPhone = Responsive.isSmallPhone(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 28,
              decoration: BoxDecoration(
                gradient: AppColors.accentGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                title,
                softWrap: true,
                style: GoogleFonts.sora(
                  fontSize: isSmallPhone ? 25 : (Responsive.isMobile(context) ? 28 : 32),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: 0,
                  height: 1.16,
                ),
              ),
            ),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              subtitle!,
              style: TextStyle(
                fontSize: isSmallPhone ? 13 : 15,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
