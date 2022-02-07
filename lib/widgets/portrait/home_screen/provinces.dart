import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor, Palette;
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/province_model.dart';

class Provinces extends StatelessWidget {
  final List<Province> provinces;

  const Provinces({
    Key? key,
    required this.provinces,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'ទូទាំងប្រទេស',
          textScaleFactor: textScaleFactor,
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(height: 10.0),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ProvinceCard(province: provinces[0]),
                _ProvinceCard(province: provinces[1]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ProvinceCard(province: provinces[2]),
                _ProvinceCard(
                  // Special condition for image and label of HomeScreen card
                  province: Province(
                    label: 'ទាំងអស់',
                    imageUrl: 'assets/images/home_screen/default.jpg',
                  ),
                  isLast: true,
                  provinces: provinces,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ProvinceCard extends StatelessWidget {
  final bool isLast;
  final Province province;
  final List<Province>? provinces;

  _ProvinceCard({
    Key? key,
    this.isLast = false,
    required this.province,
    this.provinces,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {}, //TODO: Route to the next page
      // () => isLast
      // ? Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (_) => ProvincesSubscreen(provinces: provinces!),
      //     ),
      //   )
      // : Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (_) => ProvinceSubscreen(province: province),
      //     ),
      //   ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: kVPadding),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image(
                image: AssetImage(province.imageUrl),
                height: MediaQuery.of(context).size.height / 8,
                width:
                    (MediaQuery.of(context).size.width - (kHPadding * 2) - 10) /
                        2,
                fit: BoxFit.cover,
                color: Colors.black26,
                colorBlendMode: BlendMode.srcOver,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height / 8,
              width:
                  (MediaQuery.of(context).size.width - (kHPadding * 2) - 10) /
                      2,
              decoration: BoxDecoration(
                gradient:
                    !isLast ? Palette.whiteGradient : Palette.blackGradient,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    province.label,
                    textScaleFactor: textScaleFactor,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Color(0xDDFFFFFF)),
                    overflow: TextOverflow.ellipsis,
                  ),
                  isLast
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Icon(
                            CustomOutlinedIcons.right,
                            size: 24.0, //Todo: Here is no change yet
                            color: Color(0xDDFFFFFF),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
