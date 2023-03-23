// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sponsor _$SponsorFromJson(Map<String, dynamic> json) => Sponsor(
      id: json['id'] as int,
      name: json['name'] as String,
      level: json['level'] as String,
      logo: json['logo'] as String,
      hackathonId: json['hackathon_id'] as String?,
      link: json['link'] as String?,
      order: json['order'] as int,
    );

Map<String, dynamic> _$SponsorToJson(Sponsor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'level': instance.level,
      'logo': instance.logo,
      'hackathon_id': instance.hackathonId,
      'link': instance.link,
      'order': instance.order,
    };
