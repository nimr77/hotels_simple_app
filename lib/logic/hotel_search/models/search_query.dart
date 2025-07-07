class SearchQuery {
  final String engine;
  final String q;
  final String gl;
  final String hl;
  final String currency;
  final String checkInDate;
  final String checkOutDate;
  final int adults;
  final int children;

  SearchQuery({
    required this.engine,
    required this.q,
    required this.gl,
    required this.hl,
    required this.currency,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.children,
  });

  factory SearchQuery.fromMap(Map<String, dynamic> map) {
    return SearchQuery(
      engine: map['engine'] ?? '',
      q: map['q'] ?? '',
      gl: map['gl'] ?? '',
      hl: map['hl'] ?? '',
      currency: map['currency'] ?? '',
      checkInDate: map['check_in_date'] ?? '',
      checkOutDate: map['check_out_date'] ?? '',
      adults: map['adults']?.toInt() ?? 0,
      children: map['children']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'engine': engine,
    'q': q,
    'gl': gl,
    'hl': hl,
    'currency': currency,
    'check_in_date': checkInDate,
    'check_out_date': checkOutDate,
    'adults': adults,
    'children': children,
  };
}
