import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, displayScaleFactor, Palette;
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
          AppLocalizations.of(context)!.pvLabel,
          textScaleFactor: displayScaleFactor,
          style: AppLocalizations.of(context)!.localeName == 'km'
              ? Theme.of(context).primaryTextTheme.titleLarge
              : Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10.0),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ProvinceCard(
                    modelProvince: modelProvinces(context).elementAt(0)),
                _ProvinceCard(
                    modelProvince: modelProvinces(context).elementAt(1)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ProvinceCard(
                    modelProvince: modelProvinces(context).elementAt(2)),
                _ProvinceCard(modelProvince: modelProvinces(context).last),
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
      onTap: () => modelProvince.label == modelProvinces(context).last.label
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
                gradient: modelProvince != modelProvinces(context).last
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
                    textScaleFactor: displayScaleFactor * 5 / 6,
                    style: AppLocalizations.of(context)!.localeName == 'km'
                        ? Theme.of(context)
                            .primaryTextTheme
                            .displayLarge!
                            .copyWith(color: Color(0xDDFFFFFF))
                        : Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: Color(0xDDFFFFFF)),
                    overflow:
                        kIsWeb ? TextOverflow.clip : TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
