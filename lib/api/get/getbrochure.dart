class Brochure {
  int status;
  List<Response> response;
  String message;

  Brochure({
    required this.status,
    required this.response,
    required this.message,
  });

  factory Brochure.fromJson(Map<String, dynamic> json) => Brochure(
        status: json["status"],
        response: List<Response>.from(
            json["response"].map((x) => Response.fromJson(x))),
        message: json["message"],
      );
}

class Response {
  int id;
  String name;
  int language;
  String location;

  Response({
    required this.id,
    required this.name,
    required this.language,
    required this.location,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"],
        name: json["name"],
        language: json["language"],
        location: json["location"],
      );
}
