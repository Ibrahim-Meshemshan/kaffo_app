// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProblemResponseDto _$ProblemResponseDtoFromJson(Map<String, dynamic> json) =>
    ProblemResponseDto(
      content:
          (json['content'] as List<dynamic>?)
              ?.map(
                (e) => ProblemContentDto.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      pageable:
          json['pageable'] == null
              ? null
              : PageableBean.fromJson(json['pageable'] as Map<String, dynamic>),
      last: json['last'] as bool?,
      totalPages: json['totalPages'] as num?,
      totalElements: json['totalElements'] as num?,
      first: json['first'] as bool?,
      size: json['size'] as num?,
      number: json['number'] as num?,
      sort:
          json['sort'] == null
              ? null
              : SortBean.fromJson(json['sort'] as Map<String, dynamic>),
      numberOfElements: json['numberOfElements'] as num?,
      empty: json['empty'] as bool?,
    );

Map<String, dynamic> _$ProblemResponseDtoToJson(ProblemResponseDto instance) =>
    <String, dynamic>{
      'content': instance.content,
      'pageable': instance.pageable,
      'last': instance.last,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'first': instance.first,
      'size': instance.size,
      'number': instance.number,
      'sort': instance.sort,
      'numberOfElements': instance.numberOfElements,
      'empty': instance.empty,
    };

PageableBean _$PageableBeanFromJson(Map<String, dynamic> json) => PageableBean(
  pageNumber: json['pageNumber'] as num?,
  pageSize: json['pageSize'] as num?,
  sort:
      json['sort'] == null
          ? null
          : SortBean.fromJson(json['sort'] as Map<String, dynamic>),
  offset: json['offset'] as num?,
  paged: json['paged'] as bool?,
  unpaged: json['unpaged'] as bool?,
);

Map<String, dynamic> _$PageableBeanToJson(PageableBean instance) =>
    <String, dynamic>{
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'sort': instance.sort,
      'offset': instance.offset,
      'paged': instance.paged,
      'unpaged': instance.unpaged,
    };

SortBean _$SortBeanFromJson(Map<String, dynamic> json) => SortBean(
  sorted: json['sorted'] as bool?,
  empty: json['empty'] as bool?,
  unsorted: json['unsorted'] as bool?,
);

Map<String, dynamic> _$SortBeanToJson(SortBean instance) => <String, dynamic>{
  'sorted': instance.sorted,
  'empty': instance.empty,
  'unsorted': instance.unsorted,
};

ProblemContentDto _$ProblemContentDtoFromJson(Map<String, dynamic> json) =>
    ProblemContentDto(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      isReal: json['isReal'] as bool?,
      forContribution: json['forContribution'] as bool?,
      forDonation: json['forDonation'] as bool?,
      submissionDate: json['submissionDate'] as String?,
      status: json['status'] as String?,
      addressId: (json['addressId'] as num?)?.toInt(),
      submittedByUserId: (json['submittedByUserId'] as num?)?.toInt(),
      approvedByUserId: (json['approvedByUserId'] as num?)?.toInt(),
      categoryId: (json['categoryId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProblemContentDtoToJson(ProblemContentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isReal': instance.isReal,
      'forContribution': instance.forContribution,
      'forDonation': instance.forDonation,
      'submissionDate': instance.submissionDate,
      'status': instance.status,
      'addressId': instance.addressId,
      'submittedByUserId': instance.submittedByUserId,
      'approvedByUserId': instance.approvedByUserId,
      'categoryId': instance.categoryId,
    };
