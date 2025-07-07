class SearchInformation {
  final int totalResults;

  SearchInformation({required this.totalResults});

  factory SearchInformation.fromMap(Map<String, dynamic> map) {
    return SearchInformation(totalResults: map['total_results']?.toInt() ?? 0);
  }

  Map<String, dynamic> toMap() {
    return {'total_results': totalResults};
  }
}
