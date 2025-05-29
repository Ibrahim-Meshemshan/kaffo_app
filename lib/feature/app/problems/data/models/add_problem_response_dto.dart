import 'package:json_annotation/json_annotation.dart';
import 'package:kaffo/feature/app/problems/domain/entities/add_problem_response_entity.dart';

part 'add_problem_response_dto.g.dart';

@JsonSerializable()
class AddProblemResponseDto extends AddProblemResponseEntity{


  AddProblemResponseDto({super.id, super.title, super.description, super.isReal, super.forContribution, super.forDonation, super.submissionDate, super.status, super.rejectionReason, super.addressId, super.submittedByUserId, super.categoryId});

  factory AddProblemResponseDto.fromJson(Map<String, dynamic> json) => _$AddProblemResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddProblemResponseDtoToJson(this);
}

