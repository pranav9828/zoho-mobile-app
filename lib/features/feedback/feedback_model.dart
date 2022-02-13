class FeedbackModel {
  String comment, createdAt, email;
  int commentId, userId;

  FeedbackModel(
      this.comment, this.createdAt, this.email, this.commentId, this.userId);

  Map<String, dynamic> toJSON() => {
        'comment': comment,
        'createdAt': createdAt,
        'email': email,
        'commentId': commentId,
        'userId': userId
      };

  static FeedbackModel fromJSON(Map<String, dynamic> json) => FeedbackModel(
      json['comment'], json['createdAt'], json['email'], 0, json['userid']);
}
