class SearchMetadata {
  final String id;
  final String status;
  final String jsonEndpoint;
  final String createdAt;
  final String processedAt;
  final String googleHotelsUrl;
  final String rawHtmlFile;
  final String prettifyHtmlFile;
  final double totalTimeTaken;

  SearchMetadata({
    required this.id,
    required this.status,
    required this.jsonEndpoint,
    required this.createdAt,
    required this.processedAt,
    required this.googleHotelsUrl,
    required this.rawHtmlFile,
    required this.prettifyHtmlFile,
    required this.totalTimeTaken,
  });

  factory SearchMetadata.fromMap(Map<String, dynamic> map) {
    return SearchMetadata(
      id: map['id'] ?? '',
      status: map['status'] ?? '',
      jsonEndpoint: map['json_endpoint'] ?? '',
      createdAt: map['created_at'] ?? '',
      processedAt: map['processed_at'] ?? '',
      googleHotelsUrl: map['google_hotels_url'] ?? '',
      rawHtmlFile: map['raw_html_file'] ?? '',
      prettifyHtmlFile: map['prettify_html_file'] ?? '',
      totalTimeTaken: map['total_time_taken']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'json_endpoint': jsonEndpoint,
      'created_at': createdAt,
      'processed_at': processedAt,
      'google_hotels_url': googleHotelsUrl,
      'raw_html_file': rawHtmlFile,
      'prettify_html_file': prettifyHtmlFile,
      'total_time_taken': totalTimeTaken,
    };
  }
}
