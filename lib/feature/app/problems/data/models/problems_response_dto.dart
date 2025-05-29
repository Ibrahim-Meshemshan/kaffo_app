import 'package:json_annotation/json_annotation.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problems_response_entity.dart';

part 'problems_response_dto.g.dart';

@JsonSerializable()
class ProblemsResponseDto {
  List<ProblemContentDto>? content;
  PageableBean? pageable;
  bool? last;
  num? totalPages;
  num? totalElements;
  bool? first;
  num? size;
  num? number;
  SortBean? sort;
  num? numberOfElements;
  bool? empty;

  ProblemsResponseDto({
    this.content,
    this.pageable,
    this.last,
    this.totalPages,
    this.totalElements,
    this.first,
    this.size,
    this.number,
    this.sort,
    this.numberOfElements,
    this.empty,
  });

  factory ProblemsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProblemsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemsResponseDtoToJson(this);
}

@JsonSerializable()
class PageableBean {
  num pageNumber;
  num pageSize;
  SortBean sort;
  num offset;
  bool paged;
  bool unpaged;

  PageableBean({
    required this.pageNumber,
    required this.pageSize,
    required this.sort,
    required this.offset,
    required this.paged,
    required this.unpaged,
  });

  factory PageableBean.fromJson(Map<String, dynamic> json) =>
      _$PageableBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PageableBeanToJson(this);
}

@JsonSerializable()
class SortBean {
  bool? sorted;
  bool? empty;
  bool? unsorted;

  SortBean({this.sorted, this.empty, this.unsorted});

  factory SortBean.fromJson(Map<String, dynamic> json) =>
      _$SortBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SortBeanToJson(this);
}

@JsonSerializable()
class ProblemContentDto extends ProblemsContentEntity {
  ProblemContentDto({
    super.id,
    super.title,
    super.description,
    super.isReal,
    super.forContribution,
    super.forDonation,
    super.submissionDate,
    super.status,
    super.addressId,
    super.submittedByUserId,
    super.approvedByUserId,
    super.categoryId,
  });

  factory ProblemContentDto.fromJson(Map<String, dynamic> json) =>
      _$ProblemContentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemContentDtoToJson(this);
}
