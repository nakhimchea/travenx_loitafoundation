import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, displayScaleFactor;
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
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.pfApStBusinessType,
            textAlign: TextAlign.justify,
            textScaleFactor: displayScaleFactor,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context).primaryTextTheme.bodyMedium
                : Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: kHPadding),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 8,
            runSpacing: 8,
            children: [
              _CategoryButton(
                isCategoryHighlight: isCategoryHighlight,
                label: AppLocalizations.of(context)!.icCamping,
                state: categories.contains(CategoryType.camping),
                onTap: () {
                  categoryPickerCallback(CategoryType.camping,
                      isRemoved: categories.contains(CategoryType.camping));
                },
              ),
              _CategoryButton(
                isCategoryHighlight: isCategoryHighlight,
                label: AppLocalizations.of(context)!.icSea,
                state: categories.contains(CategoryType.sea),
                onTap: () {
                  categoryPickerCallback(CategoryType.sea,
                      isRemoved: categories.contains(CategoryType.sea));
                },
              ),
              _CategoryButton(
                isCategoryHighlight: isCategoryHighlight,
                label: AppLocalizations.of(context)!.icTemple,
                state: categories.contains(CategoryType.temple),
                onTap: () {
                  categoryPickerCallback(CategoryType.temple,
                      isRemoved: categories.contains(CategoryType.temple));
                },
              ),
              _CategoryButton(
                isCategoryHighlight: isCategoryHighlight,
                label: AppLocalizations.of(context)!.icMountain,
                state: categories.contains(CategoryType.mountain),
                onTap: () {
                  categoryPickerCallback(CategoryType.mountain,
                      isRemoved: categories.contains(CategoryType.mountain));
                },
              ),
              _CategoryButton(
                isCategoryHighlight: isCategoryHighlight,
                label: AppLocalizations.of(context)!.icPark,
                state: categories.contains(CategoryType.park),
                onTap: () {
                  categoryPickerCallback(CategoryType.park,
                      isRemoved: categories.contains(CategoryType.park));
                },
              ),
              _CategoryButton(
                isCategoryHighlight: isCategoryHighlight,
                label: AppLocalizations.of(context)!.icResort,
                state: categories.contains(CategoryType.resort),
                onTap: () {
                  categoryPickerCallback(CategoryType.resort,
                      isRemoved: categories.contains(CategoryType.resort));
                },
              ),
              _CategoryButton(
                isCategoryHighlight: isCategoryHighlight,
                label: AppLocalizations.of(context)!.icZoo,
                state: categories.contains(CategoryType.zoo),
                onTap: () {
                  categoryPickerCallback(CategoryType.zoo,
                      isRemoved: categories.contains(CategoryType.zoo));
                },
              ),
              _CategoryButton(
                isCategoryHighlight: isCategoryHighlight,
                label: AppLocalizations.of(context)!.icLocations,
                state: categories.contains(CategoryType.locations),
                onTap: () {
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
  final bool isCategoryHighlight;
  final String label;
  final bool state;
  final void Function()? onTap;
  const _CategoryButton({
    Key? key,
    required this.isCategoryHighlight,
    required this.label,
    required this.state,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: isCategoryHighlight
              ? Theme.of(context).errorColor.withOpacity(0.5)
              : Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(26.0),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: state
                ? Theme.of(context).primaryColor.withOpacity(0.8)
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Text(
            label,
            textScaleFactor: displayScaleFactor,
            textAlign: TextAlign.center,
            style: AppLocalizations.of(context)!.localeName == 'km'
                ? Theme.of(context)
                    .primaryTextTheme
                    .bodySmall!
                    .copyWith(color: state ? Colors.white : null)
                : Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: state ? Colors.white : null),
          ),
        ),
      ),
    );
  }
}
