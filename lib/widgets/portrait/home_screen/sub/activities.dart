import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;
import 'package:travenx_loitafoundation/models/post_object_model.dart';

class Activities extends StatelessWidget {
  final List<Activity> activities;

  const Activities({Key? key, required this.activities}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _hPadding = 8;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: kHPadding),
          child: Text(
            'សកម្មភាព',
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          height: MediaQuery.of(context).size.height / 7.8 + 55.0,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: activities.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0)
                return Padding(
                  padding: const EdgeInsets.only(left: kHPadding),
                  child: _ActivityCard(
                      activity: activities[index], hPadding: _hPadding),
                );
              else if (index == activities.length - 1)
                return Padding(
                  padding: EdgeInsets.only(right: kHPadding - _hPadding),
                  child: _ActivityCard(
                      activity: activities[index], hPadding: _hPadding),
                );
              else
                return _ActivityCard(
                    activity: activities[index], hPadding: _hPadding);
            },
          ),
        ),
      ],
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final double hPadding;
  final Activity activity;

  const _ActivityCard({
    Key? key,
    this.hPadding = 8.0,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Activity Clicked ...'),
      child: Padding(
        padding: EdgeInsets.only(right: hPadding),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 7.8,
              width: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.brightness == Brightness.light
                        ? Colors.white
                        : Theme.of(context).primaryIconTheme.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              child: activity.image,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              height: 55.0,
              width: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              child: Text(
                activity.label,
                textScaleFactor: textScaleFactor,
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
