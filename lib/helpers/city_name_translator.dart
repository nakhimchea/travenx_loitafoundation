String cityNameTranslator({
  required String enCityName,
}) {
  final Map<String, String> cityPairs = {
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
  };
  return cityPairs[enCityName] != null
      ? cityPairs[enCityName].toString()
      : 'ភ្នំពេញ';
}
