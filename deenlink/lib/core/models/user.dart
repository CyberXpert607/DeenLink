class User {
  final int id;
  final String username;
  final String email;
  final String fullName;
  final String userType;
  final String? profileImage;
  final String? profileImageUrl;
  final String? bio;
  final String? gender;
  final String? country;
  final String? phone;
  final int deenpointsBalance;
  final int isEmailVerified;
  final bool emailVerificationEnabled;
  final String accountStatus;
  final String? moderationReason;
  final String? verificationBadge;
  final String? verificationBadgeExpiresAt;
  final String createdAt;
  final Scholar? scholar;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.userType,
    this.profileImage,
    this.profileImageUrl,
    this.bio,
    this.gender,
    this.country,
    this.phone,
    required this.deenpointsBalance,
    required this.isEmailVerified,
    required this.emailVerificationEnabled,
    required this.accountStatus,
    this.moderationReason,
    this.verificationBadge,
    this.verificationBadgeExpiresAt,
    required this.createdAt,
    this.scholar,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int? ?? 0,
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      fullName: json['fullname'] as String? ?? '',
      userType: json['user_type'] as String? ?? '',
      profileImage: json['profile_image'] as String? ?? '',
      profileImageUrl: json['profile_image_url'] as String? ?? '',
      bio: json['bio'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      country: json['country'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      deenpointsBalance: json[''],
      isEmailVerified: json['is_email_verified'] as int? ?? 0,
      emailVerificationEnabled:
          json['email_verification_enabled'] as bool? ?? false,
      accountStatus: json['account_status'] as String? ?? '',
      moderationReason: json['moderation_reason'] as String? ?? '',
      verificationBadge: json['verification_badge'] as String? ?? '',
      verificationBadgeExpiresAt:
          json['verification_badge_expires_at'] as String? ?? '',
      createdAt:
          json['created_at'] as String? ?? DateTime.now().toIso8601String(),
      scholar: json['scholar'] != null
          ? Scholar.fromJson(json['scholar'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'fullname': fullName,
    'user_type': userType,
    'profile_image': profileImage,
    'profile_image_url': profileImageUrl,
    'bio': bio,
    'gender': gender,
    'country': country,
    'phone': phone,
    'deenpoints_balance': deenpointsBalance,
    'is_email_verified': isEmailVerified,
    'email_verification_enabled': emailVerificationEnabled,
    'account_status': accountStatus,
    'moderation_reason': moderationReason,
    'verification_badge': verificationBadge,
    'verification_badge_expires_at': verificationBadgeExpiresAt,
    'created_at': createdAt,
    'scholar': scholar?.toJson(),
  };
}

class Scholar {
  int id;
  int userId;
  final String? displayName;
  final String? phone;
  final String? fieldsOfKnowledge;
  final String? otherField;
  final String? madhhab;
  final String? institute;
  final String? yearsOfStudy;
  final String? teachers;
  final String? approvalStatus;
  final String? approvalNotes;
  final String? reviewedAt;
  final String? certificatePath;
  final String? recommendationPath;
  final String? verificationLinks;
  final String? title;
  final String? aqeedah;
  final String? level;

  Scholar({
    required this.id,
    required this.userId,
    this.displayName,
    this.phone,
    this.fieldsOfKnowledge,
    this.otherField,
    this.madhhab,
    this.institute,
    this.yearsOfStudy,
    this.teachers,
    this.approvalStatus,
    this.approvalNotes,
    this.reviewedAt,
    this.certificatePath,
    this.recommendationPath,
    this.verificationLinks,
    this.title,
    this.aqeedah,
    this.level,
  });

  factory Scholar.fromJson(Map<String, dynamic> json) {
    return Scholar(
      id: json['id'] as int? ?? 0,
      userId: json['user_id'] as int? ?? 0,
      displayName: json['display_name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      fieldsOfKnowledge: json['fields_of_knowledge'] as String? ?? '',
      otherField: json['other_field'] as String? ?? '',
      madhhab: json['madhhab'] as String? ?? '',
      institute: json['institute'] as String? ?? '',
      yearsOfStudy: json['years_of_study'] as String? ?? '',
      teachers: json['teacher'] as String? ?? '',
      approvalStatus: json['approval_status'] as String? ?? '',
      approvalNotes: json['approval_notes'] as String? ?? '',
      reviewedAt: json['reviewed_at'] as String? ?? '',
      certificatePath: json['certificate_path'] as String? ?? '',
      recommendationPath: json['recommendation_path'] as String? ?? '',
      verificationLinks: json['verification_links'] as String? ?? '',
      title: json['title'] as String? ?? '',
      aqeedah: json['aqeedah'] as String? ?? '',
      level: json['level'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'display_name': displayName,
    'phone': phone,
    'fields_of_knowledge': fieldsOfKnowledge,
    'other_field': otherField,
    'madhhab': madhhab,
    'institute': institute,
    'years_of_study': yearsOfStudy,
    'teachers': teachers,
    'approval_status': approvalStatus,
    'approval_notes': approvalNotes,
    'reviewed_at': reviewedAt,
    'certificate_path': certificatePath,
    'recommendation_path': recommendationPath,
    'verification_links': verificationLinks,
    'title': title,
    'aqeedah': aqeedah,
    'level': level,
  };
}
