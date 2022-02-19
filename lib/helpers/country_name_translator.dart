String countryNameTranslator({
  required String enCountryName,
}) {
  final Map<String, String> countryPairs = {
    'Phnom Penh': 'ភ្នំពេញ',
  };
  return countryPairs[enCountryName] != null
      ? countryPairs[enCountryName].toString()
      : 'កម្ពុជា';
}
