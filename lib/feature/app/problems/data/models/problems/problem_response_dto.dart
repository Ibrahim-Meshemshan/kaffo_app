import 'package:json_annotation/json_annotation.dart';
import 'package:kaffo/feature/app/problems/domain/entities/problems_response_entity.dart';

part 'problem_response_dto.g.dart';

@JsonSerializable()
class ProblemResponseDto {
  List<ProblemContentDto>? content;
  PageableBean? pageable;
  bool? last;
  num? totalPages;
  num? totalElements;
  bool? first;
  num? size;
  num ?number;
  SortBean? sort;
  num ?numberOfElements;
  bool? empty;

  ProblemResponseDto({this.content, this.pageable, this.last, this.totalPages, this.totalElements, this.first, this.size, this.number, this.sort, this.numberOfElements, this.empty});

  factory ProblemResponseDto.fromJson(Map<String, dynamic> json) => _$ProblemResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemResponseDtoToJson(this);
}

@JsonSerializable()
class PageableBean {
  num ?pageNumber;
  num? pageSize;
  SortBean? sort;
  num ?offset;
  bool? paged;
  bool? unpaged;

  PageableBean({this.pageNumber, this.pageSize, this.sort, this.offset, this.paged, this.unpaged});

  factory PageableBean.fromJson(Map<String, dynamic> json) => _$PageableBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PageableBeanToJson(this);
}

@JsonSerializable()
class SortBean {
  bool? sorted;
  bool? empty;
  bool? unsorted;

  SortBean({this.sorted, this.empty, this.unsorted});

  factory SortBean.fromJson(Map<String, dynamic> json) => _$SortBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SortBeanToJson(this);
}

@JsonSerializable()
class ProblemContentDto {
  int ?id;
  String? title;
  String? description;
  bool? isReal;
  bool? forContribution;
  bool? forDonation;
  String? submissionDate;
  String? status;
  int? addressId;
  int? submittedByUserId;
  int? approvedByUserId;
  int? categoryId;

  ProblemsContentEntity toEntity(){
    return ProblemsContentEntity(
      id: id,
      title: title,
      description: description,
      isReal: isReal,
      forContribution: forContribution,
      forDonation: forDonation,
      submissionDate: submissionDate,
      status: status,
      addressId: addressId,
      categoryId: categoryId,
      approvedByUserId: approvedByUserId,
      submittedByUserId: submittedByUserId,
    );
  }

  ProblemContentDto({this.id, this.title, this.description, this.isReal, this.forContribution, this.forDonation, this.submissionDate, this.status, this.addressId, this.submittedByUserId, this.approvedByUserId, this.categoryId});

  factory ProblemContentDto.fromJson(Map<String, dynamic> json) => _$ProblemContentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemContentDtoToJson(this);
}

