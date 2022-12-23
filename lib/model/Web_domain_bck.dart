class Web_domain {
  String? alphaTwoCode;
  String? name;
  List<String>? webPages;
  Null? stateProvince;
  List<String>? domains;
  String? country;

  Web_domain(
      {required this.alphaTwoCode,
      required this.name,
      required this.webPages,
      required this.stateProvince,
      required this.domains,
      required this.country});

  factory Web_domain.fromJson(Map<String, dynamic> json) {
    return Web_domain(
        alphaTwoCode: json['alpha_two_code'],
        name: json['name'],
        webPages: json['web_pages'],
        stateProvince: json['state-province'],
        domains: json['domains'],
        country: json['country']);
  }
}
