import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String cityNameTranslator(
  BuildContext context, {
  required String enCityName,
}) {
  final Map<String, String> cityPairs =
      AppLocalizations.of(context)!.localeName == 'km'
          ? {
              'Phnom Penh': 'ភ្នំពេញ',
              'Siem Reap': 'សៀមរាប',
              'Kampot': 'កំពត',
              'Khaet Preah Sihanouk': 'ព្រះសីហនុ',
              'Mondulkiri': 'មណ្ឌលគិរី',
              'Koh Kong': 'កោះកុង',
              'Ratanakiri': 'រតនគិរី',
              'Kep': 'កែប',
              'Preah Vihear': 'ព្រះវិហារ',
              'Kratie': 'ក្រចេះ',
              'Battambang': 'បាត់ដំបង',
              'Bantey Meanchey': 'បន្ទាយមានជ័យ',
              'Kampong Cham': 'កំពង់ចាម',
              'Kandal': 'កណ្តាល',
              'Pursat': 'ពោធិ៍សាត់',
              'Pailin': 'ប៉ៃលិន',
              'Kampong Chhnang': 'កំពង់ឆ្នាំង',
              'Kampong Speu': 'កំពង់ស្ពឺ',
              'Kampong Thom': 'កំពង់ធំ',
              'Prey Veng': 'ព្រៃវែង',
              'Stung Treng': 'ស្ទឹងត្រែង',
              'Svay Rieng': 'ស្វាយរៀង',
              'Takeo': 'តាកែវ',
              'Oddar Meanchey': 'ឧត្តរមានជ័យ',
              'Tbong Khmum': 'ត្បូងឃ្មុំ',
            }
          : {
              'Phnom Penh': 'Phnom Penh',
              'Siem Reap': 'Siem Reap',
              'Kampot': 'Kampot',
              'Khaet Preah Sihanouk': 'Sihanoukville',
              'Mondulkiri': 'Mondulkiri',
              'Koh Kong': 'Koh Kong',
              'Ratanakiri': 'Rattanakiri',
              'Kep': 'Kep',
              'Preah Vihear': 'Preah Vihear',
              'Kratie': 'Kratie',
              'Battambang': 'Battambang',
              'Bantey Meanchey': 'Banteay Meanchey',
              'Kampong Cham': 'Kampong Cham',
              'Kandal': 'Kandal',
              'Pursat': 'Pursat',
              'Pailin': 'Pailin',
              'Kampong Chhnang': 'Kampong Chhnang',
              'Kampong Speu': 'Kampong Speu',
              'Kampong Thom': 'Kampong Thom',
              'Prey Veng': 'Prey Veng',
              'Stung Treng': 'Stung Treng',
              'Svay Rieng': 'Svay Rieng',
              'Takeo': 'Takeo',
              'Oddar Meanchey': 'Oddar Meanchey',
              'Tbong Khmum': 'Tbong Khmum',
            };
  return cityPairs[enCityName] != null
      ? cityPairs[enCityName].toString()
      : 'ភ្នំពេញ';
}
