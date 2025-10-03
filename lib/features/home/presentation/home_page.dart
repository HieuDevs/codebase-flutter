import 'dart:ui';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lua/core/extensions/context.dart';

import 'package:lua/shared/resources/assets.dart';
import 'package:lua/shared/resources/gap.dart';
import 'package:lua/core/routes/props.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:lua/features/home/presentation/components/chapter_widget.dart';
import 'package:lua/shared/resources/theme.dart';
import 'package:lua/shared/resources/values.dart';
import 'package:lua/shared/widgets/press_widget.dart';

class HomePage extends HookConsumerWidget {
  final RouteProps props;
  const HomePage({super.key, required this.props});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paddingTop = useMemoized(() => MediaQuery.paddingOf(context).top, [context]);
    return Scaffold(
      backgroundColor: AppTheme.backgroundSecondary,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: paddingTop > 0
            ? const Size.fromHeight(AppValues.s140 + AppGap.s12)
            : const Size.fromHeight(AppValues.s140),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: AppValues.s15, sigmaY: AppValues.s15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: AppValues.s1,
                  ),
                ),
              ),
              padding: EdgeInsets.only(
                top: paddingTop + AppGap.s12,
                left: AppGap.s16,
                right: AppGap.s16,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('Home', style: context.getTextTheme.displayMedium)),
                      const _AppBarIconButton(
                        icon: Icons.local_fire_department_rounded,
                        value: '3',
                        color: Colors.orange,
                      ),
                      const SizedBox(width: AppGap.s12),
                      const _AppBarIconButton(
                        icon: Icons.track_changes_rounded,
                        value: '5',
                        color: Colors.blue,
                      ),
                      const SizedBox(width: AppGap.s12),
                      const _AppBarIconButton(
                        icon: Icons.emoji_events_rounded,
                        value: '12',
                        color: Colors.amber,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppGap.s16),
                  PressWidget(
                    onPressed: () {
                      // TODO: Implement Basic Conversation
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.getColor.onPrimaryContainer,
                        borderRadius: BorderRadius.circular(AppValues.s27),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppGap.s18,
                        vertical: AppGap.s20,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              spacing: AppGap.s12,
                              children: [
                                SvgPicture.asset(
                                  AppAssets.svgBasicConversation,
                                  width: AppValues.s16,
                                  height: AppValues.s16,
                                ),
                                Expanded(
                                  child: Text(
                                    'Basic Conversation',
                                    style: context.getTextTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF333333),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down_rounded, size: AppValues.s24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: AppGap.s16,
          right: AppGap.s16,
          top: AppGap.s24 + AppGap.s100 * 1.4 + paddingTop,
          bottom: AppGap.s24,
        ),
        child: const Column(
          spacing: AppGap.s48,
          children: [
            ChapterWidget(title: 'Chapter 1', description: 'Greetings and Introductions'),
            ChapterWidget(title: 'Chapter 2', description: 'Daily Life Basics'),
            ChapterWidget(title: 'Chapter 3', description: 'Food and Drinks'),
          ],
        ),
      ),
    );
  }
}

class _AppBarIconButton extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const _AppBarIconButton({required this.icon, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppGap.s8, vertical: AppGap.s6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppValues.s8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        spacing: AppGap.s4,
        children: [
          Icon(icon, size: AppValues.s18, color: color),
          Text(
            value,
            style: TextStyle(fontSize: AppValues.s14, fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }
}
