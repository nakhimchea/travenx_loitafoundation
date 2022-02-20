String countryNameTranslator({
  required String enCountryName,
}) {
  final Map<String, String> countryPairs = {
    'KH': 'កម្ពុជា',
  };
  return countryPairs[enCountryName] != null
      ? countryPairs[enCountryName].toString()
      : 'កម្ពុជា';
}
