import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor, Palette;
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/province_model.dart';
import 'package:travenx_loitafoundation/screens/portrait/home_screen/province_routes.dart';

class Provinces extends StatelessWidget {
  const Provinces({Key? key}) : super(key: key);

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
                _ProvinceCard(modelProvince: modelProvinces.elementAt(0)),
                _ProvinceCard(modelProvince: modelProvinces.elementAt(1)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ProvinceCard(modelProvince: modelProvinces.elementAt(2)),
                _ProvinceCard(modelProvince: modelProvinces.last),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ProvinceCard extends StatelessWidget {
  final ModelProvince modelProvince;

  _ProvinceCard({Key? key, required this.modelProvince}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => modelProvince == modelProvinces.last
          ? Navigator.push(
              context, MaterialPageRoute(builder: (_) => ProvinceRoutes()))
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ProvinceRoute(modelProvince: modelProvince))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: kVPadding),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                modelProvince.imageUrl,
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
                gradient: modelProvince != modelProvinces.last
                    ? Palette.whiteGradient
                    : Palette.blackGradient,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    modelProvince.label,
                    textScaleFactor: textScaleFactor,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Color(0xDDFFFFFF)),
                    overflow:
                        kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                  ),
                  modelProvince == modelProvinces.last
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Icon(
                            CustomOutlinedIcons.right,
                            size: 24.0,
                            color: const Color(0xDDFFFFFF),
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
