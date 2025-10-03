import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lua/core/extensions/context.dart';
import 'package:lua/core/l10n/app_localizations/app_localizations.dart';
import 'package:lua/shared/resources/assets.dart';
import 'package:lua/shared/resources/gap.dart';
import 'package:lua/shared/resources/theme.dart';
import 'package:lua/shared/resources/values.dart';
import 'package:lua/shared/widgets/press_widget.dart';

class ChapterWidget extends HookConsumerWidget {
  final String title;
  final String description;
  const ChapterWidget({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          title,
          style: context.getTextTheme.titleLarge?.copyWith(
            fontWeight: AppTheme.extraBold,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: AppGap.s4),
        Text(
          description,
          style: context.getTextTheme.bodyMedium?.copyWith(color: context.getColor.tertiary),
        ),
        const SizedBox(height: AppGap.s24),
        Column(
          spacing: AppGap.s16,
          children: [
            LessonItem(
              index: 0,
              title: 'Saying Hello',
              type: 'Conversation',
              description: 'Learn the most common ways to\ngreet people in English',
              isCompleted: true,
              isLocked: false,
              isFocus: true,
              onTap: () => _showLessonBottomSheet(
                context,
                0,
                'Saying Hello',
                'Conversation',
                'Learn the most common ways to\ngreet people in English',
                true,
              ),
            ),
            const LessonItem(
              index: 1,
              title: 'How Are You',
              type: 'Conversation',
              description: 'Practice asking and answering how someone is doing',
              isCompleted: true,
              isLocked: false,
            ),
            const LessonItem(
              index: 2,
              title: 'Where Are You From ?',
              type: 'Conversation',
              description: 'Learn to ask and answer questions about origin and nationality',
              isCompleted: false,
              isLocked: false,
            ),

            const LessonItem(
              index: 3,
              title: 'Subject Pronouns',
              type: 'Conversation',
              description: 'Master the use of I, you, he, she, it, we, and they',
              isCompleted: false,
              isLocked: true,
            ),
            const LessonItem(
              index: 4,
              title: 'How Are You ?',
              type: 'Conversation',
              description: 'Advanced practice with various greeting expressions',
              isCompleted: false,
              isLocked: true,
            ),
          ],
        ),
        const SizedBox(height: AppGap.s48),
        Container(height: AppValues.s1, width: double.infinity, color: const Color(0xFFE6E6E6)),
      ],
    );
  }

  void _showLessonBottomSheet(
    BuildContext context,
    int index,
    String title,
    String type,
    String description,
    bool isCompleted,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LessonBottomSheet(
        index: index,
        title: title,
        type: type,
        description: description,
        isCompleted: isCompleted,
      ),
    );
  }
}

class LessonItem extends HookWidget {
  final int index;
  final String title;
  final String type;
  final String description;
  final bool isCompleted;
  final bool isLocked;
  final bool isFocus;
  final VoidCallback? onTap;

