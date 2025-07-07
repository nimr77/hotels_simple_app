enum HotelApiEndpoint {
  searchHotels('/search.json');

  final String path;
  const HotelApiEndpoint(this.path);
}
