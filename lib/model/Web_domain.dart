import 'dart:convert';

List<Web_domain> webDomainFromJson(String str) =>
    List<Web_domain>.from(json.decode(str).map((x) => Web_domain.fromJson(x)));

String webDomainToJson(List<Web_domain> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Web_domain {
  String? alphaTwoCode;
  String? name;
  List<String>? webPages;
  String? stateProvince;
  List<String>? domains;
  String? country;

  Web_domain(
      {required this.alphaTwoCode,
      required this.name,
      required this.webPages,
      required this.stateProvince,
      required this.domains,
      required this.country});

  factory Web_domain.fromJson(Map<String, dynamic> json) => Web_domain(
      alphaTwoCode : json['alpha_two_code'],
      name : json['name'],
      webPages : json['web_pages']==null?[]:List<String>.from(json["web_pages"].map((x)=>x)),
      stateProvince : json['state-province'],
      domains : json['domains']==null?[]:List<String>.from(json["web_pages"].map((x)=>x)),
      country : json['country']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alpha_two_code'] = this.alphaTwoCode;
    data['name'] = this.name;
    data['web_pages'] = this.webPages;
    data['state-province'] = this.stateProvince;
    data['domains'] = this.domains;
    data['country'] = this.country;
    return data;
  }
}
