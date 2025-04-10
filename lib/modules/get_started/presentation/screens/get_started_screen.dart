import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:subsciption_manager/config/constants/colors.dart';
import 'package:subsciption_manager/modules/get_started/presentation/widgets/animated_logos.dart';
import 'package:subsciption_manager/modules/home/presentation/screens/home_screen.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  bool _initial = true;
  bool _tappedContinue = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _initial = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        AnimatedScale(
          scale: _tappedContinue ? 0.5 : 1.0,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInCubic,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  top: MediaQuery.sizeOf(context).height * 0.20,
                  left: 0.0,
                  right: 0.0,
                  child: const CircleCarousel()),
              AnimatedPositioned(
                bottom:
                    _initial ? -20.0 : MediaQuery.sizeOf(context).height * 0.35,
                left: 0.0,
                right: 0.0,
                duration: Durations.long4,
                curve: Curves.easeOutCubic,
                child: AnimatedOpacity(
                  opacity: _initial ? 0.0 : 1.0,
                  duration: Durations.long1,
                  curve: Curves.easeOutCubic,
                  child: Text(
                    "Manage all your subscriptions",
                    style: GoogleFonts.redHatDisplay(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 32.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              AnimatedPositioned(
                bottom:
                    _initial ? -40.0 : MediaQuery.sizeOf(context).height * 0.22,
                left: 0.0,
                right: 0.0,
                duration: Durations.long4,
                curve: Curves.easeOutCubic,
                child: AnimatedOpacity(
                  opacity: _initial ? 0.0 : 1.0,
                  curve: Curves.easeOutCubic,
                  duration: Durations.long1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      "Keep regular expenses on hand and receive timely notifications of upcoming fees",
                      style: GoogleFonts.redHatDisplay(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                left: 12.0,
                right: 12.0,
                bottom: _initial ? -60.0 : 24.0,
                duration: Durations.long4,
                curve: Curves.easeOutCubic,
                child: AnimatedOpacity(
                  opacity: _initial ? 0.0 : 1.0,
                  duration: Durations.long1,
                  curve: Curves.easeOutCubic,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _tappedContinue = true;
                      });
                      Future.delayed(const Duration(milliseconds: 700), () {
                        if (!context.mounted) return;
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            transitionsBuilder: (_, a, __, c) =>
                                FadeTransition(opacity: a, child: c),
                            pageBuilder: (_, __, ___) => const HomeScreen(),
                          ),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromHeight(52.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        backgroundColor: AppColors.blue),
                    child: Text(
                      "Get started",
                      style: GoogleFonts.redHatDisplay(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
