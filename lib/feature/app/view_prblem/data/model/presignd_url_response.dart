class PresignedUrlResponse {
  final String presignedUrl;
  final String s3Key;
  final int photoId;

  PresignedUrlResponse({
    required this.presignedUrl,
    required this.s3Key,
    required this.photoId,
  });

  factory PresignedUrlResponse.fromJson(Map<String, dynamic> json) {
    return PresignedUrlResponse(
      presignedUrl: json["presignedUrl"],
      s3Key: json["s3Key"],
      photoId: json["photoId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "presignedUrl": presignedUrl,
    "s3Key": s3Key,
    "photoId": photoId,
  };
}