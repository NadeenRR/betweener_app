// To parse this JSON data, do
//
//     final follow = followFromJson(jsonString);

import 'dart:convert';

Follow followFromJson(String str) => Follow.fromJson(json.decode(str));

String followToJson(Follow data) => json.encode(data.toJson());

class Follow {
    int? followingCount;
    int? followersCount;
    List<dynamic>? following;
    List<dynamic>? followers;

    Follow({
        this.followingCount,
        this.followersCount,
        this.following,
        this.followers,
    });

    factory Follow.fromJson(Map<String, dynamic> json) => Follow(
        followingCount: json["following_count"],
        followersCount: json["followers_count"],
        following: json["following"] == null ? [] : List<dynamic>.from(json["following"]!.map((x) => x)),
        followers: json["followers"] == null ? [] : List<dynamic>.from(json["followers"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "following_count": followingCount,
        "followers_count": followersCount,
        "following": following == null ? [] : List<dynamic>.from(following!.map((x) => x)),
        "followers": followers == null ? [] : List<dynamic>.from(followers!.map((x) => x)),
    };
}