  const LessonItem({
    super.key,
    required this.index,
    required this.title,
    required this.type,
    required this.description,
    required this.isCompleted,
    required this.isLocked,
    this.isFocus = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final sizeImage = AppValues.s74;
    return Opacity(
      opacity: isLocked ? 0.5 : 1.0,
      child: PressWidget(
        onPressed: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppGap.s12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppValues.s24),
            color: isFocus ? const Color(0xFFD6E6FF).withValues(alpha: 0.5) : Colors.transparent,
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: AppGap.s6, bottom: AppGap.s6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppValues.s24),
                      color: const Color(0xFFCEEAFF),
                    ),
                    child: index == 0
                        ? Image.asset(AppAssets.imageLogo, width: sizeImage, height: sizeImage)
                        : index == 1
                        ? Image.asset(AppAssets.imageTest1, width: sizeImage, height: sizeImage)
                        : index == 2
                        ? Image.asset(AppAssets.imageTest2, width: sizeImage, height: sizeImage)
                        : index == 3
                        ? Image.asset(AppAssets.imageTest3, width: sizeImage, height: sizeImage)
                        : Image.asset(AppAssets.imageTest4, width: sizeImage, height: sizeImage),
                  ),
                  if (isCompleted)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        AppAssets.svgCompleted,
                        width: AppValues.s30,
                        height: AppValues.s30,
                      ),
                    ),
                ],
              ),
              const SizedBox(width: AppGap.s4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppGap.s2,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppGap.s10,
                            vertical: AppGap.s6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppValues.s24),
                            color: AppTheme.gray100,
                          ),
                          child: Row(
                            spacing: AppGap.s4,
                            children: [
                              SvgPicture.asset(
                                AppAssets.svgMessage,
                                width: AppValues.s16,
                                height: AppValues.s16,
                              ),
                              Text(
                                type,
                                style: context.getTextTheme.labelLarge?.copyWith(
                                  color: context.getColor.tertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      title,
                      style: context.getTextTheme.bodyMedium?.copyWith(
                        fontWeight: AppTheme.semiBold,
                        color: context.getColor.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppGap.s12),
              if (isFocus)
                Container(
                  padding: const EdgeInsets.all(AppGap.s4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent.withValues(alpha: 0.1),
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: AppValues.s32,
                    color: Colors.blueAccent,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class LessonBottomSheet extends StatelessWidget {
  final int index;
  final String title;
  final String type;
  final String description;
  final bool isCompleted;

  const LessonBottomSheet({
    super.key,
    required this.index,
    required this.title,
    required this.type,
    required this.description,
    required this.isCompleted,
  });

  String _getImageAsset() {
    switch (index) {
      case 0:
        return AppAssets.imageLogo;
      case 1:
        return AppAssets.imageTest1;
      case 2:
        return AppAssets.imageTest2;
      case 3:
        return AppAssets.imageTest3;
      case 4:
        return AppAssets.imageTest4;
      default:
        return AppAssets.imageLogo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppGap.s6),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppValues.s32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: AppValues.s4, sigmaY: AppValues.s4),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.48),
                borderRadius: BorderRadius.circular(AppValues.s32),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppGap.s16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        PressWidget(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: const EdgeInsets.all(AppGap.s8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.gray100,
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              size: AppValues.s24,
                              color: context.getColor.tertiary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppGap.s24),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: AppGap.s6, bottom: AppGap.s6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppValues.s32),
                                color: const Color(0xFFCEEAFF),
                              ),
                              child: Image.asset(
                                _getImageAsset(),
                                width: AppValues.s100,
                                height: AppValues.s100,
                              ),
                            ),
                            if (isCompleted)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: SvgPicture.asset(
                                  AppAssets.svgCompleted,
                                  width: AppValues.s40,
                                  height: AppValues.s40,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: AppGap.s12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppGap.s16,
                            vertical: AppGap.s8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppValues.s24),
                            color: AppTheme.gray100,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: AppGap.s8,
                            children: [
                              SvgPicture.asset(
                                AppAssets.svgMessage,
                                width: AppValues.s16,
                                height: AppValues.s16,
                              ),
                              Text(
                                type,
                                style: context.getTextTheme.labelMedium?.copyWith(
                                  color: context.getColor.tertiary,
                                  fontWeight: AppTheme.medium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppGap.s10),
                        Text(
                          title,
                          style: context.getTextTheme.headlineMedium?.copyWith(
                            fontWeight: AppTheme.bold,
                            color: context.getColor.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppGap.s4),
                        Text(
                          description,
                          style: context.getTextTheme.labelLarge?.copyWith(
                            color: context.getColor.tertiary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppGap.s24),
                        PressWidget(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppValues.s16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: AppValues.s10,
                                sigmaY: AppValues.s10,
                              ),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: AppGap.s16),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blueAccent.withValues(alpha: 0.8),
                                      Colors.blue.withValues(alpha: 0.9),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(AppValues.s100),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueAccent.withValues(alpha: 0.3),
                                      blurRadius: AppValues.s12,
                                      offset: const Offset(0, AppValues.s4),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  isCompleted
                                      ? AppLocalizations.of(context).reviewLesson
                                      : AppLocalizations.of(context).startPractice,
                                  style: context.getTextTheme.titleMedium?.copyWith(
                                    fontWeight: AppTheme.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppGap.s24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
