import 'package:flutter/material.dart';

class CustomButtonNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const CustomButtonNav({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 82,
            child: CustomPaint(
              painter: BottomNavPainter(),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 12),
                child: Row(
                  children: [
                    // HOME
                    Expanded(
                      child: _NavItem(
                        icon: Icons.home_rounded,
                        label: 'الرئيسية',
                        selected: currentIndex == 0,
                        onTap: () => onItemSelected(0),
                      ),
                    ),

                    // PROFILE
                    Expanded(
                      child: _NavItem(
                        icon: Icons.person_outline_rounded,
                        label: 'الملف',
                        selected: currentIndex == 1,
                        onTap: () => onItemSelected(1),
                      ),
                    ),

                    // SPACE FOR CENTER BUTTON
                    const SizedBox(width: 82),

                    // CALENDAR
                    Expanded(
                      child: _NavItem(
                        icon: Icons.calendar_month_outlined,
                        label: 'الحجوزات',
                        selected: currentIndex == 2,
                        onTap: () => onItemSelected(2),
                      ),
                    ),

                    // ACADEMY
                    Expanded(
                      child: _NavItem(
                        icon: Icons.storefront_outlined,
                        label: 'الأكاديميات',
                        selected: currentIndex == 3,
                        onTap: () => onItemSelected(3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // =========================
          // CENTER FLOATING BUTTON
          // =========================
          Positioned(
            top: -20,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFDFFF00),
                    border: Border.all(
                      color: const Color(0xFF202020),
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.center_focus_weak_rounded,
                    size: 36,
                    color: Color(0xFF222222),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// NAVIGATION ITEM
// ============================================================

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = const Color(0xFFDFFF00);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: selected ? activeColor : Colors.white24),

          const SizedBox(height: 4),

          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              color: selected ? activeColor : Colors.white24,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// THE ACTUAL CURVED NAVIGATION BAR
// ============================================================

class BottomNavPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double center = w / 2;

    final Paint fillPaint = Paint()
      ..color = const Color(0xFF1D1D1D)
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = const Color(0xFF737A24)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final Path path = Path();


    path.moveTo(25, -17);

    path.cubicTo(
      10, //tip of the higher edge.
      -16, //curve at the edge.
      2,
      5,
      2,
      18,
    );

    // Left side
    path.lineTo(5, h - 20);

    // Bottom-left
    path.cubicTo(
      2,
      h - 8,
      11,
      h,
      24,
      h,
    );

    // Bottom
    path.lineTo(w - 24, h);

    // Bottom-right
    path.cubicTo(
      w - 11,
      h,
      w - 2,
      h - 8,
      w - 2,
      h - 20,
    );

    // Right side
    path.lineTo(w - 2, 18);

    // Top-right
    path.cubicTo(
      w - 2,
      5,
      w - 10,
      -5,
      w - 25,
      -5,
    );

    // ==================================================
    // RIGHT SIDE OF FAB NOTCH
    // ==================================================

    path.lineTo(center + 105, -5);

    // Start descending toward FAB
    path.cubicTo(
      center + 91,
      -5,
      center + 84,
      1,
      center + 80,
      10,
    );

    path.cubicTo(
      center + 76,
      20,
      center + 71,
      27,
      center + 61,
      32,
    );

    path.cubicTo(
      center + 52,
      37,
      center + 40,
      39,
      center + 29,
      39,
    );

    // ==================================================
    // BOTTOM OF NOTCH
    // ==================================================

    path.cubicTo(
      center + 19,
      39,
      center + 10,
      39,
      center,
      39,
    );

    // ==================================================
    // LEFT SIDE OF FAB NOTCH
    // ==================================================

    path.cubicTo(
      center - 10,
      39,
      center - 19,
      39,
      center - 29,
      39,
    );

    path.cubicTo(
      center - 40,
      39,
      center - 52,
      37,
      center - 61,
      32,
    );

    path.cubicTo(
      center - 71,
      27,
      center - 76,
      20,
      center - 80,
      10,
    );

    path.cubicTo(
      center - 84,
      1,
      center - 91,
      -5,
      center - 105,
      -5,
    );

    // Close
    path.close();

    // ==================================================
    // DRAW
    // ==================================================

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}