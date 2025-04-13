import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:subsciption_manager/config/constants/colors.dart';
import 'package:subsciption_manager/data/models/subscription_type_model.dart';

class AnimatedStackedList extends StatefulWidget {
  final List<SubscriptionTypeModel> subscriptions;

  const AnimatedStackedList({
    super.key,
    required this.subscriptions,
  });

  @override
  State<AnimatedStackedList> createState() => _AnimatedStackedListState();
}

class _AnimatedStackedListState extends State<AnimatedStackedList> {
  late final GlobalKey<AnimatedListState> _listKey;
  late List<SubscriptionTypeModel> _items;

  void _updateList(List<SubscriptionTypeModel> newItems) {
    final toRemove = _items.where((e) => !newItems.contains(e)).toList();
    final toAdd = newItems.where((e) => !_items.contains(e)).toList();

    for (var item in toRemove) {
      setState(() {
        final index = _items.indexOf(item);
        _items.removeAt(index);
        _listKey.currentState?.removeItem(
          index,
          (context, animation) => _Child(
            animation: animation,
          ),
        );
      });
    }

    for (var item in toAdd) {
      setState(() {
        final index = newItems.indexOf(item);
        _items.insert(index, item);
        _listKey.currentState?.insertItem(index);
      });
    }
  }

  Widget _buildItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) {
    return _Child(
      subscription: index == 0 ? null : _items[index - 1],
      animation: animation,
    );
  }

  @override
  void initState() {
    super.initState();
    _listKey = GlobalKey<AnimatedListState>();
    _items = widget.subscriptions;
  }

  @override
  void didUpdateWidget(covariant AnimatedStackedList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(_items, widget.subscriptions)) {
      _updateList(widget.subscriptions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      padding: const EdgeInsets.only(
        top: 60.0,
        bottom: 200.0,
        left: 12.0,
        right: 12.0,
      ),
      initialItemCount: _items.length + 1,
      itemBuilder: _buildItem,
    );
  }
}

class _Child extends StatelessWidget {
  final SubscriptionTypeModel? subscription;
  final Animation<double> animation;

  const _Child({
    this.subscription,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 200.0;
    const double heightFactor = 0.48;
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: const Offset(0, 0),
      ).animate(animation),
      child: Align(
        heightFactor: heightFactor,
        child: Container(
          height: itemHeight,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color:
                subscription == null ? AppColors.blue : subscription!.glowColor,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: (subscription == null
                        ? AppColors.blue
                        : subscription!.glowColor)
                    .withValues(alpha: 0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              )
            ],
          ),
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subscription == null) ...{
                    const SizedBox(
                      height: 12.0,
                    ),
                  },
                  Text(
                    subscription == null
                        ? "Add a subscription"
                        : subscription!.name,
                    key: const Key("animatedStackedListItemTitleKey"),
                    style: GoogleFonts.redHatDisplay(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  if (subscription != null) ...{
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 1.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text.rich(
                        TextSpan(text: "\$ ${subscription!.amount}", children: [
                          TextSpan(
                            text:
                                " / ${subscription!.isMonthly ? "month" : "year"}",
                            style: GoogleFonts.redHatDisplay(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ]),
                        style: GoogleFonts.redHatDisplay(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  },
                ],
              ),
              if (subscription == null) ...{
                DottedBorder(
                  borderType: BorderType.Circle,
                  dashPattern: const [3, 4],
                  color: Colors.white,
                  strokeWidth: 2,
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.add_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              } else ...{
                Container(
                  width: 56.0,
                  height: 56.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Image.asset(
                      subscription!.imagePath,
                      errorBuilder: (context, _, __) => const SizedBox(),
                    ),
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
