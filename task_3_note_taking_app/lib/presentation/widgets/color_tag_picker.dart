import 'package:flutter/material.dart';

class ColorTagPicker extends StatelessWidget {
  final int selected;
  final Function(int) onSelected;
  final List<int> colors;

  ColorTagPicker({
    required this.selected,
    required this.onSelected,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children:
          colors.map((c) {
            final isSel = c == selected;
            return GestureDetector(
              onTap: () => onSelected(c),
              child: Container(
                width: isSel ? 44 : 36,
                height: isSel ? 44 : 36,
                decoration: BoxDecoration(
                  color: Color(c),
                  shape: BoxShape.circle,
                  border:
                      isSel ? Border.all(width: 3, color: Colors.white) : null,
                ),
              ),
            );
          }).toList(),
    );
  }
}
