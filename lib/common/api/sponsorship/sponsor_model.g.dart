// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sponsor _$SponsorFromJson(Map<String, dynamic> json) => Sponsor(
      uid: json['uid'] as int,
      name: json['name'] as String,
      level: json['level'] as String,
      logo: json['logo'] as String,
      hackathon: json['hackathon'] as String?,
      websiteLink: json['website_link'] as String?,
      order: json['order'] as int,
    );

Map<String, dynamic> _$SponsorToJson(Sponsor instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'level': instance.level,
      'logo': instance.logo,
      'hackathon': instance.hackathon,
      'website_link': instance.websiteLink,
      'order': instance.order,
    };
