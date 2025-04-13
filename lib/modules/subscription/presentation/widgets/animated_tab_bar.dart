import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:subsciption_manager/config/constants/colors.dart';
import 'package:subsciption_manager/modules/subscription/data/models/subscription_group_model.dart';

class AnimatedTabList extends StatefulWidget {
  final List<SubscriptionGroupModel> tabs;
  final VoidCallback onAddCategoryTapped;
  final int initialIndex;
  final ValueChanged<int> onChanged;

  const AnimatedTabList({
    super.key,
    required this.onAddCategoryTapped,
    required this.tabs,
    required this.initialIndex,
    required this.onChanged,
  });

  @override
  State<AnimatedTabList> createState() => _AnimatedTabListState();
}

class _AnimatedTabListState extends State<AnimatedTabList> {
  late List<String> _tabs;
  List<Offset> _offsets = [];
  int _selectedIndex = 0;

  void _initializeTabs() {
    _selectedIndex = widget.initialIndex;
    _tabs = widget.tabs.map((e) => e.name).toList()..add('+');
    _offsets = List.generate(_tabs.length, (index) => const Offset(1.5, 0));
    for (int i = 0; i < _tabs.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        if (mounted) {
          setState(() {
            _offsets[i] = Offset.zero;
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeTabs();
  }

  @override
  void didUpdateWidget(covariant AnimatedTabList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabs.length != _tabs.length - 1) {
      _initializeTabs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return AnimatedSlide(
            offset: _offsets[index],
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            child: TabChip(
              key: const Key("animatedTabBarTabChipKey"),
              onTap: () {
                if (_tabs[index] == '+') {
                  widget.onAddCategoryTapped.call();
                } else {
                  setState(() {
                    _selectedIndex = index;
                  });
                  widget.onChanged(index);
                }
              },
              label: _tabs[index],
              isSelected: _selectedIndex == index,
            ),
          );
        },
      ),
    );
  }
}

class TabChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const TabChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: Durations.medium2,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.blue
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: Center(
          child: label == '+'
              ? const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 18.0,
                )
              : Text(
                  label,
                  style: GoogleFonts.redHatDisplay(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
        ),
      ),
    );
  }
}
