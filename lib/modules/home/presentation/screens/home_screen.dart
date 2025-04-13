import 'package:flutter/material.dart';
import 'package:subsciption_manager/config/constants/colors.dart';
import 'package:subsciption_manager/modules/general/presentation/screens/general_screen.dart';
import 'package:subsciption_manager/modules/home/presentation/widgets/custom_tab_bar.dart';
import 'package:subsciption_manager/modules/home/presentation/widgets/rounded_icon_button.dart';
import 'package:subsciption_manager/modules/subscription/presentation/screens/subscription_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<Widget> _screens;
  late final PageController _pageController;
  late final ValueNotifier<bool> _animationNotifier;

  @override
  void initState() {
    super.initState();
    _animationNotifier = ValueNotifier(false);
    _pageController = PageController(initialPage: 1);
    _screens = [
      const GeneralScreen(
        key: Key("generalScreenKey"),
      ),
      const SubscriptionScreen(
        key: Key("subscriptionScreenKey"),
      ),
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationNotifier.value = true;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValueListenableBuilder(
                valueListenable: _animationNotifier,
                builder: (context, value, _) {
                  return AnimatedScale(
                    key: const Key("menuAnimatedScaleKey"),
                    duration: Durations.long3,
                    scale: value ? 1.0 : 0.0,
                    child: RoundedIconButton(
                      onTap: () {},
                      icon: Icons.menu_sharp,
                    ),
                  );
                }),
            ValueListenableBuilder(
                valueListenable: _animationNotifier,
                builder: (context, value, _) {
                  return AnimatedScale(
                    key: const Key("customTabBarAnimatedScaleKey"),
                    duration: Durations.long3,
                    scale: value ? 1.0 : 0.0,
                    child: CustomTabBar(
                      initialIndex: _pageController.initialPage,
                      onChanged: (int index) {
                        _pageController.jumpToPage(index);
                      },
                    ),
                  );
                }),
            ValueListenableBuilder(
                valueListenable: _animationNotifier,
                builder: (context, value, _) {
                  return AnimatedScale(
                    key: const Key("notificationAnimatedScaleKey"),
                    duration: Durations.long3,
                    scale: value ? 1.0 : 0.0,
                    child: RoundedIconButton(
                      onTap: () {},
                      icon: Icons.notifications_none_outlined,
                    ),
                  );
                }),
          ],
        ),
      ),
      body: PageView.builder(
        key: const Key("homeScreenPageViewBuilderKey"),
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _screens[index],
        itemCount: _screens.length,
      ),
    );
  }
}
