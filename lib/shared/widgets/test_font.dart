import 'package:lua/core/providers/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class TestFont extends ConsumerWidget {
  final String fontFamily;

  const TestFont({super.key, required this.fontFamily});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kiểm Tra Font'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kiểm Tra Font Chữ $fontFamily', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(themeProvider.notifier).setThemeMode(ThemeMode.light);
                  },
                  child: const Text('Light'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(themeProvider.notifier).setThemeMode(ThemeMode.dark);
                  },
                  child: const Text('Dark'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(themeProvider.notifier).setThemeMode(ThemeMode.system);
                  },
                  child: const Text('System'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Text('Kiểu Hiển Thị', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text('Hiển Thị Lớn - Cực Đậm', style: Theme.of(context).textTheme.displayLarge),
            Text('Hiển Thị Vừa - Đậm', style: Theme.of(context).textTheme.displayMedium),
            Text('Hiển Thị Nhỏ - Bán Đậm', style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 24),

            Text('Kiểu Tiêu Đề', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text('Tiêu Đề Lớn - Bán Đậm', style: Theme.of(context).textTheme.headlineLarge),
            Text('Tiêu Đề Vừa - Trung Bình', style: Theme.of(context).textTheme.headlineMedium),
            Text('Tiêu Đề Nhỏ - Trung Bình', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),

            Text('Kiểu Tựa Đề', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text('Tựa Đề Lớn - Trung Bình', style: Theme.of(context).textTheme.titleLarge),
            Text('Tựa Đề Vừa - Trung Bình', style: Theme.of(context).textTheme.titleMedium),
            Text('Tựa Đề Nhỏ - Trung Bình', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 24),

            Text('Kiểu Nội Dung', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text('Nội Dung Lớn - Thường', style: Theme.of(context).textTheme.bodyLarge),
            Text('Nội Dung Vừa - Thường', style: Theme.of(context).textTheme.bodyMedium),
            Text('Nội Dung Nhỏ - Thường', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 24),

            Text('Kiểu Nhãn', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text('Nhãn Lớn - Trung Bình', style: Theme.of(context).textTheme.labelLarge),
            Text('Nhãn Vừa - Trung Bình', style: Theme.of(context).textTheme.labelMedium),
            Text('Nhãn Nhỏ - Trung Bình', style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(height: 24),

            Text('Độ Đậm Font Tùy Chỉnh', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(
              'Mỏng (100)',
              style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w100, fontSize: 16),
            ),
            Text(
              'Rất Mỏng (200)',
              style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w200, fontSize: 16),
            ),
            Text(
              'Mỏng (300)',
              style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w300, fontSize: 16),
            ),
            Text(
              'Thường (400)',
              style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400, fontSize: 16),
            ),
            Text(
              'Trung Bình (500)',
              style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontSize: 16),
            ),
            Text(
              'Bán Đậm (600)',
              style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              'Đậm (700)',
              style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w700, fontSize: 16),
            ),
            Text(
              'Rất Đậm (800)',
              style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w800, fontSize: 16),
            ),
            Text(
              'Cực Đậm (900)',
              style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w900, fontSize: 16),
            ),
            const SizedBox(height: 24),

            Text('Kiểu Nghiêng', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(
              'Thường Nghiêng',
              style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic, fontSize: 16),
            ),
            Text(
              'Trung Bình Nghiêng',
              style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic, fontSize: 16),
            ),
            Text(
              'Đậm Nghiêng',
              style: TextStyle(fontFamily: fontFamily, fontWeight: FontWeight.w700, fontStyle: FontStyle.italic, fontSize: 16),
            ),
            const SizedBox(height: 24),

            Text('Chức Năng', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),

            Text('Văn Bản Mẫu', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(
              'Đây là một đoạn văn bản mẫu để kiểm tra font chữ $fontFamily trong tiếng Việt. Font chữ này có thể hiển thị tốt các ký tự có dấu và các ký tự đặc biệt của tiếng Việt. Chúng ta có thể thấy rằng $fontFamily là một font chữ rất đẹp và dễ đọc.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
