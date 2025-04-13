import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:subsciption_manager/config/constants/colors.dart';

class CustomTabBar extends StatefulWidget {
  final ValueChanged<int> onChanged;
  final int initialIndex;

  const CustomTabBar({
    super.key,
    required this.initialIndex,
    required this.onChanged,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int _selectedIndex = 0;

  void _onChanged(int fromIndex) {
    if (fromIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = _selectedIndex == 0 ? 1 : 0;
      });
      widget.onChanged(_selectedIndex);
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Container(
      height: 40.0,
      width: width * 0.36,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedAlign(
            key: const Key("customTabBarAnimatedAlignKey"),
            duration: Durations.medium1,
            alignment: _selectedIndex == 0
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              height: 42.0,
              width: width * 0.24,
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
          SizedBox(
            height: 42.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => _onChanged(0),
                          child: Icon(
                            _selectedIndex == 0
                                ? Icons.dashboard_customize
                                : Icons.dashboard_customize_outlined,
                            key: const Key("dashboardIconKey"),
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                        AnimatedSize(
                          duration: Durations.medium1,
                          child: _selectedIndex == 0
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "General",
                                      key: const Key("generalTextKey"),
                                      style: GoogleFonts.redHatDisplay(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _onChanged(1),
                        child: Icon(
                          _selectedIndex == 1
                              ? Icons.subscriptions
                              : Icons.subscriptions_outlined,
                          key: const Key("subscriptionsIconKey"),
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      AnimatedSize(
                        duration: Durations.medium1,
                        child: _selectedIndex == 1
                            ? Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "My Subs",
                                    key: const Key("mySubsTextKey"),
                                    style: GoogleFonts.redHatDisplay(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
