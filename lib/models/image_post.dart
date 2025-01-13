
class ImagePost {
    final int? id;
    final String? name;
    final String? pictureMedium;
    final String? link;

    ImagePost({
        required this.id,
        required this.name,
        required this.pictureMedium,
        required this.link,
    });

    factory ImagePost.fromJson(Map<String, dynamic> json) => ImagePost(
        id: json["id"] != null ? (json['id'] as num?)?.toInt() : null,
        name: json["name"] != null ? (json['name'] as String?)?.toString() : '',
        pictureMedium: json["picture_medium"] != null ? (json['picture_medium'] as String?)?.toString() : '',
        link: json["link"] != null ? (json['link'] as String?)?.toString() : ''
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "picture_medium": pictureMedium,
        "link": link,
    };
}
