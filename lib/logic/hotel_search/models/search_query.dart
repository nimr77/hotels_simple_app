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
