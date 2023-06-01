class category{
  late int id;
  late String name;
 category({
    required this.id,
  }) : name = getNameById(id)!;

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['name'] = this.name;
  return data;}

  static final Map<int, String> idToName = {
    1: "نجار",
    2: "حداد",
    3: "كهربائي",
    4: "تعقيم",
    5: "سباك",
    6: "نقاش",
    7: "زجاج",
    8: "محاره",
    9: "ستائر"
  };

  static String? getNameById(int id) {
    return idToName[id];
  }
  
}
