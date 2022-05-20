import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;
import 'package:travenx_loitafoundation/helpers/category_type.dart';

class CategorySelection extends StatelessWidget {
  final bool isCategoryHighlight;
  final List<CategoryType> categories;
  final void Function(CategoryType, {bool isRemoved}) categoryPickerCallback;
  const CategorySelection({
    Key? key,
    required this.isCategoryHighlight,
    required this.categories,
    required this.categoryPickerCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kHPadding),
      decoration: BoxDecoration(
        color: isCategoryHighlight
            ? Theme.of(context).errorColor.withOpacity(0.1)
            : Theme.of(context).bottomAppBarColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.pfApStBusinessType,
            textAlign: TextAlign.justify,
            textScaleFactor: textScaleFactor,
            style: Theme.of(context).textTheme.button,
          ),
          const SizedBox(height: kHPadding),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 7,
            children: [
              _CategoryButton(
                label: AppLocalizations.of(context)!.icCamping,
                state: categories.contains(CategoryType.camping),
                onPressed: () {
                  categoryPickerCallback(CategoryType.camping,
                      isRemoved: categories.contains(CategoryType.camping));
                },
              ),
              _CategoryButton(
                label: AppLocalizations.of(context)!.icSea,
                state: categories.contains(CategoryType.sea),
                onPressed: () {
                  categoryPickerCallback(CategoryType.sea,
                      isRemoved: categories.contains(CategoryType.sea));
                },
              ),
              _CategoryButton(
                label: AppLocalizations.of(context)!.icTemple,
                state: categories.contains(CategoryType.temple),
                onPressed: () {
                  categoryPickerCallback(CategoryType.temple,
                      isRemoved: categories.contains(CategoryType.temple));
                },
              ),
              _CategoryButton(
                label: AppLocalizations.of(context)!.icMountain,
                state: categories.contains(CategoryType.mountain),
                onPressed: () {
                  categoryPickerCallback(CategoryType.mountain,
                      isRemoved: categories.contains(CategoryType.mountain));
                },
              ),
              _CategoryButton(
                label: AppLocalizations.of(context)!.icPark,
                state: categories.contains(CategoryType.park),
                onPressed: () {
                  categoryPickerCallback(CategoryType.park,
                      isRemoved: categories.contains(CategoryType.park));
                },
              ),
              _CategoryButton(
                label: AppLocalizations.of(context)!.icResort,
                state: categories.contains(CategoryType.resort),
                onPressed: () {
                  categoryPickerCallback(CategoryType.resort,
                      isRemoved: categories.contains(CategoryType.resort));
                },
              ),
              _CategoryButton(
                label: AppLocalizations.of(context)!.icZoo,
                state: categories.contains(CategoryType.zoo),
                onPressed: () {
                  categoryPickerCallback(CategoryType.zoo,
                      isRemoved: categories.contains(CategoryType.zoo));
                },
              ),
              _CategoryButton(
                label: AppLocalizations.of(context)!.icLocations,
                state: categories.contains(CategoryType.locations),
                onPressed: () {
                  categoryPickerCallback(CategoryType.locations,
                      isRemoved: categories.contains(CategoryType.locations));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final String label;
  final bool state;
  final void Function()? onPressed;
  const _CategoryButton({
    Key? key,
    required this.label,
    required this.state,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color?>(state
            ? Theme.of(context).primaryColor.withOpacity(0.8)
            : Theme.of(context).scaffoldBackgroundColor),
        overlayColor: MaterialStateProperty.all<Color?>(
            Theme.of(context).textTheme.button!.color!.withOpacity(0.1)),
        shape: MaterialStateProperty.all<OutlinedBorder?>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          label,
          textScaleFactor: textScaleFactor,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .button!
              .copyWith(color: state ? Colors.white : null),
        ),
      ),
    );
  }
}
