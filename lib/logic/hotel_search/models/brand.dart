class Brand {
  final int id;
  final String name;
  final List<BrandChild>? children;

  Brand({required this.id, required this.name, this.children});

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      children: map['children'] != null
          ? List<BrandChild>.from(
              map['children']!.map((x) => BrandChild.fromMap(x)),
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'children': children?.map((x) => x.toMap()).toList(),
    };
  }
}

class BrandChild {
  final int id;
  final String name;

  BrandChild({required this.id, required this.name});

  factory BrandChild.fromMap(Map<String, dynamic> map) {
    return BrandChild(id: map['id']?.toInt() ?? 0, name: map['name'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}
