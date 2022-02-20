import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show textScaleFactor, briefIconSize;
import 'package:travenx_loitafoundation/models/icon_menu_model.dart';
import 'package:travenx_loitafoundation/models/post_object_model.dart';

class BriefDescriptionCard extends StatelessWidget {
  final PostObject post;

  const BriefDescriptionCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ModelIconMenu> _briefDescriptionIcons = [
      ModelIconMenu(
        icon: SvgPicture.asset(
          'assets/icons/home_screen/sub/star.svg',
          width: briefIconSize,
          height: briefIconSize,
        ),
        label: 'វាយតម្លៃ',
      ),
      ModelIconMenu(
        icon: SvgPicture.asset(
          'assets/icons/home_screen/sub/direction.svg',
          width: briefIconSize,
          height: briefIconSize,
        ),
        label: 'ចម្ងាយ',
      ),
      ModelIconMenu(
        icon: SvgPicture.asset(
          'assets/icons/home_screen/sub/weather.svg',
          width: briefIconSize,
          height: briefIconSize,
        ),
        label: 'ព្យាករណ៍',
      ),
      ModelIconMenu(
        icon: SvgPicture.asset(
          'assets/icons/home_screen/sub/view.svg',
          width: briefIconSize,
          height: briefIconSize,
        ),
        label: 'អ្នកចូលមើល',
      ),
    ];

    final int _distance = 500;
    return Container(
      height: MediaQuery.of(context).size.height / 8.12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).bottomAppBarColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _CardRowItem(
            icon: _briefDescriptionIcons.elementAt(0).icon,
            text: post.ratings.toStringAsFixed(1),
            subText: _briefDescriptionIcons.elementAt(0).label,
          ),
          _CardRowItem(
            icon: _briefDescriptionIcons.elementAt(1).icon,
            text: (_distance > 1000)
                ? '${(_distance / 1000).toStringAsFixed(0)}km'
                : '${_distance.toStringAsFixed(0)}m',
            subText: _briefDescriptionIcons.elementAt(1).label,
          ),
          _CardRowItem(
            icon: _briefDescriptionIcons.elementAt(2).icon,
            text: '32c',
            subText: _briefDescriptionIcons.elementAt(2).label,
          ),
          _CardRowItem(
            icon: _briefDescriptionIcons.elementAt(3).icon,
            text: (post.views > 1000)
                ? '${(post.views / 1000).toStringAsFixed(1)}k'
                : post.views.toStringAsFixed(0),
            subText: _briefDescriptionIcons.elementAt(3).label,
          ),
        ],
      ),
    );
  }
}

class _CardRowItem extends StatelessWidget {
  final Widget icon;
  final String text;
  final String subText;

  const _CardRowItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.subText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(height: 5.0),
        Text(
          text,
          textScaleFactor: textScaleFactor,
          style:
              Theme.of(context).textTheme.headline3!.copyWith(fontFamily: ''),
        ),
        const SizedBox(height: 5.0),
        Text(
          subText,
          textScaleFactor: textScaleFactor,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
